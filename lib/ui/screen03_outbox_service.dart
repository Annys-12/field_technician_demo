
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'data_model/outbox_model.dart';

class OutboxService {
  static const String _outboxKey = 'outbox_tasks';

  // Singleton pattern
  static final OutboxService _instance = OutboxService._internal();
  factory OutboxService() => _instance;
  OutboxService._internal();

  // Save task to outbox
  Future<bool> saveToOutbox(OutboxTask task) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> outbox = prefs.getStringList(_outboxKey) ?? [];

      outbox.add(jsonEncode(task.toJson()));
      await prefs.setStringList(_outboxKey, outbox);

      return true;
    } catch (e) {
      print('Error saving to outbox: $e');
      return false;
    }
  }

  // Get all outbox tasks
  Future<List<OutboxTask>> getOutboxTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> outbox = prefs.getStringList(_outboxKey) ?? [];

      return outbox
          .map((taskJson) {
        try {
          return OutboxTask.fromJson(jsonDecode(taskJson) as Map<String, dynamic>);
        } catch (e) {
          print('Error parsing task: $e');
          return null;
        }
      })
          .whereType<OutboxTask>()
          .toList();
    } catch (e) {
      print('Error getting outbox tasks: $e');
      return [];
    }
  }

  // Remove task from outbox
  Future<bool> removeFromOutbox(String taskId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> outbox = prefs.getStringList(_outboxKey) ?? [];

      outbox.removeWhere((taskJson) {
        try {
          final task = OutboxTask.fromJson(jsonDecode(taskJson) as Map<String, dynamic>);
          return task.id == taskId;
        } catch (e) {
          return false;
        }
      });

      await prefs.setStringList(_outboxKey, outbox);
      return true;
    } catch (e) {
      print('Error removing from outbox: $e');
      return false;
    }
  }

  // Update task status
  Future<bool> updateTaskStatus(
      String taskId,
      String status,
      {String? errorMessage}
      ) async {
    try {
      final tasks = await getOutboxTasks();
      final prefs = await SharedPreferences.getInstance();

      final updatedTasks = tasks.map((task) {
        if (task.id == taskId) {
          return task.copyWith(
            status: status,
            errorMessage: errorMessage,
            retryCount: task.retryCount + (status == 'failed' ? 1 : 0),
          );
        }
        return task;
      }).toList();

      final outbox = updatedTasks
          .map((task) => jsonEncode(task.toJson()))
          .toList();

      await prefs.setStringList(_outboxKey, outbox);
      return true;
    } catch (e) {
      print('Error updating task status: $e');
      return false;
    }
  }

  // Check connectivity
  Future<bool> isConnected() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      print('Error checking connectivity: $e');
      return false;
    }
  }

  // Sync a single task
  Future<bool> syncTask(OutboxTask task) async {
    try {
      await updateTaskStatus(task.id, 'uploading');

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // If successful
      await updateTaskStatus(task.id, 'success');
      await removeFromOutbox(task.id);
      return true;

    } catch (e) {
      await updateTaskStatus(
          task.id,
          'failed',
          errorMessage: e.toString()
      );
      return false;
    }
  }

  // Sync all pending tasks
  Future<Map<String, dynamic>> syncAllTasks() async {
    if (!await isConnected()) {
      return {
        'success': false,
        'message': 'No internet connection',
        'syncedCount': 0,
        'failedCount': 0,
      };
    }

    final tasks = await getOutboxTasks();
    final pendingTasks = tasks.where(
            (task) => task.status != 'success'
    ).toList();

    int syncedCount = 0;
    int failedCount = 0;

    for (var task in pendingTasks) {
      final success = await syncTask(task);
      if (success) {
        syncedCount++;
      } else {
        failedCount++;
      }
    }

    return {
      'success': failedCount == 0,
      'message': failedCount == 0
          ? 'All tasks synced successfully'
          : '$syncedCount synced, $failedCount failed',
      'syncedCount': syncedCount,
      'failedCount': failedCount,
    };
  }

  // Retry a specific failed task
  Future<bool> retryTask(String taskId) async {
    if (!await isConnected()) {
      return false;
    }

    final tasks = await getOutboxTasks();
    final task = tasks.firstWhere(
          (t) => t.id == taskId,
      orElse: () => throw Exception('Task not found'),
    );

    return await syncTask(task);
  }

  // Clear all synced tasks
  Future<bool> clearSyncedTasks() async {
    try {
      final tasks = await getOutboxTasks();
      final pendingTasks = tasks.where(
              (task) => task.status != 'success'
      ).toList();

      final prefs = await SharedPreferences.getInstance();
      final outbox = pendingTasks
          .map((task) => jsonEncode(task.toJson()))
          .toList();

      await prefs.setStringList(_outboxKey, outbox);
      return true;
    } catch (e) {
      print('Error clearing synced tasks: $e');
      return false;
    }
  }

  // Get outbox count by status
  Future<Map<String, int>> getTaskCounts() async {
    final tasks = await getOutboxTasks();

    return {
      'pending': tasks.where((t) => t.status == 'pending_upload').length,
      'uploading': tasks.where((t) => t.status == 'uploading').length,
      'failed': tasks.where((t) => t.status == 'failed').length,
      'success': tasks.where((t) => t.status == 'success').length,
      'total': tasks.length,
    };
  }

  // Auto-sync when connection is restored
  void startAutoSync([Function(Map<String, dynamic>)? onSyncComplete])  {
    Connectivity().onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        final syncResult = await syncAllTasks();
        if (onSyncComplete != null) {
          onSyncComplete(syncResult);
        }
      }
    });
  }
}