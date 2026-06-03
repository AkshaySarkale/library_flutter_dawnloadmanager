import 'dawnload_status.dart';

class DownloadTask {
  String id;
  String url;
  String savePath;

  double progress;

  DownloadStatus status;

  DownloadTask({
    required this.id,
    required this.url,
    required this.savePath,
    this.progress = 0,
    this.status = DownloadStatus.idle,
  });
}