import 'package:flutter/material.dart';
import '../screen04_breakdown_task.dart';
import '../screen05_preventive_task.dart';

class CardOutbox extends StatefulWidget {
  final String swoNumber;
  final String taskType;
  final String dept;
  final String equipmentNo;
  final String assignedDate;
  final String timeStart;
  final String timeEnd;
  final String status; // 'pending_upload', 'uploading', 'failed'
  final DateTime savedAt;
  final String? errorMessage;
  final Function(String swoNumber)? onRetryUpload;

  const CardOutbox({
    super.key,
    required this.swoNumber,
    required this.taskType,
    required this.dept,
    required this.equipmentNo,
    required this.assignedDate,
    required this.timeStart,
    required this.timeEnd,
    this.status = 'pending_upload',
    required this.savedAt,
    this.errorMessage,
    this.onRetryUpload,
  });

  @override
  State<CardOutbox> createState() => _CardOutboxState();
}

class _CardOutboxState extends State<CardOutbox> {
  bool _isRetrying = false;

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
                const SizedBox(height: 8),
                // Assigned Date and Time Range
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      "Assigned: ${widget.assignedDate}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Row(
                //   children: [
                //     Icon(Icons.access_time, size: 14, color: Colors.grey),
                //     SizedBox(width: 4),
                //     Text(
                //       "${widget.timeStart} - ${widget.timeEnd}",
                //       style: const TextStyle(
                //         fontSize: 13,
                //         fontWeight: FontWeight.w500,
                //         color: Colors.grey,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.save, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      "Saved: ${_formatDateTime(widget.savedAt)}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
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
                  Row(
                    children: [
                      Icon(Icons.error_outline, size: 14, color: Colors.red),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.errorMessage!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _isRetrying ? null : () => _retryUpload(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: _isRetrying
                                ? Colors.grey.withOpacity(0.1)
                                : Color(0xff3498DB).withOpacity(0.1),
                            border: Border.all(
                              color: _isRetrying
                                  ? Colors.grey
                                  : const Color(0xff3498DB),
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Center(
                              child: _isRetrying
                                  ? SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                    Color(0xff3498DB),
                                  ),
                                ),
                              )
                                  : Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
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

  Future<void> _retryUpload() async {
    setState(() {
      _isRetrying = true;
    });

    try {
      // Call the callback if provided, or implement your upload logic here
      if (widget.onRetryUpload != null) {
        await widget.onRetryUpload!(widget.swoNumber);
      } else {
        // Simulate upload delay
        await Future.delayed(Duration(seconds: 2));
        // Your actual upload logic here
      }

      // Show success dialog
      if (mounted) {
        setState(() {
          _isRetrying = false;
        });
        _showResultDialog(
          title: 'Upload Successful',
          message: 'Task ${widget.swoNumber} has been uploaded successfully.',
          isSuccess: true,
        );
      }
    } catch (e) {
      // Show error dialog
      if (mounted) {
        setState(() {
          _isRetrying = false;
        });
        _showResultDialog(
          title: 'Upload Failed',
          message: 'Failed to upload task ${widget.swoNumber}'
              // '.\nError: ${e.toString()}'
          ,
          isSuccess: false,
        );
      }
    }
  }

  void _showResultDialog({
    required String title,
    required String message,
    required bool isSuccess,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: isSuccess ? Color(0xff07B31E) : Color(0xFFE74C3C),
                size: 28,
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          actions: [
            if (!isSuccess)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ),
            if (!isSuccess)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _retryUpload();
                },
                child: Text(
                  'Try Again',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Color(0xff3498DB),
                  ),
                ),
              ),
            if (isSuccess)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Go back to dashboard
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Color(0xff07B31E),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}