import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'src/services/dawnload_services.dart';
import 'src/services/notification_services.dart';

class DownloadManager {
  /// Returns the path inside the public Downloads folder.
  /// e.g. /storage/emulated/0/Download/my_photo.jpg
  static String getPublicDownloadPath(String fileName) {
    if (Platform.isAndroid) {
      return '/storage/emulated/0/Download/$fileName';
    }
    // iOS fallback — adjust if needed
    return '/Downloads/$fileName';
  }

  static Future<void> _requestPermissions() async {
    if (!Platform.isAndroid) return;
    await Permission.notification.request();
    final manageStatus = await Permission.manageExternalStorage.status;
    if (!manageStatus.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    final storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      await Permission.storage.request();
    }
  }
  static Future<void> download({
    required String url,
    required String fileName,
    String? savePath,
    VoidCallback? onStarted,
    Function(double)? onProgress,
    Function(String filePath)? onCompleted,
    Function(String error)? onFailed,
  }) async {
    try {
      await NotificationService.initialize();
      // 2. Request permissions
      await _requestPermissions();
      // 3. Resolve save path
      final resolvedPath = savePath ?? getPublicDownloadPath(fileName);
      // 4. Notify start
      onStarted?.call();
      await NotificationService.showStarted();
      // 5. Stream-download with progress
      final service = DownloadService();
      await service.download(
        url: url,
        savePath: resolvedPath,
        onProgress: (progress) {
          onProgress?.call(progress);
          // Update notification every ~5% to avoid flooding
          final percent = (progress * 100).toInt();
          if (percent % 5 == 0) {
            NotificationService.showProgress(percent);
          }
        },
      );

      // 6. Completed
      await NotificationService.showCompleted(resolvedPath);
      onCompleted?.call(resolvedPath);
    } catch (e) {
      await NotificationService.showFailed();
      onFailed?.call(e.toString());
    }
  }
}