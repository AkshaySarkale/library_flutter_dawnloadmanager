import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_filex/open_filex.dart';

class DownloadManager {
  /// Initialize downloader
  static Future<void> initialize() async {
    await FlutterDownloader.initialize(
      debug: true,
      ignoreSsl: true,
    );
  }

  /// Start download
  static Future<String?> download({
    required String url,
    required String saveDir,
    String? fileName,
  }) async {
    try {
      print("Download URL : $url");
      print("Save Directory : $saveDir");

      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: saveDir,
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: true,
      );

      print("Task ID : $taskId");

      return taskId;
    } catch (e) {
      print("Download Error : $e");
      rethrow;
    }
  }

  /// Pause download
  static Future<void> pause(String taskId) async {
    await FlutterDownloader.pause(taskId: taskId);
  }

  /// Resume download
  static Future<String?> resume(String taskId) async {
    return await FlutterDownloader.resume(taskId: taskId);
  }

  /// Retry failed download
  static Future<String?> retry(String taskId) async {
    return await FlutterDownloader.retry(taskId: taskId);
  }

  /// Cancel download
  static Future<void> cancel(String taskId) async {
    await FlutterDownloader.cancel(taskId: taskId);
  }

  /// Remove download
  static Future<void> remove(String taskId) async {
    await FlutterDownloader.remove(
      taskId: taskId,
      shouldDeleteContent: true,
    );
  }

  /// Open downloaded file
  static Future<void> openFile(String filePath) async {
    await OpenFilex.open(filePath);
  }

  /// Load all tasks
  static Future<List<DownloadTask>?> loadTasks() async {
    return await FlutterDownloader.loadTasks();
  }

  /// Load only tasks with raw query
  static Future<List<DownloadTask>?> loadTasksWithRawQuery(
      String query,
      ) async {
    return await FlutterDownloader.loadTasksWithRawQuery(
      query: query,
    );
  }
}