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

      // Auto-generate filename if not provided
      String finalFileName;

      if (fileName != null && fileName.isNotEmpty) {
        finalFileName = fileName;
      } else {
        try {
          final uri = Uri.parse(url);

          if (uri.pathSegments.isNotEmpty &&
              uri.pathSegments.last.isNotEmpty) {
            finalFileName = uri.pathSegments.last;
          } else {
            finalFileName =
            "file_${DateTime.now().millisecondsSinceEpoch}";
          }
        } catch (_) {
          finalFileName =
          "file_${DateTime.now().millisecondsSinceEpoch}";
        }
      }

      FileDownloader.downloadFile(
        url: url,
        name: finalFileName,

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