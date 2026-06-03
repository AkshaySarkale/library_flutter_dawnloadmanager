class DownloadResult {
  final bool success;
  final String message;
  final String? filePath;

  DownloadResult({
    required this.success,
    required this.message,
    this.filePath,
  });
}