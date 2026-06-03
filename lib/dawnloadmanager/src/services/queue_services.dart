
import '../model/dawnload_task.dart';

class QueueService {
  final List<DownloadTask> queue = [];

  void addTask(
      DownloadTask task,
      ) {
    queue.add(task);
  }

  void removeTask(
      DownloadTask task,
      ) {
    queue.remove(task);
  }

  List<DownloadTask> getTasks() {
    return queue;
  }
}