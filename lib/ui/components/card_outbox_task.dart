import 'package:flutter/material.dart';
import '../screen04_breakdown_task.dart';
import '../screen05_preventive_task.dart';

class CardOutbox extends StatefulWidget {
  final String swoNumber;
  final String taskType;
  final String dept;
  final String equipmentNo;
  final String assignedDate;
  final String status; // 'pending_upload', 'uploading', 'failed'
  final DateTime savedAt;
  final String? errorMessage;

  const CardOutbox({
    super.key,
    required this.swoNumber,
    required this.taskType,
    required this.dept,
    required this.equipmentNo,
    required this.assignedDate,
    this.status = 'pending_upload',
    required this.savedAt,
    this.errorMessage,
  });

  @override
  State<CardOutbox> createState() => _CardOutboxState();
}

class _CardOutboxState extends State<CardOutbox> {
  // void _navigateToTaskScreen(BuildContext context) {
  //   if (widget.taskType == 'BD') {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => SwoChecklistBD(
  //           subtaskNumber: widget.swoNumber,
  //           taskType: widget.taskType,
  //           equipmentNo: widget.equipmentNo,
  //           assignedDate: widget.assignedDate,
  //           dept: widget.dept,
  //         ),
  //       ),
  //     );
  //   } else if (widget.taskType == 'PM') {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => SwoChecklistPM(
  //           subtaskNumber: widget.swoNumber,
  //           taskType: widget.taskType,
  //           equipmentNo: widget.equipmentNo,
  //           assignedDate: widget.assignedDate,
  //           dept: widget.dept,
  //         ),
  //       ),
  //     );
  //   }
  // }

  Color _getStatusColor() {
    switch (widget.status) {
      case 'pending_upload':
        return Color(0xFFF39C12); // Orange
      case 'uploading':
        return Color(0xFF3498DB); // Blue
      case 'failed':
        return Color(0xFFE74C3C); // Red
      default:
        return Color(0xFF95A5A6); // Gray
    }
  }

  IconData _getStatusIcon() {
    switch (widget.status) {
      case 'pending_upload':
        return Icons.cloud_upload_outlined;
      case 'uploading':
        return Icons.cloud_upload;
      case 'failed':
        return Icons.cloud_off;
      default:
        return Icons.cloud_queue;
    }
  }

  String _getStatusText() {
    switch (widget.status) {
      case 'pending_upload':
        return 'Pending Upload';
      case 'uploading':
        return 'Uploading...';
      case 'failed':
        return 'Upload Failed';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        // onTap: () => _navigateToTaskScreen(context),
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
                    SizedBox(width: 8),
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
                Text(
                  widget.equipmentNo,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.assignedDate,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Saved: ${_formatDateTime(widget.savedAt)}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                // Status indicator
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: _getStatusColor().withOpacity(0.1),
                    border: Border.all(
                      color: _getStatusColor(),
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getStatusIcon(),
                          color: _getStatusColor(),
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          _getStatusText(),
                          style: TextStyle(
                            color: _getStatusColor(),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.errorMessage != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    "Error: ${widget.errorMessage}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Retry upload action
                          _retryUpload();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff3498DB).withOpacity(0.1),
                            border: Border.all(
                              color: const Color(0xff3498DB),
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    color: Color(0xff3498DB),
                                    size: 18,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Retry Upload",
                                    style: TextStyle(
                                      color: Color(0xff3498DB),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        // onTap: () => _navigateToTaskScreen(context),
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
                                "View Details",
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

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  void _retryUpload() {
    // Implement retry upload logic
    // This would trigger your upload service
    print("Retrying upload for ${widget.swoNumber}");
  }
}