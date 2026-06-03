import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {

  final VoidCallback onDownload;

  const DownloadButton({
    super.key,
    required this.onDownload,
  });

  @override
  Widget build(
      BuildContext context) {
    return IconButton(
      onPressed: onDownload,
      icon:
      const Icon(Icons.download),
    );
  }
}