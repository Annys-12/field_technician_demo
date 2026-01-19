// import 'package:field_technician_demo/ui/screen01_login.dart';
// import 'package:field_technician_demo/ui/screen03_assign_task.dart';
// import 'package:field_technician_demo/ui/screen03_completed_task.dart';
// import 'package:field_technician_demo/ui/screen03_outbox_task.dart';
// import 'package:field_technician_demo/ui/screen03_pending_task.dart';
// import 'package:field_technician_demo/ui/screen04_breakdown_task.dart';
// import 'package:field_technician_demo/ui/screen05_preventive_task.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;
//
// import '../app_data.dart';
// import '../helper.dart';
//
// class DashboardScreen extends StatefulWidget {
//   DashboardScreen({
//     super.key,
//     required this.saveTasks,
//     required this.saveOutboxTasks,
//   });
//
//   Function saveTasks;
//   Function saveOutboxTasks;
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   bool isGotCurrentTask = false;
//   int intCurrentTask = 0;
//   int _selectedNavIndex = 0;
//
//   @override
//   void initState() {
//     refreshTask();
//     super.initState();
//   }
//
//   refreshTask() {
//     setState(() {
//       myTask.length;
//
//       intPendingTask = 0;
//       intCompleteTask = 0;
//       intOutboxTask = 0;
//       intAssignedTask = 0;
//
//       // Count tasks from myTask
//       for (var i in myTask) {
//         switch (i.status) {
//           case "In Progress":
//             intPendingTask += 1;
//             break;
//           case "Paused":
//             intPendingTask += 1;
//             break;
//           case "Completed":
//             intCompleteTask += 1;
//             break;
//           default:
//             intAssignedTask += 1;
//             break;
//         }
//       }
//
//       // Count outbox tasks from myOutboxTask list
//       intOutboxTask = myOutboxTask.length;
//
//       // Check for current task
//       isGotCurrentTask = false;
//       for (int i = 0; i < myTask.length; i++) {
//         if (myTask[i].status == "In Progress") {
//           isGotCurrentTask = true;
//           intCurrentTask = i;
//           break;
//         }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F7FA),
//       body: SafeArea(
//         child: _buildBody(),
//       ),
//       bottomNavigationBar: _buildBottomNavigationBar(),
//     );
//   }
//
//   Widget _buildBody() {
//     switch (_selectedNavIndex) {
//       case 0:
//         return _buildDashboardView();
//       case 1:
//         return _buildAnalyticsView();
//       case 2:
//         return _buildReportsView();
//       default:
//         return _buildDashboardView();
//     }
//   }
//
//   Widget _buildDashboardView() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           // Header Section
//           _buildHeader(),
//
//           // Quick Actions
//           // _buildQuickActions(),
//
//           // No Data Message or Current Task
//           !isGotCurrentTask
//               ? _buildNoTasksMessage()
//               : _buildCurrentTaskCard(),
//
//           // Performance Summary Card
//           // _buildPerformanceSummaryCard(),
//
//           SizedBox(height: 80), // Space for bottom nav
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAnalyticsView() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Task Analytics",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xFF2C3E50),
//               ),
//             ),
//             SizedBox(height: 20),
//
//             // Task Distribution Chart
//             _buildTaskDistributionChart(),
//
//             SizedBox(height: 24),
//
//             // Completion Rate
//             _buildCompletionRateCard(),
//
//             SizedBox(height: 24),
//
//             // Average Task Duration
//             // _buildAverageTaskDurationCard(),
//
//             // SizedBox(height: 24),
//
//             // Task Type Breakdown
//             _buildTaskTypeBreakdown(),
//
//             SizedBox(height: 80),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildReportsView() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Reports",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xFF2C3E50),
//               ),
//             ),
//             SizedBox(height: 20),
//
//             // Today's Summary
//             _buildTodaySummary(),
//
//             SizedBox(height: 16),
//
//             // Recent Activity
//             _buildRecentActivity(),
//
//             SizedBox(height: 16),
//
//             // Export Report Button
//             // _buildExportReportButton(),
//
//             SizedBox(height: 80),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF0A57A3),
//             Color(0xFF0097A7),
//           ],
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(24, 25, 24, 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.3),
//                       width: 1,
//                     ),
//                   ),
//                   child: Text(
//                     'Muhammad',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.refresh, color: Colors.white, size: 22),
//                       onPressed: () {
//                         setState(() {
//                           refreshTask();
//                         });
//                       },
//                       tooltip: 'Refresh',
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.logout, color: Colors.white, size: 22),
//                       onPressed: () {
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LoginScreen(
//                                 saveTasks: widget.saveTasks,
//                                 saveOutboxTasks: widget.saveOutboxTasks,
//                               )),
//                               (route) => false,
//                         );
//                       },
//                       tooltip: 'Logout',
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 24),
//             Text(
//               "Service Work Order",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 16),
//
//             // Status Cards - First Row
//             Row(
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         Helper().createRoute(AssignedTaskScreen(
//                           saveTasks: widget.saveTasks,
//                           refreshTask: refreshTask,
//                         )),
//                       );
//                     },
//                     child: _buildStatusCard(
//                       title: "Assigned",
//                       count: intAssignedTask.toString(),
//                       color: Color(0xFFFACC00),
//                       icon: Icons.add_task,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         Helper().createRoute(PendingTaskScreen(
//                           saveTasks: widget.saveTasks,
//                           refreshTask: refreshTask,
//                         )),
//                       );
//                     },
//                     child: _buildStatusCard(
//                       title: "Pending",
//                       count: intPendingTask.toString(),
//                       color: Color(0xFFE67E22),
//                       icon: Icons.hourglass_empty,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 12),
//
//             // Status Cards - Second Row
//             Row(
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         Helper().createRoute(OutboxScreen(
//                           saveOutboxTasks: widget.saveOutboxTasks,
//                           saveTasks: widget.saveTasks,
//                           refreshDashboard: refreshTask,
//                         )),
//                       );
//                     },
//                     child: _buildStatusCard(
//                       title: "Outbox",
//                       count: intOutboxTask.toString(),
//                       color: Color(0xFFE91E63),
//                       icon: Icons.outbox_outlined,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         Helper().createRoute(CompletedTaskScreen()),
//                       );
//                     },
//                     child: _buildStatusCard(
//                       title: "Complete",
//                       count: intCompleteTask.toString(),
//                       color: Color(0xFF27AE60),
//                       icon: Icons.check_circle_outline,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Widget _buildQuickActions() {
//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//   //     child: Row(
//   //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //       children: [
//   //         _buildQuickActionButton(
//   //           icon: Icons.qr_code_scanner,
//   //           label: "Scan QR",
//   //           onTap: () {
//   //             // Implement QR scanning
//   //             ScaffoldMessenger.of(context).showSnackBar(
//   //               SnackBar(content: Text('QR Scanner coming soon')),
//   //             );
//   //           },
//   //         ),
//   //         _buildQuickActionButton(
//   //           icon: Icons.add_circle_outline,
//   //           label: "New Task",
//   //           onTap: () {
//   //             Navigator.push(
//   //               context,
//   //               Helper().createRoute(AssignedTaskScreen(
//   //                 saveTasks: widget.saveTasks,
//   //                 refreshTask: refreshTask,
//   //               )),
//   //             );
//   //           },
//   //         ),
//   //         _buildQuickActionButton(
//   //           icon: Icons.history,
//   //           label: "History",
//   //           onTap: () {
//   //             Navigator.push(
//   //               context,
//   //               Helper().createRoute(CompletedTaskScreen()),
//   //             );
//   //           },
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   Widget _buildQuickActionButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 8,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Icon(icon, color: Color(0xFF4A90E2), size: 24),
//             SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF2C3E50),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNoTasksMessage() {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(16, 15, 16, 10),
//       padding: EdgeInsets.all(32),
//       child: Column(
//         children: [
//           Icon(
//             Icons.inbox_outlined,
//             size: 48,
//             color: Color(0xFFBDC3C7),
//           ),
//           SizedBox(height: 12),
//           Text(
//             "No Tasks Available",
//             style: TextStyle(
//               color: Color(0xFF7F8C8D),
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCurrentTaskCard() {
//     return GestureDetector(
//       onTap: () {
//         if (myTask[intCurrentTask].taskType == "BD") {
//           Navigator.push(
//             context,
//             Helper().createRoute(SwoChecklistBD(
//               subtaskNumber: myTask[intCurrentTask].swoNumber,
//               taskType: myTask[intCurrentTask].taskType,
//               equipmentNo: myTask[intCurrentTask].equipmentId,
//               assignedDate: myTask[intCurrentTask].assignedDate,
//               dept: myTask[intCurrentTask].dept,
//               selectedIndex: intCurrentTask,
//               saveTasks: widget.saveTasks,
//               refreshList: refreshTask,
//             )),
//           );
//         } else if (myTask[intCurrentTask].taskType == "PM") {
//           Navigator.push(
//             context,
//             Helper().createRoute(SwoChecklistPM(
//               subtaskNumber: myTask[intCurrentTask].swoNumber,
//               taskType: myTask[intCurrentTask].taskType,
//               equipmentNo: myTask[intCurrentTask].equipmentId,
//               assignedDate: myTask[intCurrentTask].assignedDate,
//               dept: myTask[intCurrentTask].dept,
//               selectedIndex: intCurrentTask,
//               saveTasks: widget.saveTasks,
//               refreshList: refreshTask,
//             )),
//           );
//         }
//       },
//       child: Container(
//         margin: const EdgeInsets.fromLTRB(16, 15, 16, 10),
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Color(0xFF4A90E2).withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(
//                         Icons.work_outline,
//                         color: Color(0xFF4A90E2),
//                         size: 20,
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Text(
//                       "Current Task",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xFF2C3E50),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Color(0xFFE8F4F8),
//                   ),
//                   child: Text(
//                     myTask[intCurrentTask].swoNumber,
//                     style: TextStyle(
//                       color: Color(0xFF4A90E2),
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             _buildDetailRow(
//                 "Assigned Date", myTask[intCurrentTask].assignedDate),
//             _buildDetailRow(
//                 "Equipment Number", myTask[intCurrentTask].equipmentId),
//             _buildDetailRow("Time Start", myTask[intCurrentTask].timeStart),
//             _buildDetailRow("Duration", myTask[intCurrentTask].duration),
//             _buildDetailRow("Pause Time", myTask[intCurrentTask].pauseTime),
//             _buildDetailRow("Pause Reason", myTask[intCurrentTask].pauseReason,
//                 isLast: true),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPerformanceSummaryCard() {
//     int totalTasks =
//         intAssignedTask + intPendingTask + intCompleteTask + intOutboxTask;
//     double completionRate = totalTasks > 0 ? (intCompleteTask / totalTasks) : 0;
//
//     return Container(
//       margin: const EdgeInsets.fromLTRB(16, 15, 16, 10),
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF667EEA),
//             Color(0xFF764BA2),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xFF667EEA).withOpacity(0.3),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Today's Performance",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//               Icon(Icons.trending_up, color: Colors.white, size: 24),
//             ],
//           ),
//           SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildPerformanceItem("Total Tasks", totalTasks.toString()),
//               _buildPerformanceItem("Completed", intCompleteTask.toString()),
//               _buildPerformanceItem(
//                   "Rate", "${(completionRate * 100).toStringAsFixed(0)}%"),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPerformanceItem(String label, String value) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w700,
//             color: Colors.white,
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.white.withOpacity(0.8),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTaskDistributionChart() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Task Distribution",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF2C3E50),
//             ),
//           ),
//           SizedBox(height: 20),
//           SizedBox(
//             height: 200,
//             child: _buildPieChart(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPieChart() {
//     int total =
//         intAssignedTask + intPendingTask + intCompleteTask + intOutboxTask;
//
//     if (total == 0) {
//       return Center(
//         child: Text(
//           "No task data available",
//           style: TextStyle(color: Color(0xFF7F8C8D)),
//         ),
//       );
//     }
//
//     return Row(
//       children: [
//         Expanded(
//           child: AspectRatio(
//             aspectRatio: 1,
//             child: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 15,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: CustomPaint(
//                 painter: PieChartPainter(
//                   assigned: intAssignedTask,
//                   pending: intPendingTask,
//                   completed: intCompleteTask,
//                   outbox: intOutboxTask,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: 20),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildLegendItem("Assigned", Color(0xFFFACC00), intAssignedTask),
//             SizedBox(height: 8),
//             _buildLegendItem("Pending", Color(0xFFE67E22), intPendingTask),
//             SizedBox(height: 8),
//             _buildLegendItem("Complete", Color(0xFF27AE60), intCompleteTask),
//             SizedBox(height: 8),
//             _buildLegendItem("Outbox", Color(0xFFE91E63), intOutboxTask),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLegendItem(String label, Color color, int count) {
//     return Row(
//       children: [
//         Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(3),
//           ),
//         ),
//         SizedBox(width: 8),
//         Text(
//           "$label: $count",
//           style: TextStyle(
//             fontSize: 13,
//             color: Color(0xFF2C3E50),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCompletionRateCard() {
//     int totalTasks =
//         intAssignedTask + intPendingTask + intCompleteTask + intOutboxTask;
//     double completionRate = totalTasks > 0 ? (intCompleteTask / totalTasks) : 0;
//
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Completion Rate",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF2C3E50),
//             ),
//           ),
//           SizedBox(height: 16),
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "${(completionRate * 100).toStringAsFixed(1)}%",
//                       style: TextStyle(
//                         fontSize: 36,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xFF27AE60),
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "$intCompleteTask of $totalTasks tasks completed",
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Color(0xFF7F8C8D),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(
//                 Icons.trending_up,
//                 size: 48,
//                 color: Color(0xFF27AE60).withOpacity(0.3),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: LinearProgressIndicator(
//               value: completionRate,
//               backgroundColor: Color(0xFFE0E0E0),
//               valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF27AE60)),
//               minHeight: 8,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAverageTaskDurationCard() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Color(0xFF4A90E2).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               Icons.timer_outlined,
//               color: Color(0xFF4A90E2),
//               size: 32,
//             ),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Avg. Task Duration",
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Color(0xFF7F8C8D),
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "2.5 hours",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF2C3E50),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTaskTypeBreakdown() {
//     // Count BD and PM tasks
//     int bdCount = 0;
//     int pmCount = 0;
//
//     for (var task in myTask) {
//       if (task.taskType == "BD") {
//         bdCount++;
//       } else if (task.taskType == "PM") {
//         pmCount++;
//       }
//     }
//
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Task Type ",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF2C3E50),
//             ),
//           ),
//           SizedBox(height: 16),
//           _buildTaskTypeRow("Breakdown Task (BD)", bdCount, Color(0xFFE74C3C)),
//           SizedBox(height: 12),
//           _buildTaskTypeRow("Preventive Task (PM)", pmCount, Color(0xFF3498DB)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTaskTypeRow(String label, int count, Color color) {
//     int total = myTask.length;
//     double percentage = total > 0 ? (count / total) : 0;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Color(0xFF2C3E50),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Text(
//               "$count (${(percentage * 100).toStringAsFixed(0)}%)",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Color(0xFF7F8C8D),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 8),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: LinearProgressIndicator(
//             value: percentage,
//             backgroundColor: Color(0xFFE0E0E0),
//             valueColor: AlwaysStoppedAnimation<Color>(color),
//             minHeight: 8,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTodaySummary() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF11998E),
//             Color(0xFF38EF7D),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xFF11998E).withOpacity(0.3),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Today's Summary",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//               Text(
//                 DateTime.now().toString().split(' ')[0],
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: Colors.white.withOpacity(0.9),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildSummaryItem(
//                 Icons.assignment_outlined,
//                 "Tasks",
//                 (intAssignedTask + intPendingTask + intCompleteTask + intOutboxTask).toString(),
//               ),
//               _buildSummaryItem(
//                 Icons.check_circle_outline,
//                 "Completed",
//                 intCompleteTask.toString(),
//               ),
//               _buildSummaryItem(
//                 Icons.access_time,
//                 "Hours",
//                 "8.5",
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSummaryItem(IconData icon, String label, String value) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.white, size: 28),
//         SizedBox(height: 8),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w700,
//             color: Colors.white,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.white.withOpacity(0.9),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildRecentActivity() {
//     // Get recent tasks (completed or in progress)
//     List<dynamic> recentTasks = myTask.where((task) =>
//     task.status == "Completed" || task.status == "In Progress"
//     ).take(5).toList();
//
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Recent Activity",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFF2C3E50),
//                 ),
//               ),
//               Icon(
//                 Icons.history,
//                 color: Color(0xFF4A90E2),
//                 size: 20,
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           recentTasks.isEmpty
//               ? Center(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Text(
//                 "No recent activity",
//                 style: TextStyle(
//                   color: Color(0xFF7F8C8D),
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           )
//               : Column(
//             children: recentTasks.asMap().entries.map((entry) {
//               int index = entry.key;
//               var task = entry.value;
//               return _buildActivityItem(
//                 task.swoNumber,
//                 task.equipmentId,
//                 task.status,
//                 task.taskType,
//                 isLast: index == recentTasks.length - 1,
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActivityItem(
//       String swoNumber,
//       String equipment,
//       String status,
//       String taskType,
//       {bool isLast = false}
//       ) {
//     Color statusColor;
//     IconData statusIcon;
//
//     switch (status) {
//       case "Completed":
//         statusColor = Color(0xFF27AE60);
//         statusIcon = Icons.check_circle;
//         break;
//       case "In Progress":
//         statusColor = Color(0xFFE67E22);
//         statusIcon = Icons.play_circle_outline;
//         break;
//       default:
//         statusColor = Color(0xFF7F8C8D);
//         statusIcon = Icons.circle_outlined;
//     }
//
//     return Column(
//       children: [
//         Row(
//           children: [
//             Container(
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: statusColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Icon(
//                 statusIcon,
//                 color: statusColor,
//                 size: 20,
//               ),
//             ),
//             SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     swoNumber,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF2C3E50),
//                     ),
//                   ),
//                   SizedBox(height: 2),
//                   Text(
//                     "Equipment: $equipment • Type: $taskType",
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color(0xFF7F8C8D),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//               decoration: BoxDecoration(
//                 color: statusColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 status,
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                   color: statusColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         if (!isLast)
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 12),
//             child: Divider(height: 1, color: Color(0xFFE0E0E0)),
//           ),
//         if (!isLast) SizedBox(height: 0),
//       ],
//     );
//   }
//
//   Widget _buildExportReportButton() {
//     return Container(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           // Implement export functionality
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Export report feature coming soon'),
//               backgroundColor: Color(0xFF4A90E2),
//               behavior: SnackBarBehavior.floating,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xFF4A90E2),
//           foregroundColor: Colors.white,
//           padding: EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 2,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.file_download_outlined, size: 20),
//             SizedBox(width: 8),
//             Text(
//               "Export Report",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBottomNavigationBar() {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, -2),
//           ),
//         ],
//       ),
//       child: BottomNavigationBar(
//         currentIndex: _selectedNavIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedNavIndex = index;
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.white,
//         selectedItemColor: Color(0xFF4A90E2),
//         unselectedItemColor: Color(0xFF7F8C8D),
//         selectedFontSize: 12,
//         unselectedFontSize: 12,
//         elevation: 0,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard_outlined),
//             activeIcon: Icon(Icons.dashboard),
//             label: 'Dashboard',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.analytics_outlined),
//             activeIcon: Icon(Icons.analytics),
//             label: 'Analytics',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assessment_outlined),
//             activeIcon: Icon(Icons.assessment),
//             label: 'Reports',
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatusCard({
//     required String title,
//     required String count,
//     required Color color,
//     required IconData icon,
//   }) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.3),
//             blurRadius: 8,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Icon(
//             icon,
//             color: Colors.white,
//             size: 24,
//           ),
//           SizedBox(height: 6),
//           Text(
//             title,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 2),
//           Text(
//             count,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, String value, {bool isLast = false}) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: Color(0xFF7F8C8D),
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           Text(
//             ": ",
//             style: TextStyle(
//               color: Color(0xFF7F8C8D),
//               fontSize: 13,
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(
//               value,
//               style: TextStyle(
//                 color: Color(0xFF2C3E50),
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Custom Pie Chart Painter
// class PieChartPainter extends CustomPainter {
//   final int assigned;
//   final int pending;
//   final int completed;
//   final int outbox;
//
//   PieChartPainter({
//     required this.assigned,
//     required this.pending,
//     required this.completed,
//     required this.outbox,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;
//     final total = assigned + pending + completed + outbox;
//
//     if (total == 0) return;
//
//     final assignedPaint = Paint()
//       ..color = Color(0xFFFACC00)
//       ..style = PaintingStyle.fill;
//
//     final pendingPaint = Paint()
//       ..color = Color(0xFFE67E22)
//       ..style = PaintingStyle.fill;
//
//     final completedPaint = Paint()
//       ..color = Color(0xFF27AE60)
//       ..style = PaintingStyle.fill;
//
//     final outboxPaint = Paint()
//       ..color = Color(0xFFE91E63)
//       ..style = PaintingStyle.fill;
//
//     double startAngle = -90 * (3.14159 / 180); // Start from top
//
//     // Draw Assigned slice
//     final assignedSweep = (assigned / total) * 2 * 3.14159;
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       startAngle,
//       assignedSweep,
//       true,
//       assignedPaint,
//     );
//     startAngle += assignedSweep;
//
//     // Draw Pending slice
//     final pendingSweep = (pending / total) * 2 * 3.14159;
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       startAngle,
//       pendingSweep,
//       true,
//       pendingPaint,
//     );
//     startAngle += pendingSweep;
//
//     // Draw Completed slice
//     final completedSweep = (completed / total) * 2 * 3.14159;
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       startAngle,
//       completedSweep,
//       true,
//       completedPaint,
//     );
//     startAngle += completedSweep;
//
//     // Draw Outbox slice
//     final outboxSweep = (outbox / total) * 2 * 3.14159;
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       startAngle,
//       outboxSweep,
//       true,
//       outboxPaint,
//     );
//
//     // Draw center white circle for donut effect
//     final centerPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//
//     canvas.drawCircle(center, radius * 0.5, centerPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

import 'package:field_technician_demo/ui/screen01_login.dart';
import 'package:field_technician_demo/ui/screen03_assign_task.dart';
import 'package:field_technician_demo/ui/screen03_completed_task.dart';
import 'package:field_technician_demo/ui/screen03_outbox_task.dart';
import 'package:field_technician_demo/ui/screen03_pending_task.dart';
import 'package:field_technician_demo/ui/screen04_breakdown_task.dart';
import 'package:field_technician_demo/ui/screen05_preventive_task.dart';
import 'package:field_technician_demo/ui/screen13_notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;
import '../app_data.dart';
import '../helper.dart';
import 'screen13_notifications_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({
    super.key,
    required this.saveTasks,
    required this.saveOutboxTasks,
  });

  Function saveTasks;
  Function saveOutboxTasks;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isGotCurrentTask = false;
  int intCurrentTask = 0;
  int _selectedNavIndex = 0;
  int unreadNotificationCount = 3;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    _initializeNotifications();
    refreshTask();
    super.initState();
  }

  Future<void> _initializeNotifications() async {
    await _notificationService.initialize();
    await _notificationService.requestPermissions();
  }

  refreshTask() {
    setState(() {
      myTask.length;

      intPendingTask = 0;
      intCompleteTask = 0;
      intOutboxTask = 0;
      intAssignedTask = 0;

      // Count tasks from myTask
      for (var i in myTask) {
        switch (i.status) {
          case "In Progress":
            intPendingTask += 1;
            break;
          case "Paused":
            intPendingTask += 1;
            break;
          case "Completed":
            intCompleteTask += 1;
            break;
          default:
            intAssignedTask += 1;
            break;
        }
      }

      // Count outbox tasks from myOutboxTask list
      intOutboxTask = myOutboxTask.length;

      // Check for current task
      isGotCurrentTask = false;
      for (int i = 0; i < myTask.length; i++) {
        if (myTask[i].status == "In Progress") {
          isGotCurrentTask = true;
          intCurrentTask = i;
          break;
        }
      }
    });
  }

  //Add method to trigger notifications when tasks change
  void _sendTaskNotification(String action, String taskNumber, String equipmentId) {
    switch (action) {
      case 'assigned':
        _notificationService.showTaskAssignedNotification(
          taskNumber: taskNumber,
          equipmentId: equipmentId,
        );
        setState(() {
          unreadNotificationCount++;
        });
        break;
      case 'completed':
        _notificationService.showTaskCompletedNotification(
          taskNumber: taskNumber,
        );
        setState(() {
          unreadNotificationCount++;
        });
        break;
      case 'due_soon':
        _notificationService.showTaskDueSoonNotification(
          taskNumber: taskNumber,
          hoursRemaining: 2,
        );
        setState(() {
          unreadNotificationCount++;
        });
        break;
      case 'paused':
        _notificationService.showPausedTaskReminderNotification(
          taskNumber: taskNumber,
          pausedMinutes: 30,
        );
        setState(() {
          unreadNotificationCount++;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: _buildBody(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    switch (_selectedNavIndex) {
      case 0:
        return _buildDashboardView();
      case 1:
        return _buildAnalyticsView();
      case 2:
        return _buildReportsView();
      default:
        return _buildDashboardView();
    }
  }

  Widget _buildDashboardView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Section
          _buildHeader(),

          // Quick Actions
          // _buildQuickActions(),

          // No Data Message or Current Task
          !isGotCurrentTask
              ? _buildNoTasksMessage()
              : _buildCurrentTaskCard(),

          // Performance Summary Card
          // _buildPerformanceSummaryCard(),

          SizedBox(height: 80), // Space for bottom nav
        ],
      ),
    );
  }

  Widget _buildAnalyticsView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Task Analytics",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2C3E50),
              ),
            ),
            SizedBox(height: 20),

            // Task Distribution Chart
            _buildTaskDistributionChart(),

            SizedBox(height: 24),

            // Completion Rate
            _buildCompletionRateCard(),

            SizedBox(height: 24),

            // Average Task Duration
            _buildAverageTaskDurationCard(),

            SizedBox(height: 24),

            // Task Type Breakdown
            _buildTaskTypeBreakdown(),

            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reports",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2C3E50),
              ),
            ),
            SizedBox(height: 20),

            // Today's Summary
            _buildTodaySummary(),

            SizedBox(height: 16),

            // Recent Activity
            _buildRecentActivity(),

            SizedBox(height: 16),

            // Export Report Button
            _buildExportReportButton(),

            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A57A3),
            Color(0xFF0097A7),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 25, 24, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Muhammad',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  children: [
                    // Notification Bell
                    Stack(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationScreen(),
                              ),
                            ).then((_) {
                              setState(() {
                                unreadNotificationCount = 0;
                              });
                            });
                          },
                          tooltip: 'Notifications',
                        ),
                        if (unreadNotificationCount > 0)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Color(0xFFE74C3C),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                unreadNotificationCount > 9
                                    ? '9+'
                                    : unreadNotificationCount.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh, color: Colors.white, size: 22),
                      onPressed: () {
                        setState(() {
                          refreshTask();
                        });
                      },
                      tooltip: 'Refresh',
                    ),
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.white, size: 22),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                saveTasks: widget.saveTasks,
                                saveOutboxTasks: widget.saveOutboxTasks,
                              )),
                              (route) => false,
                        );
                      },
                      tooltip: 'Logout',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              "Service Work Order",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),

            // Status Cards - First Row
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        Helper().createRoute(AssignedTaskScreen(
                          saveTasks: widget.saveTasks,
                          refreshTask: refreshTask,
                        )),
                      );
                    },
                    child: _buildStatusCard(
                      title: "Assigned",
                      count: intAssignedTask.toString(),
                      color: Color(0xFFFACC00),
                      icon: Icons.add_task,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        Helper().createRoute(PendingTaskScreen(
                          saveTasks: widget.saveTasks,
                          refreshTask: refreshTask,
                        )),
                      );
                    },
                    child: _buildStatusCard(
                      title: "Pending",
                      count: intPendingTask.toString(),
                      color: Color(0xFFE67E22),
                      icon: Icons.hourglass_empty,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Status Cards - Second Row
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        Helper().createRoute(OutboxScreen(
                          saveOutboxTasks: widget.saveOutboxTasks,
                          saveTasks: widget.saveTasks,
                          refreshDashboard: refreshTask,
                        )),
                      );
                    },
                    child: _buildStatusCard(
                      title: "Outbox",
                      count: intOutboxTask.toString(),
                      color: Color(0xFFE91E63),
                      icon: Icons.outbox_outlined,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        Helper().createRoute(CompletedTaskScreen()),
                      );
                    },
                    child: _buildStatusCard(
                      title: "Complete",
                      count: intCompleteTask.toString(),
                      color: Color(0xFF27AE60),
                      icon: Icons.check_circle_outline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Widget _buildQuickActions() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         _buildQuickActionButton(
  //           icon: Icons.qr_code_scanner,
  //           label: "Scan QR",
  //           onTap: () {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('QR Scanner coming soon')),
  //             );
  //           },
  //         ),
  //         _buildQuickActionButton(
  //           icon: Icons.add_circle_outline,
  //           label: "New Task",
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               Helper().createRoute(AssignedTaskScreen(
  //                 saveTasks: widget.saveTasks,
  //                 refreshTask: refreshTask,
  //               )),
  //             );
  //           },
  //         ),
  //         _buildQuickActionButton(
  //           icon: Icons.history,
  //           label: "History",
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               Helper().createRoute(CompletedTaskScreen()),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildQuickActionButton({
  //   required IconData icon,
  //   required String label,
  //   required VoidCallback onTap,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(12),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.05),
  //             blurRadius: 8,
  //             offset: Offset(0, 2),
  //           ),
  //         ],
  //       ),
  //       child: Column(
  //         children: [
  //           Icon(icon, color: Color(0xFF4A90E2), size: 24),
  //           SizedBox(height: 4),
  //           Text(
  //             label,
  //             style: TextStyle(
  //               fontSize: 12,
  //               fontWeight: FontWeight.w600,
  //               color: Color(0xFF2C3E50),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildNoTasksMessage() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 15, 16, 10),
      padding: EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 48,
            color: Color(0xFFBDC3C7),
          ),
          SizedBox(height: 12),
          Text(
            "No Tasks Available",
            style: TextStyle(
              color: Color(0xFF7F8C8D),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentTaskCard() {
    return GestureDetector(
      onTap: () {
        if (myTask[intCurrentTask].taskType == "BD") {
          Navigator.push(
            context,
            Helper().createRoute(SwoChecklistBD(
              subtaskNumber: myTask[intCurrentTask].swoNumber,
              taskType: myTask[intCurrentTask].taskType,
              equipmentNo: myTask[intCurrentTask].equipmentId,
              assignedDate: myTask[intCurrentTask].assignedDate,
              dept: myTask[intCurrentTask].dept,
              selectedIndex: intCurrentTask,
              saveTasks: widget.saveTasks,
              refreshList: refreshTask,
            )),
          );
        } else if (myTask[intCurrentTask].taskType == "PM") {
          Navigator.push(
            context,
            Helper().createRoute(SwoChecklistPM(
              subtaskNumber: myTask[intCurrentTask].swoNumber,
              taskType: myTask[intCurrentTask].taskType,
              equipmentNo: myTask[intCurrentTask].equipmentId,
              assignedDate: myTask[intCurrentTask].assignedDate,
              dept: myTask[intCurrentTask].dept,
              selectedIndex: intCurrentTask,
              saveTasks: widget.saveTasks,
              refreshList: refreshTask,
            )),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 15, 16, 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF4A90E2).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.work_outline,
                        color: Color(0xFF4A90E2),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Current Task",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFE8F4F8),
                  ),
                  child: Text(
                    myTask[intCurrentTask].swoNumber,
                    style: TextStyle(
                      color: Color(0xFF4A90E2),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildDetailRow(
                "Assigned Date", myTask[intCurrentTask].assignedDate),
            _buildDetailRow(
                "Equipment Number", myTask[intCurrentTask].equipmentId),
            _buildDetailRow("Time Start", myTask[intCurrentTask].timeStart),
            _buildDetailRow("Duration", myTask[intCurrentTask].duration),
            _buildDetailRow("Pause Time", myTask[intCurrentTask].pauseTime),
            _buildDetailRow("Pause Reason", myTask[intCurrentTask].pauseReason,
                isLast: true),
          ],
        ),
      ),
    );
  }

  // Widget _buildPerformanceSummaryCard() {
  //   int totalTasks =
  //       intAssignedTask + intPendingTask + intCompleteTask + intOutboxTask;
  //   double completionRate = totalTasks > 0 ? (intCompleteTask / totalTasks) : 0;
  //
  //   return Container(
  //     margin: const EdgeInsets.fromLTRB(16, 15, 16, 10),
  //     padding: EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //         colors: [
  //           Color(0xFF667EEA),
  //           Color(0xFF764BA2),
  //         ],
  //       ),
  //       borderRadius: BorderRadius.circular(16),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Color(0xFF667EEA).withOpacity(0.3),
  //           blurRadius: 10,
  //           offset: Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               "Today's Performance",
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w700,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             Icon(Icons.trending_up, color: Colors.white, size: 24),
  //           ],
  //         ),
  //         SizedBox(height: 16),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             _buildPerformanceItem("Total Tasks", totalTasks.toString()),
  //             _buildPerformanceItem("Completed", intCompleteTask.toString()),
  //             _buildPerformanceItem(
  //                 "Rate", "${(completionRate * 100).toStringAsFixed(0)}%"),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildPerformanceItem(String label, String value) {
  //   return Column(
  //     children: [
  //       Text(
  //         value,
  //         style: TextStyle(
  //           fontSize: 24,
  //           fontWeight: FontWeight.w700,
  //           color: Colors.white,
  //         ),
  //       ),
  //       SizedBox(height: 4),
  //       Text(
  //         label,
  //         style: TextStyle(
  //           fontSize: 12,
  //           color: Colors.white.withOpacity(0.8),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildTaskDistributionChart() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Task Distribution",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3E50),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: _buildPieChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    int total =
        intAssignedTask + intPendingTask + intCompleteTask + intOutboxTask;

    if (total == 0) {
      return Center(
        child: Text(
          "No task data available",
          style: TextStyle(color: Color(0xFF7F8C8D)),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: CustomPaint(
                painter: PieChartPainter(
                  assigned: intAssignedTask,
                  pending: intPendingTask,
                  completed: intCompleteTask,
                  outbox: intOutboxTask,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem("Assigned", Color(0xFFFACC00), intAssignedTask),
            SizedBox(height: 8),
            _buildLegendItem("Pending", Color(0xFFE67E22), intPendingTask),
            SizedBox(height: 8),
            _buildLegendItem("Complete", Color(0xFF27AE60), intCompleteTask),
            SizedBox(height: 8),
            _buildLegendItem("Outbox", Color(0xFFE91E63), intOutboxTask),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color, int count) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 8),
        Text(
          "$label: $count",
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCompletionRateCard() {
    int totalTasks =
        intAssignedTask + intPendingTask + intCompleteTask + intOutboxTask;
    double completionRate = totalTasks > 0 ? (intCompleteTask / totalTasks) : 0;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Completion Rate",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3E50),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${(completionRate * 100).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF27AE60),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "$intCompleteTask of $totalTasks tasks completed",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7F8C8D),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.trending_up,
                size: 48,
                color: Color(0xFF27AE60).withOpacity(0.3),
              ),
            ],
          ),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: completionRate,
              backgroundColor: Color(0xFFE0E0E0),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF27AE60)),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAverageTaskDurationCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF4A90E2).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.timer_outlined,
              color: Color(0xFF4A90E2),
              size: 32,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Avg. Task Duration",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF7F8C8D),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "2.5 hours",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskTypeBreakdown() {
    int bdCount = 0;
    int pmCount = 0;

    for (var task in myTask) {
      if (task.taskType == "BD") {
        bdCount++;
      } else if (task.taskType == "PM") {
        pmCount++;
      }
    }

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Task Type Breakdown",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3E50),
            ),
          ),
          SizedBox(height: 16),
          _buildTaskTypeRow("Breakdown (BD)", bdCount, Color(0xFFE74C3C)),
          SizedBox(height: 12),
          _buildTaskTypeRow("Preventive (PM)", pmCount, Color(0xFF3498DB)),
        ],
      ),
    );
  }

  Widget _buildTaskTypeRow(String label, int count, Color color) {
    int total = myTask.length;
    double percentage = total > 0 ? (count / total) : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF2C3E50),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "$count (${(percentage * 100).toStringAsFixed(0)}%)",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF7F8C8D),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Color(0xFFE0E0E0),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildTodaySummary() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF11998E),
            Color(0xFF38EF7D),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF11998E).withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Summary",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                DateTime.now().toString().split(' ')[0],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem(
                Icons.assignment_outlined,
                "Tasks",
                (intAssignedTask + intPendingTask + intCompleteTask + intOutboxTask)
                    .toString(),
              ),
              _buildSummaryItem(
                Icons.check_circle_outline,
                "Completed",
                intCompleteTask.toString(),
              ),
              _buildSummaryItem(
                Icons.access_time,
                "Hours",
                "8.5",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    List<dynamic> recentTasks = myTask
        .where((task) => task.status == "Completed" || task.status == "In Progress")
        .take(5)
        .toList();

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3E50),
                ),
              ),
              Icon(
                Icons.history,
                color: Color(0xFF4A90E2),
                size: 20,
              ),
            ],
          ),
          SizedBox(height: 16),
          recentTasks.isEmpty
              ? Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "No recent activity",
                style: TextStyle(
                  color: Color(0xFF7F8C8D),
                  fontSize: 14,
                ),
              ),
            ),
          )
              : Column(
            children: recentTasks.asMap().entries.map((entry) {
              int index = entry.key;
              var task = entry.value;
              return _buildActivityItem(
                task.swoNumber,
                task.equipmentId,
                task.status,
                task.taskType,
                isLast: index == recentTasks.length - 1,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
      String swoNumber,
      String equipment,
      String status,
      String taskType, {
        bool isLast = false,
      }) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case "Completed":
        statusColor = Color(0xFF27AE60);
        statusIcon = Icons.check_circle;
        break;
      case "In Progress":
        statusColor = Color(0xFFE67E22);
        statusIcon = Icons.play_circle_outline;
        break;
      default:
        statusColor = Color(0xFF7F8C8D);
        statusIcon = Icons.circle_outlined;
    }

    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                statusIcon,
                color: statusColor,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    swoNumber,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Equipment: $equipment • Type: $taskType",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7F8C8D),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: Color(0xFFE0E0E0)),
          ),
        if (!isLast) SizedBox(height: 0),
      ],
    );
  }

  Widget _buildExportReportButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Fluttertoast.showToast(
            msg: "Export report feature coming soon",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: const Color(0xFF4A90E2),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF4A90E2),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.file_download_outlined, size: 20),
            SizedBox(width: 8),
            Text(
              "Export Report",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF4A90E2),
        unselectedItemColor: Color(0xFF7F8C8D),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            activeIcon: Icon(Icons.assessment),
            label: 'Reports',
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String count,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2),
          Text(
            count,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Color(0xFF7F8C8D),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            ": ",
            style: TextStyle(
              color: Color(0xFF7F8C8D),
              fontSize: 13,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(
                color: Color(0xFF2C3E50),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Pie Chart Painter
class PieChartPainter extends CustomPainter {
  final int assigned;
  final int pending;
  final int completed;
  final int outbox;

  PieChartPainter({
    required this.assigned,
    required this.pending,
    required this.completed,
    required this.outbox,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final total = assigned + pending + completed + outbox;

    if (total == 0) return;

    final assignedPaint = Paint()
      ..color = Color(0xFFFACC00)
      ..style = PaintingStyle.fill;

    final pendingPaint = Paint()
      ..color = Color(0xFFE67E22)
      ..style = PaintingStyle.fill;

    final completedPaint = Paint()
      ..color = Color(0xFF27AE60)
      ..style = PaintingStyle.fill;

    final outboxPaint = Paint()
      ..color = Color(0xFFE91E63)
      ..style = PaintingStyle.fill;

    double startAngle = -math.pi / 2;

    // Draw Assigned slice
    final assignedSweep = (assigned / total) * 2 * math.pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      assignedSweep,
      true,
      assignedPaint,
    );
    startAngle += assignedSweep;

    // Draw Pending slice
    final pendingSweep = (pending / total) * 2 * math.pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      pendingSweep,
      true,
      pendingPaint,
    );
    startAngle += pendingSweep;

    // Draw Completed slice
    final completedSweep = (completed / total) * 2 * math.pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      completedSweep,
      true,
      completedPaint,
    );
    startAngle += completedSweep;

    // Draw Outbox slice
    final outboxSweep = (outbox / total) * 2 * math.pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      outboxSweep,
      true,
      outboxPaint,
    );

    // Draw center white circle for donut effect
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.5, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}