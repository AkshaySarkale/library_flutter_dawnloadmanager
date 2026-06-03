import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_filex/open_filex.dart';

class DownloadManager {
  /// Start Download
  static Future<String?> download({
    required String url,
    required String saveDir,
    String? fileName,
  }) async {
    try {
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: saveDir,
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: true,
      );

      return taskId;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Pause Download
  static Future<void> pause(String taskId) async {
    await FlutterDownloader.pause(taskId: taskId);
  }

  /// Resume Download
  static Future<String?> resume(String taskId) async {
    return await FlutterDownloader.resume(taskId: taskId);
  }

  /// Cancel Download
  static Future<void> cancel(String taskId) async {
    await FlutterDownloader.cancel(taskId: taskId);
  }

  /// Open Downloaded File
  static Future<void> openFile(String path) async {
    await OpenFilex.open(path);
  }

  /// Remove Download
  static Future<void> remove(String taskId) async {
    await FlutterDownloader.remove(
      taskId: taskId,
      shouldDeleteContent: true,
    );
  }
}