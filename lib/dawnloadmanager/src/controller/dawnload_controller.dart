import 'package:flutter/foundation.dart';

import '../model/dawnload_task.dart';


class DownloadController
    extends ChangeNotifier {

  final List<DownloadTask>
  downloads = [];

  List<DownloadTask> get tasks =>
      downloads;

  void addTask(
      DownloadTask task,
      ) {
    downloads.add(task);

    notifyListeners();
  }

  void updateProgress(
      String id,
      double progress,
      ) {
    final task = downloads
        .firstWhere(
          (e) => e.id == id,
    );

    task.progress = progress;

    notifyListeners();
  }
}