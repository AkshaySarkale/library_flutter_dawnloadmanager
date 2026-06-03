import 'package:flutter/material.dart';

class DownloadProgress
    extends StatelessWidget {

  final double progress;

  const DownloadProgress({
    super.key,
    required this.progress,
  });

  @override
  Widget build(
      BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
    );
  }
}