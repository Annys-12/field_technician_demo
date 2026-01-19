// import 'package:flutter/material.dart';
// import 'components/card_outbox_task.dart';
//
// class OutboxScreen extends StatefulWidget {
//   const OutboxScreen({super.key});
//
//   @override
//   State<OutboxScreen> createState() => _OutboxScreenState();
// }
//
// class _OutboxScreenState extends State<OutboxScreen> {
//   // Dummy data for outbox tasks
//   List<Map<String, dynamic>> dummyOutboxTasks = [
//     {
//       'swoNumber': 'SWO-2024-101',
//       'taskType': 'BD',
//       'equipmentNo': 'EQ-12345',
//       'assignedDate': '2024-12-17',
//       'dept': 'EE',
//       'status': 'pending_upload',
//       'savedAt': DateTime.now().subtract(Duration(hours: 2)),
//       'errorMessage': null,
//     },
//     {
//       'swoNumber': 'SWO-2024-102',
//       'taskType': 'PM',
//       'equipmentNo': 'EQ-67890',
//       'assignedDate': '2024-12-16',
//       'dept': 'ME',
//       'status': 'failed',
//       'savedAt': DateTime.now().subtract(Duration(days: 1)),
//       'errorMessage': 'Network timeout',
//     },
//     {
//       'swoNumber': 'SWO-2024-103',
//       'taskType': 'BD',
//       'equipmentNo': 'EQ-11111',
//       'assignedDate': '2024-12-15',
//       'dept': 'EE',
//       'status': 'pending_upload',
//       'savedAt': DateTime.now().subtract(Duration(hours: 5)),
//       'errorMessage': null,
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           children: [
//             // Changed from Expanded to Container with auto-sizing
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Color(0xFF0A57A3),
//                     Color(0xFF0097A7),
//                   ],
//                 ),
//               ),
//               child: SafeArea(
//                 bottom: false,
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         children: [
//                           IconButton(
//                             icon: const Icon(
//                               Icons.arrow_back_ios,
//                               color: Colors.white,
//                             ),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                           Expanded(
//                             child: Center(
//                               child: Text(
//                                 "Outbox Task",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w700,
//                                   height: 0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(
//                               Icons.sync,
//                               color: Colors.white,
//                             ),
//                             onPressed: () {
//                               // Sync all pending tasks
//                               _syncAllTasks();
//                             },
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       // Status summary
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                             vertical: 8, horizontal: 12),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             _buildStatusSummary(
//                                 Icons.cloud_upload_outlined,
//                                 "Pending",
//                                 _countByStatus('pending_upload'),
//                                 Color(0xFFF39C12)),
//                             _buildStatusSummary(
//                                 Icons.cloud_off,
//                                 "Failed",
//                                 _countByStatus('failed'),
//                                 Color(0xFFE74C3C)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 color: Color(0xffececec),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: dummyOutboxTasks.isEmpty
//                       ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.cloud_done,
//                           size: 80,
//                           color: Colors.grey,
//                         ),
//                         SizedBox(height: 16),
//                         Text(
//                           "All tasks are synced!",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontFamily: 'Poppins',
//                             fontWeight: FontWeight.w600,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                       : ListView.builder(
//                     padding: EdgeInsets.zero,
//                     shrinkWrap: true,
//                     itemCount: dummyOutboxTasks.length,
//                     itemBuilder: (context, index) {
//                       return CardOutbox(
//                         swoNumber: dummyOutboxTasks[index]['swoNumber'] ?? '',
//                         taskType: dummyOutboxTasks[index]['taskType'] ?? '',
//                         equipmentNo: dummyOutboxTasks[index]['equipmentNo'] ?? '',
//                         assignedDate: dummyOutboxTasks[index]['assignedDate'] ?? '',
//                         dept: dummyOutboxTasks[index]['dept'] ?? '',
//                         status: dummyOutboxTasks[index]['status'] ?? 'pending_upload',
//                         savedAt: dummyOutboxTasks[index]['savedAt'] ?? DateTime.now(),
//                         errorMessage: dummyOutboxTasks[index]['errorMessage'],
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatusSummary(
//       IconData icon, String label, int count, Color color) {
//     return Row(
//       children: [
//         Icon(icon, color: color, size: 20),
//         SizedBox(width: 8),
//         Text(
//           "$label: $count",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
//
//   int _countByStatus(String status) {
//     return dummyOutboxTasks.where((task) => task['status'] == status).length;
//   }
//
//   void _syncAllTasks() {
//     // Implement sync all logic
//     print("Syncing all pending tasks...");
//     // Show loading dialog or snackbar
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Syncing tasks...")),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'components/card_outbox_task.dart';
import '../app_data.dart';
import 'dart:math';

class OutboxScreen extends StatefulWidget {
  const OutboxScreen({
    super.key,
    required this.saveOutboxTasks,
    required this.saveTasks,
    required this.refreshDashboard,
  });

  final Function saveOutboxTasks;
  final Function saveTasks;
  final Function refreshDashboard;

  @override
  State<OutboxScreen> createState() => _OutboxScreenState();
}

class _OutboxScreenState extends State<OutboxScreen> {
  bool _isSyncing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
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
                            icon: _isSyncing
                                ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                                : const Icon(
                              Icons.sync,
                              color: Colors.white,
                            ),
                            onPressed: _isSyncing ? null : () {
                              _syncAllTasks();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                  child: myOutboxTask.isEmpty
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
                    itemCount: myOutboxTask.length,
                    itemBuilder: (context, index) {
                      return CardOutbox(
                        swoNumber: myOutboxTask[index].swoNumber,
                        taskType: myOutboxTask[index].taskType,
                        equipmentNo: myOutboxTask[index].equipmentId,
                        assignedDate: myOutboxTask[index].assignedDate,
                        timeStart: myOutboxTask[index].timeStart,
                        timeEnd: myOutboxTask[index].timeEnd,
                        dept: myOutboxTask[index].dept,
                        status: myOutboxTask[index].status,
                        savedAt: myOutboxTask[index].savedAt,
                        errorMessage: myOutboxTask[index].errorMessage,
                        onRetryUpload: (swoNumber) => _retryUpload(index),
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

  Widget _buildStatusSummary(IconData icon, String label, int count, Color color) {
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
    return myOutboxTask.where((task) => task.status == status).length;
  }

  Future<void> _syncAllTasks() async {
    setState(() {
      _isSyncing = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Syncing tasks...")),
    );

    await Future.delayed(Duration(seconds: 2));

    int successCount = 0;
    int failCount = 0;

    List<int> indicesToRemove = [];
    final now = DateTime.now();
    final formattedEndDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(now);

    for (int i = 0; i < myOutboxTask.length; i++) {
      // 70% success rate
      bool success = Random().nextDouble() < 0.7;

      if (success) {
        // Move to completed tasks in main task list
        myOutboxTask[i].status = "Completed";
        myOutboxTask[i].endDate = formattedEndDate;
        myTask.add(myOutboxTask[i]);
        indicesToRemove.add(i);
        successCount++;
      } else {
        // Update to failed status
        myOutboxTask[i].status = "failed";
        myOutboxTask[i].errorMessage = "Network timeout - sync failed";
        myOutboxTask[i].retryCount = (myOutboxTask[i].retryCount ?? 0) + 1;
        failCount++;
      }
    }

    // Remove successful tasks from outbox (in reverse order to maintain indices)
    for (int i in indicesToRemove.reversed) {
      myOutboxTask.removeAt(i);
    }

    await widget.saveOutboxTasks(myOutboxTask);
    await widget.saveTasks(myTask);
    widget.refreshDashboard();

    setState(() {
      _isSyncing = false;
    });

    Fluttertoast.showToast(
      msg: failCount == 0
          ? "All tasks synced successfully!"
          : "$successCount synced, $failCount failed",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: failCount == 0 ? Colors.green : Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> _retryUpload(int index) async {
    // 60% success rate for retry
    bool success = Random().nextDouble() < 0.6;

    await Future.delayed(Duration(seconds: 2));

    if (success) {
      // Set completion date to now
      final now = DateTime.now();
      final formattedEndDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(now);

      // Move to completed tasks
      myOutboxTask[index].status = "Completed";
      myOutboxTask[index].endDate = formattedEndDate;
      myTask.add(myOutboxTask[index]);
      myOutboxTask.removeAt(index);

      await widget.saveOutboxTasks(myOutboxTask);
      await widget.saveTasks(myTask);
      widget.refreshDashboard();

      setState(() {});

      // Success will be shown by CardOutbox
    } else {
      // Update to failed status
      myOutboxTask[index].status = "failed";
      myOutboxTask[index].errorMessage = "Upload failed - Server error";
      myOutboxTask[index].retryCount = (myOutboxTask[index].retryCount ?? 0) + 1;

      await widget.saveOutboxTasks(myOutboxTask);
      widget.refreshDashboard();

      setState(() {});

      // Error will be thrown and shown by CardOutbox
      throw Exception("Upload failed - Server error");
    }
  }
}