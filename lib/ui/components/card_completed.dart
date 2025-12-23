import 'package:flutter/material.dart';

import '../screen06_completed_breakdown.dart';
import '../screen07_completed_preventive.dart';


class CardCompletedTask extends StatefulWidget {
  final String subtaskNumber;
  final String equipmentNo;
  final String taskType;
  final String dept;
  final String startDate;
  final String endDate;
  final String assignedDate;

  const CardCompletedTask({
    super.key,
    this.subtaskNumber = '',
    this.equipmentNo = '',
    this.taskType = '',
    this.dept = '',
    this.startDate = '',
    this.endDate = '',
    this.assignedDate = '',
  });

  @override
  State<CardCompletedTask> createState() => _CardCompletedTaskState();
}

class _CardCompletedTaskState extends State<CardCompletedTask> {
  void _navigateToTaskScreen(BuildContext context) {
    if (widget.taskType == 'BD') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompletedTaskBD(
            subtaskNumber: widget.subtaskNumber,
            taskType: widget.taskType,
            equipmentNo: widget.equipmentNo,
            assignedDate: widget.assignedDate,
            dept: widget.dept,
          ),
        ),
      );
    } else if (widget.taskType == 'PM') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompletedTaskPM(
            subtaskNumber: widget.subtaskNumber,
            taskType: widget.taskType,
            equipmentNo: widget.equipmentNo,
            assignedDate: widget.assignedDate,
            dept: widget.dept,
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
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.subtaskNumber,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: widget.taskType == 'BD'
                                ? Color(0xffff8700)
                                : widget.taskType == 'PM'
                                ? Color(0xffe10707)
                                : Color(0xffed4747),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5.0),
                            child: Text(
                              widget.taskType,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5.0),
                            child: Text(
                              widget.dept,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.equipmentNo,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.startDate,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.assignedDate,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.endDate,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}