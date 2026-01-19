
import 'package:field_technician_demo/ui/screen13_notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationService _notificationService = NotificationService();
  List<NotificationItem> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
  // Load from local storage or state management
    setState(() {
      notifications = [
        NotificationItem(
          id: '1',
          title: 'New Task Assigned',
          message: 'Task SWO-2024-001 assigned for Equipment EQ-123',
          time: DateTime.now().subtract(Duration(minutes: 5)),
          type: NotificationType.taskAssigned,
          isRead: false,
        ),
        NotificationItem(
          id: '2',
          title: 'Task Due Soon',
          message: 'Task SWO-2024-002 is due in 2 hours',
          time: DateTime.now().subtract(Duration(hours: 1)),
          type: NotificationType.taskDue,
          isRead: false,
        ),
        NotificationItem(
          id: '3',
          title: 'Task Completed',
          message: 'Task SWO-2024-003 has been successfully completed',
          time: DateTime.now().subtract(Duration(hours: 3)),
          type: NotificationType.taskCompleted,
          isRead: true,
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1E293B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            color: Colors.white,
            tooltip: 'Mark all as read',
            onPressed: () {
              setState(() {
                for (var notification in notifications) {
                  notification.isRead = true;
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            color: Colors.white,
            tooltip: 'Clear all',
            onPressed: () {
              setState(() {
                notifications.clear();
              });
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _buildNotificationCard(notification, index);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Color(0xFFBDC3C7),
          ),
          SizedBox(height: 16),
          Text(
            'No Notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7F8C8D),
            ),
          ),
          // SizedBox(height: 8),
          // Text(
          //   'You\'re all caught up!',
          //   style: TextStyle(
          //     fontSize: 14,
          //     color: Color(0xFFBDC3C7),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification, int index) {
    IconData icon;
    Color iconColor;

    switch (notification.type) {
      case NotificationType.taskAssigned:
        icon = Icons.assignment_turned_in;
        iconColor = Color(0xFF4A90E2);
        break;
      case NotificationType.taskDue:
        icon = Icons.access_alarm;
        iconColor = Color(0xFFE67E22);
        break;
      case NotificationType.taskCompleted:
        icon = Icons.check_circle;
        iconColor = Color(0xFF27AE60);
        break;
      case NotificationType.taskPaused:
        icon = Icons.pause_circle;
        iconColor = Color(0xFFE91E63);
        break;
      case NotificationType.system:
        icon = Icons.info;
        iconColor = Color(0xFF9B59B6);
        break;
    }

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          notifications.removeAt(index);
        });
        Fluttertoast.showToast(
          msg: "Notification dismissed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Color(0xFFE74C3C),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.white : Color(0xFFE8F4F8),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          title: Text(
            notification.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: notification.isRead ? FontWeight.w600 : FontWeight.w700,
              color: Color(0xFF2C3E50),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text(
                notification.message,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF7F8C8D),
                ),
              ),
              SizedBox(height: 8),
              Text(
                _getTimeAgo(notification.time),
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFFBDC3C7),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          trailing: !notification.isRead
              ? Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Color(0xFF4A90E2),
              shape: BoxShape.circle,
            ),
          )
              : null,
          onTap: () {
            setState(() {
              notification.isRead = true;
            });
// Navigate to relevant screen
          },
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime time) {
    final difference = DateTime.now().difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}

// Notification data model
class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  final NotificationType type;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

enum NotificationType {
  taskAssigned,
  taskDue,
  taskCompleted,
  taskPaused,
  system,
}