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

| Feature             | Supported |
| ------------------- | --------- |
| Background Download | ✅         |
| Real-time Progress  | ✅         |
| System Notifications| ✅         |
| Tap to Open File    | ✅         |
| Save to Downloads   | ✅         |
| Auto Permissions    | ✅         |

---
## Parameters

| Parameter   | Type               | Default  | Description                                      |
| ----------- | ------------------ | -------- | ------------------------------------------------ |
| url         | String             | Required | URL of the file to download                      |
| fileName    | String             | Required | Name of the file to save (e.g., photo.jpg)       |
| savePath    | String?            | null     | Optional custom save path                        |
| onStarted   | VoidCallback?      | null     | Callback when download starts                    |
| onProgress  | Function(double)?  | null     | Callback with download progress (0.0 to 1.0)     |
| onCompleted | Function(String)?  | null     | Callback when download completes with file path  |
| onFailed    | Function(String)?  | null     | Callback when download fails with error message  |


# Installation

Add dependency in `pubspec.yaml`

```yaml
dependencies:
  library_flutter_dawnloadmanager:
    git:
      url: https://github.com/AkshaySarkale/library_flutter_dawnloadmanager.git
```
*(Note: Use `path: ../library_flutter_dawnloadmanager` if testing locally in the same workspace)*

---

# Import

```dart
import 'package:library_flutter_dawnloadmanager/library_flutter_dawnloadmanager.dart';
```

---

# Example for downloading photos, videos

```dart
IconButton(
  icon: const Icon(Icons.download),
  onPressed: () async {
    await DownloadManager.download(
      url: "https://picsum.photos/200",
      fileName: "dummy.jpg",
      savePath: "/storage/emulated/0/Download/dummy.jpg",
      onStarted: () {
        debugPrint("Download Started");
      },
      onProgress: (progress) {
        debugPrint("Progress: ${(progress * 100).toStringAsFixed(1)}%");
      },
      onCompleted: (filePath) {
        debugPrint("Download Completed: $filePath");
      },
      onFailed: (error) {
        debugPrint("Error: $error");
      },
    );
  },
)
```

---

# Example for downloading PDF

```dart
IconButton(
  icon: const Icon(Icons.download),
  onPressed: () async {
    await DownloadManager.download(
      url: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
      fileName: "dummy.pdf",
      savePath: "/storage/emulated/0/Download/dummy.pdf",
      onStarted: () {
        debugPrint("Download Started");
      },
      onProgress: (progress) {
        debugPrint("Progress: ${(progress * 100).toStringAsFixed(1)}%");
      },
      onCompleted: (filePath) {
        debugPrint("Download Completed: $filePath");
      },
      onFailed: (error) {
        debugPrint("Error: $error");
      },
    );
  },
)
```
## demo
<img src="assets/demo.gif" height="300">


<img src="assets/demo1.mp4" height="300">

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
