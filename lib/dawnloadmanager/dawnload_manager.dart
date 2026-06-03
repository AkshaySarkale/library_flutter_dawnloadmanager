import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DownloadManager {
  static Future<void> download({
    required String url,
    required String savePath,
    VoidCallback? onStarted,
    Function(double)? onProgress,
    VoidCallback? onCompleted,
    Function(String)? onFailed,
  }) async {
    try {
      onStarted?.call();

      final response = await http.get(Uri.parse(url));

      final file = File(savePath);

      if (!await file.parent.exists()) {
        await file.parent.create(recursive: true);
      }

      await file.writeAsBytes(response.bodyBytes);

      onProgress?.call(100);

      onCompleted?.call();
    } catch (e) {
      onFailed?.call(e.toString());
    }
  }
}