import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_filex/open_filex.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  static const int _notificationId = 1;
  static const String _channelId = 'download_channel';
  static const String _channelName = 'Downloads';
  static const String _channelDesc = 'Shows download progress and status';

  static Future<void> initialize() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onTap,
    );
    const channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDesc,
      importance: Importance.high,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static void _onTap(NotificationResponse response) {
    final filePath = response.payload;
    if (filePath != null && filePath.isNotEmpty) {
      OpenFilex.open(filePath);
    }
  }

  static Future<void> showStarted() async {
    await _plugin.show(
      _notificationId,
      'Download Started',
      'Preparing download...',
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.low,
          priority: Priority.low,
          showProgress: true,
          indeterminate: true,
          onlyAlertOnce: true,
          ongoing: true,
        ),
      ),
    );
  }

  static Future<void> showProgress(int progress) async {
    await _plugin.show(
      _notificationId,
      'Downloading...',
      '$progress%',
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.low,
          priority: Priority.low,
          showProgress: true,
          maxProgress: 100,
          progress: progress,
          onlyAlertOnce: true,
          ongoing: true,
        ),
      ),
    );
  }

  static Future<void> showCompleted(String filePath) async {
    await _plugin.show(
      _notificationId,
      'Download Complete ✓',
      'Tap to open the downloaded file',
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.high,
          priority: Priority.high,
          onlyAlertOnce: false,
          ongoing: false,
        ),
      ),
      payload: filePath, // file path passed back on tap
    );
  }

  static Future<void> showFailed() async {
    await _plugin.show(
      _notificationId,
      'Download Failed ✗',
      'Something went wrong. Please try again.',
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.high,
          priority: Priority.high,
          ongoing: false,
        ),
      ),
    );
  }

  /// Cancel the active download notification
  static Future<void> cancel() async {
    await _plugin.cancel(_notificationId);
  }
}