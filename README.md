# Flutter Download Manager

A reusable Flutter download manager with built-in background services, notifications, progress tracking, and file opening capabilities.

---
## When To Use

Use `DownloadManager` when you need:

* Downloading photos and videos
* Downloading PDF files and documents
* Saving files to the public Downloads folder
* Background download tracking
* Automatic system notifications for download progress
* Tap-to-open downloaded files functionality
* Clean and consistent download management

This package helps reduce repetitive download management code and provides a reliable solution for downloading and handling files in Flutter applications.

## Perfect For

✅ Media Heavy Apps
✅ PDF & Document Viewers
✅ Enterprise Apps
✅ File-Based Applications
✅ Fast Flutter Development
✅ Reusable Download Systems

## Features

| Feature              | Supported |
| -------------------- | --------- |
| Background Download  | ✅         |
| Real-time Progress   | ✅         |
| System Notifications | ✅         |
| Tap to Open File     | ✅         |
| Save to Downloads    | ✅         |
| Auto Permissions     | ✅         |

---
## Parameters for `download`

| Parameter | Type    | Default  | Description                                 |
| --------- | ------- | -------- | ------------------------------------------- |
| url       | String  | Required | URL of the file to download                 |
| saveDir   | String  | Required | Directory path where the file will be saved |
| fileName  | String? | null     | Optional name for the file (e.g., photo.jpg) |

---

# Installation

Add dependency in `pubspec.yaml`

```yaml
dependencies:
  library_flutter_dawnloadmanager:
    git:
      url: https://github.com/Excelsior-Technologies-Community/library_flutter_dawnloadmanager.git
```
*(Note: Use `path: ../library_flutter_dawnloadmanager` if testing locally in the same workspace)*

---

# Import

```dart
import 'package:library_flutter_dawnloadmanager/library_flutter_dawnloadmanager.dart';
```

---

# Initialization

Before using the download manager, initialize it in your `main()` function:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DownloadManager.initialize();
  runApp(const MyApp());
}
```

---

# Usage Examples

## Download a file
```dart
String? taskId = await DownloadManager.download(
  url: "https://example.com/file.pdf",
  saveDir: "/storage/emulated/0/Download",
  fileName: "sample.pdf",
);
```

## Get All Download Tasks
```dart
final tasks = await DownloadManager.loadTasks();
tasks?.forEach((task) {
  print("Task ID: ${task.taskId}, Status: ${task.status}, Progress: ${task.progress}");
});
```

## Manage Download Tasks
```dart
// Pause download
await DownloadManager.pause(taskId);

// Resume download
await DownloadManager.resume(taskId);

// Retry failed download
await DownloadManager.retry(taskId);

// Cancel download
await DownloadManager.cancel(taskId);

// Remove task and delete file
await DownloadManager.remove(taskId);
```

## Open Downloaded File
```dart
await DownloadManager.openFile(filePath);
```

---

# Full Example

Here is a complete implementation showing how to use `DownloadManager` in a Flutter UI. 

> **Note:** This example requires `path_provider` and `permission_handler` in your `pubspec.yaml`.

```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:library_flutter_dawnloadmanager/library_flutter_dawnloadmanager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  final TextEditingController txtCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDownloader();
  }

  Future<void> _initDownloader() async {
    await DownloadManager.initialize();
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      await [
        Permission.storage,
        Permission.notification,
      ].request();
      
      // For Android 11+ (API 30+)
      if (await Permission.manageExternalStorage.isDenied) {
        await Permission.manageExternalStorage.request();
      }
    }
  }

  Future<void> startDownload() async {
    final String url = txtCtrl.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a URL")),
      );
      return;
    }

    try {
      await _requestPermissions();

      // Extract filename from URL
      String? fileName;
      try {
        final uri = Uri.parse(url);
        if (uri.pathSegments.isNotEmpty) {
          fileName = uri.pathSegments.last;
        }
      } catch (_) {}
      
      fileName ??= "file_${DateTime.now().millisecondsSinceEpoch}";

      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        throw Exception("Could not access storage directory");
      }

      final saveDir = directory.path;
      final dir = Directory(saveDir);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Download Started...")),
      );

      // Call the library's download method
      final taskId = await DownloadManager.download(
        url: url,
        saveDir: saveDir,
        fileName: fileName,
      );

      if (taskId == null) {
        throw Exception("Failed to start download task");
      }

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    txtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Download Manager"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: txtCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Paste file URL here",
                prefixIcon: Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: startDownload,
                child: const Text("Download"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---
## Demo
<img src="assets/demo.gif" height="300" alt="Demo GIF">

---
## License

MIT License

Copyright (c) 2026 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
