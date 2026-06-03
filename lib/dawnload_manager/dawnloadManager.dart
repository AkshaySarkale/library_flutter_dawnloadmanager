import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class DownloadManager extends StatefulWidget {
  final String url;

  const DownloadManager({
    super.key,
    required this.url,
  });

  @override
  State<DownloadManager> createState() => _DownloadManagerState();
}

class _DownloadManagerState extends State<DownloadManager> {
  double? progress;

  Future<void> fileDownload() async {
    try {
      FileDownloader.downloadFile(
        url: widget.url.trim(),

        onProgress: (fileName, progressValue) {
          setState(() {
            progress = progressValue;
          });
        },

        onDownloadCompleted: (path) {
          debugPrint("Downloaded File: $path");

          setState(() {
            progress = null;
          });

          // TODO:
          // Show notification
          // Open file
        },

        onDownloadError: (errorMessage) {
          debugPrint(errorMessage);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: fileDownload,
          child: const Text("Download"),
        ),

        if (progress != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: progress,
                ),
                const SizedBox(height: 10),
                Text(
                  "${(progress! * 100).toStringAsFixed(0)}%",
                ),
              ],
            ),
          ),
      ],
    );
  }
}