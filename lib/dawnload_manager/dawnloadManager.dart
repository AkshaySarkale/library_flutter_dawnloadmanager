import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class DownloadManager {
  static Future<void> download({
    required String url,
    String? fileName,
    Function()? onStarted,
    Function(double progress)? onProgress,
    Function(String path)? onCompleted,
    Function(String error)? onFailed,
  }) async {
    try {
      onStarted?.call();

      FileDownloader.downloadFile(
        url: url,
        name: fileName,

        onProgress: (fileName, progress) {
          onProgress?.call(progress);
        },

        onDownloadCompleted: (path) {
          onCompleted?.call(path);
        },

        onDownloadError: (error) {
          onFailed?.call(error.toString());
        },
      );
    } catch (e) {
      onFailed?.call(e.toString());
    }
  }
}