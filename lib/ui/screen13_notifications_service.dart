import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize timezone
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _isInitialized = true;
  }

  void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    print('Notification tapped: ${response.payload}');
    // Navigate to specific screen based on payload
  }

  // Request notification permissions (iOS)
  Future<bool> requestPermissions() async {
    final result = await _notifications
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    return result ?? true;
  }

  // Show instant notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    NotificationPriority priority = NotificationPriority.high,
  }) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'main_channel',
      'Main Notifications',
      channelDescription: 'Main notification channel',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      styleInformation: BigTextStyleInformation(''),
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(id, title, body, details, payload: payload);
  }

  // Show notification for new task assignment
  Future<void> showTaskAssignedNotification({
    required String taskNumber,
    required String equipmentId,
  }) async {
    await showNotification(
      id: taskNumber.hashCode,
      title: '🔔 New Task Assigned',
      body: 'Task $taskNumber assigned for Equipment $equipmentId',
      payload: 'task_assigned:$taskNumber',
    );
  }

  // Show notification for task due soon
  Future<void> showTaskDueSoonNotification({
    required String taskNumber,
    required int hoursRemaining,
  }) async {
    await showNotification(
      id: taskNumber.hashCode + 1000,
      title: '⏰ Task Due Soon',
      body: 'Task $taskNumber is due in $hoursRemaining hours',
      payload: 'task_due:$taskNumber',
    );
  }

  // Show notification for task completion
  Future<void> showTaskCompletedNotification({
    required String taskNumber,
  }) async {
    await showNotification(
      id: taskNumber.hashCode + 2000,
      title: '✅ Task Completed',
      body: 'Task $taskNumber has been successfully completed',
      payload: 'task_completed:$taskNumber',
    );
  }

  // Show notification for paused task reminder
  Future<void> showPausedTaskReminderNotification({
    required String taskNumber,
    required int pausedMinutes,
  }) async {
    await showNotification(
      id: taskNumber.hashCode + 3000,
      title: '⏸️ Task Paused',
      body: 'Task $taskNumber has been paused for $pausedMinutes minutes',
      payload: 'task_paused:$taskNumber',
    );
  }

  // Schedule notification for future
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Notifications',
      channelDescription: 'Scheduled notification channel',
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  // Cancel specific notification
  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  // Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }

  // Get active notifications (Android only)
  Future<List<ActiveNotification>> getActiveNotifications() async {
    final result = await _notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
    return result ?? [];
  }
}

enum NotificationPriority {
  low,
  normal,
  high,
  urgent,
}