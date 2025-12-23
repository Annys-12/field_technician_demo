import 'package:flutter/material.dart';
import 'components/card_outbox_task.dart';

class OutboxScreen extends StatefulWidget {
  const OutboxScreen({super.key});

  @override
  State<OutboxScreen> createState() => _OutboxScreenState();
}

class _OutboxScreenState extends State<OutboxScreen> {
  // Dummy data for outbox tasks
  List<Map<String, dynamic>> dummyOutboxTasks = [
    {
      'swoNumber': 'SWO-2024-101',
      'taskType': 'BD',
      'equipmentNo': 'EQ-12345',
      'assignedDate': '2024-12-17',
      'dept': 'EE',
      'status': 'pending_upload',
      'savedAt': DateTime.now().subtract(Duration(hours: 2)),
      'errorMessage': null,
    },
    {
      'swoNumber': 'SWO-2024-102',
      'taskType': 'PM',
      'equipmentNo': 'EQ-67890',
      'assignedDate': '2024-12-16',
      'dept': 'ME',
      'status': 'failed',
      'savedAt': DateTime.now().subtract(Duration(days: 1)),
      'errorMessage': 'Network timeout',
    },
    {
      'swoNumber': 'SWO-2024-103',
      'taskType': 'BD',
      'equipmentNo': 'EQ-11111',
      'assignedDate': '2024-12-15',
      'dept': 'EE',
      'status': 'pending_upload',
      'savedAt': DateTime.now().subtract(Duration(hours: 5)),
      'errorMessage': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            // Changed from Expanded to Container with auto-sizing
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0A57A3),
                    Color(0xFF0097A7),
                  ],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Outbox Task",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.sync,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Sync all pending tasks
                              _syncAllTasks();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Status summary
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatusSummary(
                                Icons.cloud_upload_outlined,
                                "Pending",
                                _countByStatus('pending_upload'),
                                Color(0xFFF39C12)),
                            _buildStatusSummary(
                                Icons.cloud_off,
                                "Failed",
                                _countByStatus('failed'),
                                Color(0xFFE74C3C)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xffececec),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: dummyOutboxTasks.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_done,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "All tasks are synced!",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: dummyOutboxTasks.length,
                    itemBuilder: (context, index) {
                      return CardOutbox(
                        swoNumber: dummyOutboxTasks[index]['swoNumber'] ?? '',
                        taskType: dummyOutboxTasks[index]['taskType'] ?? '',
                        equipmentNo: dummyOutboxTasks[index]['equipmentNo'] ?? '',
                        assignedDate: dummyOutboxTasks[index]['assignedDate'] ?? '',
                        dept: dummyOutboxTasks[index]['dept'] ?? '',
                        status: dummyOutboxTasks[index]['status'] ?? 'pending_upload',
                        savedAt: dummyOutboxTasks[index]['savedAt'] ?? DateTime.now(),
                        errorMessage: dummyOutboxTasks[index]['errorMessage'],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSummary(
      IconData icon, String label, int count, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 8),
        Text(
          "$label: $count",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  int _countByStatus(String status) {
    return dummyOutboxTasks.where((task) => task['status'] == status).length;
  }

  void _syncAllTasks() {
    // Implement sync all logic
    print("Syncing all pending tasks...");
    // Show loading dialog or snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Syncing tasks...")),
    );
  }
}