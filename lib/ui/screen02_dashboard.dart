import 'package:field_technician_demo/ui/screen01_login.dart';
import 'package:field_technician_demo/ui/screen03_assign_task.dart';
import 'package:field_technician_demo/ui/screen03_completed_task.dart';
import 'package:field_technician_demo/ui/screen03_outbox_task.dart';
import 'package:field_technician_demo/ui/screen03_pending_task.dart';
import 'package:field_technician_demo/ui/screen04_breakdown_task.dart';
import 'package:field_technician_demo/ui/screen05_preventive_task.dart';
import 'package:flutter/material.dart';

import '../app_data.dart';
import '../helper.dart';
class DashboardScreen extends StatefulWidget {
  DashboardScreen({
    super.key,
    required this.saveTasks
  });

  Function saveTasks;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  bool isGotCurrentTask = false;
  int intCurrentTask = 0;

  @override
  void initState() {

    refreshTask();
    super.initState();
  }

  refreshTask(){
    setState(() {
      myTask.length;

      intPendingTask = 0;
      intCompleteTask = 0;
      intOutboxTask = 0;
      intAssignedTask = 0;

      for(var i in myTask){
        switch(i.status){
          case "In Progress":
            intPendingTask += 1;
            break;
          case "Paused":
            intPendingTask += 1;
            break;
          case "Completed":
            intCompleteTask += 1;
            break;
          case "Outbox":
            intOutboxTask += 1;
            break;
          default:
            intAssignedTask += 1;
            break;
        }
      }

      for (int i = 0; i < myTask.length; i++) {
        if(myTask[i].status == "In Progress"){
          isGotCurrentTask = true;
          intCurrentTask = i;
          break;
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                onPressed: () {
                                  setState(() {
                                    refreshTask();
                                  });
                                },
                                tooltip: 'Refresh',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                onPressed: () {
                                  Navigator.pop(context); // Close dialog
                                  // Navigate to login page and remove all previous routes
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginScreen(
                                      saveTasks: widget.saveTasks,
                                    )),
                                        (route) => false,
                                  );
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  //     Container(
                                  //       decoration: BoxDecoration(
                                  //         color: Colors.white.withOpacity(0.2),
                                  //         borderRadius: BorderRadius.circular(12),
                                  //       ),
                                  //       child: IconButton(
                                  //         icon: Icon(
                                  //           Icons.logout,
                                  //           color: Colors.white,
                                  //           size: 22,
                                  //         ),
                                  //         onPressed: () {
                                  //           // Show confirmation dialog
                                  //           showDialog(
                                  //             context: context,
                                  //             builder: (BuildContext context) {
                                  //               return AlertDialog(
                                  //                 title: Text('Logout'),
                                  //                 content: Text('Are you sure you want to logout?'),
                                  //                 actions: [
                                  //                   TextButton(
                                  //                     onPressed: () {
                                  //                       Navigator.pop(context); // Close dialog
                                  //                     },
                                  //                     child: Text('Cancel'),
                                  //                   ),
                                  //                   TextButton(
                                  //                     onPressed: () {
                                  //                       Navigator.pop(context); // Close dialog
                                  //                       // Navigate to login page and remove all previous routes
                                  //                       Navigator.pushNamedAndRemoveUntil(
                                  //                         context,
                                  //                         '/login', // Replace with your login route name
                                  //                             (route) => false,
                                  //                       );
                                  //                     },
                                  //                     child: Text(
                                  //                       'Logout',
                                  //                       style: TextStyle(color: Colors.red),
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               );
                                  //             },
                                  //           );        },
                                  //         tooltip: 'Logout',
                                  //       ),
                                  //     ),
                                  //   ],
                                  // );
                                },
                                tooltip: 'Logout',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      // User Info Card
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Container(
                            //   width: 60,
                            //   height: 60,
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //     gradient: LinearGradient(
                            //       colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                            //     ),
                            //   ),
                            //   child: Icon(
                            //     Icons.person,
                            //     color: Colors.white,
                            //     size: 32,
                            //   ),
                            // ),
                            // SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello, Muhammad',
                                    style: TextStyle(
                                      color: Color(0xFF2C3E50),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // SizedBox(height: 4),
                                  // Text(
                                  //   'Welcome back, work safe..',
                                  //   style: TextStyle(
                                  //     color: Color(0xFF7F8C8D),
                                  //     fontSize: 13,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),

                      // Service Work Order Title
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
                                    // saveTasks: widget.saveTasks,
                                    // refreshTask: refreshTask,
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
                                  Helper().createRoute(CompletedTaskScreen(
                                    // saveTasks: widget.saveTasks,
                                    // refreshTask: refreshTask,
                                  )),
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
              ),

              // No Data Message
              !isGotCurrentTask
                  ? Container(
                margin: const EdgeInsets.fromLTRB(16, 15, 16, 10),
                padding: EdgeInsets.all(32),
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.circular(16),
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.black.withOpacity(0.08),
                //       blurRadius: 10,
                //       offset: Offset(0, 4),
                //     ),
                //   ],
                // ),
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
              )
                  : SizedBox(),

              isGotCurrentTask
               ? GestureDetector(
                onTap: () {
                  // Navigate based on task type
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
                          Text(
                            "Current Task",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 14,
                            ),
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
                      _buildDetailRow("Assigned Date", myTask[intCurrentTask].assignedDate),
                      _buildDetailRow("Equipment Number", myTask[intCurrentTask].equipmentId),
                      _buildDetailRow("Time Start", myTask[intCurrentTask].timeStart),
                      _buildDetailRow("Duration", myTask[intCurrentTask].duration),
                      _buildDetailRow("Pause Time", myTask[intCurrentTask].pauseTime),
                      _buildDetailRow("Pause Reason", myTask[intCurrentTask].pauseReason, isLast: true),
                    ],
                  ),
                ),
              )
                  : SizedBox(),

              // // Bottom Section - WIP List
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Service Work Order - WIP",
              //         style: TextStyle(
              //           color: Color(0xFF2C3E50),
              //           fontSize: 18,
              //           fontWeight: FontWeight.w700,
              //         ),
              //       ),
              //
              //       SizedBox(height: 16),
              //
              //       // // Search Field
              //       // TextField(
              //       //   onChanged: (val) {},
              //       //   decoration: InputDecoration(
              //       //     hintText: 'Search SWO Number',
              //       //     hintStyle: TextStyle(
              //       //       color: Color(0xFFBDC3C7),
              //       //       fontStyle: FontStyle.italic,
              //       //       fontSize: 14,
              //       //     ),
              //       //     suffixIcon: Container(
              //       //       margin: EdgeInsets.all(8),
              //       //       decoration: BoxDecoration(
              //       //         color: Color(0xFF4A90E2),
              //       //         borderRadius: BorderRadius.circular(8),
              //       //       ),
              //       //       child: Icon(
              //       //         Icons.search,
              //       //         color: Colors.white,
              //       //       ),
              //       //     ),
              //       //     filled: true,
              //       //     fillColor: Colors.white,
              //       //     contentPadding: EdgeInsets.symmetric(
              //       //       horizontal: 20,
              //       //       vertical: 16,
              //       //     ),
              //       //     border: OutlineInputBorder(
              //       //       borderRadius: BorderRadius.circular(12),
              //       //       borderSide: BorderSide(
              //       //         width: 1,
              //       //         color: Color(0xFFE0E0E0),
              //       //       ),
              //       //     ),
              //       //     enabledBorder: OutlineInputBorder(
              //       //       borderRadius: BorderRadius.circular(12),
              //       //       borderSide: BorderSide(
              //       //         width: 1,
              //       //         color: Color(0xFFE0E0E0),
              //       //       ),
              //       //     ),
              //       //     focusedBorder: OutlineInputBorder(
              //       //       borderRadius: BorderRadius.circular(12),
              //       //       borderSide: BorderSide(
              //       //         width: 2,
              //       //         color: Color(0xFF4A90E2),
              //       //       ),
              //       //     ),
              //       //   ),
              //       // ),
              //       //
              //       // SizedBox(height: 20),
              //       //
              //       // // No Data Container
              //       // Container(
              //       //   width: double.infinity,
              //       //   padding: EdgeInsets.all(32),
              //       //   decoration: BoxDecoration(
              //       //     borderRadius: BorderRadius.circular(16),
              //       //     color: Colors.white,
              //       //     border: Border.all(
              //       //       color: Color(0xFFE0E0E0),
              //       //       width: 1,
              //       //     ),
              //       //   ),
              //       //   child: Column(
              //       //     children: [
              //       //       Icon(
              //       //         Icons.inbox_outlined,
              //       //         size: 48,
              //       //         color: Color(0xFFBDC3C7),
              //       //       ),
              //       //       SizedBox(height: 12),
              //       //       Text(
              //       //         "No Data Available",
              //       //         style: TextStyle(
              //       //           color: Color(0xFF7F8C8D),
              //       //           fontSize: 16,
              //       //           fontWeight: FontWeight.w500,
              //       //         ),
              //       //       ),
              //       //     ],
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
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