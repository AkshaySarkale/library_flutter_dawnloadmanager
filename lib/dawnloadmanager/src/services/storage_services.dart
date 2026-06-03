import 'dart:io';

class StorageService {
  static Future<File> createFile(
      String path,
      ) async {
    final file = File(path);

    await file.parent.create(
      recursive: true,
    );

    return file;
  }
}