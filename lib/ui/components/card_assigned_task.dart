import 'package:flutter/material.dart';
import '../../app_data.dart';
import '../screen04_breakdown_task.dart';
import '../screen05_preventive_task.dart';
import '../screen05_request_spare_part.dart'; // Import your BD screen

class CardAssignedTask extends StatefulWidget {
  final String swoNumber;
  final String taskType;
  final String equipmentNo;
  final String assignedDate;
  final String dept;
  final int selectedIndex;
  Function saveTasks;
  Function refreshList;

  CardAssignedTask({
    super.key,
    this.swoNumber = '',
    this.taskType = '',
    this.equipmentNo = '',
    this.assignedDate = '',
    this.dept = '',
    required this.selectedIndex,
    required this.saveTasks,
    required this.refreshList
  });

  @override
  State<CardAssignedTask> createState() => _CardAssignedTaskState();
}

class _CardAssignedTaskState extends State<CardAssignedTask> {
  void _navigateToTaskScreen(BuildContext context) {
    if (widget.taskType == 'BD') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SwoChecklistBD(
            subtaskNumber: widget.swoNumber,
            taskType: widget.taskType,
            equipmentNo: widget.equipmentNo,
            assignedDate: widget.assignedDate,
            dept: widget.dept,
            selectedIndex: widget.selectedIndex,
            saveTasks: widget.saveTasks,
            refreshList: widget.refreshList,
          ),
        ),
      );
    } else if (widget.taskType == 'PM') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SwoChecklistPM(
            subtaskNumber: widget.swoNumber,
            taskType: widget.taskType,
            equipmentNo: widget.equipmentNo,
            assignedDate: widget.assignedDate,
            dept: widget.dept,
            selectedIndex: widget.selectedIndex,
            saveTasks: widget.saveTasks,
            refreshList: widget.refreshList,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () => _navigateToTaskScreen(context),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.swoNumber,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: widget.taskType == 'BD'
                            ? Color(0xffff8700)
                            : widget.taskType == 'PM'
                            ? Color(0xffe10707)
                            : Color(0xffed4747),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 30.0),
                        child: Center(
                          child: Text(
                            widget.taskType,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffdddddd),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 30.0),
                        child: Center(
                          child: Text(
                            widget.dept,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(widget.equipmentNo,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(
                  height: 4,
                ),
                Text(widget.assignedDate,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    )),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    // In CardAssignedTask widget, update the Request Parts button's onTap:

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SparePartIssuesScreen(
                                swoNumber: widget.swoNumber,
                                taskType: widget.taskType,
                                spareParts: myTask[widget.selectedIndex].spareParts,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffF39C12).withOpacity(0.1),
                            border: Border.all(
                              color: const Color(0xFFF39C12),
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Center(
                              child: Text(
                                "Request Parts",
                                style: TextStyle(
                                  color: Color(0xFFF39C12),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _navigateToTaskScreen(context),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff16bd04).withOpacity(0.1),
                            border: Border.all(
                              color: const Color(0xFF07B31E),
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Center(
                              child: Text(
                                "View Task",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}