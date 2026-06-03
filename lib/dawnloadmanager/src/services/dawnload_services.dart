import 'dart:io';
import 'package:http/http.dart' as http;

class DownloadService {
  final http.Client _client = http.Client();
  /// Downloads a file from [url] and saves it to [savePath].
  /// Reports real-time progress (0.0 → 1.0) via [onProgress].
  Future<void> download({
    required String url,
    required String savePath,
    Function(double)? onProgress,
  }) async {
    try {
      final request = http.Request('GET', Uri.parse(url));
      final response = await _client.send(request);

      final contentLength = response.contentLength ?? 0;
      int bytesReceived = 0;

      // Ensure parent directory exists
      final file = File(savePath);
      await file.parent.create(recursive: true);

      final sink = file.openWrite();

      await for (final chunk in response.stream) {
        sink.add(chunk);
        bytesReceived += chunk.length;

        if (contentLength > 0) {
          final progress = bytesReceived / contentLength;
          onProgress?.call(progress.clamp(0.0, 1.0));
        }
      }

      await sink.flush();
      await sink.close();
    } catch (e) {
      rethrow;
    } finally {
      _client.close();
    }
  }

  Future<void> pause() async {}

  Future<void> resume() async {}

  Future<void> cancel() async {
    _client.close();
  }
}