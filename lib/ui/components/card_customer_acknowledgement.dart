import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:field_technician_demo/app_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

import '../data_model/outbox_model.dart';
import '../screen03_outbox_service.dart';
import '../screen06_completed_breakdown.dart';
import '../screen07_completed_preventive.dart';

class CustomerAcknowledgmentPopup extends StatefulWidget {
  final String swoNumber;
  final String? customerName;
  final String? customerContact;
  final String taskType;
  final String dept;
  final String equipmentNo;
  final String assignedDate;
  final Map<String, dynamic>? taskData; // Pass existing task data
  final VoidCallback onCancel;
  final int selectedIndex;
  Function saveTasks;

  CustomerAcknowledgmentPopup({
    super.key,
    this.swoNumber = '',
    this.customerName = '',
    this.customerContact = '',
    required this.taskType,
    this.dept = '',
    this.equipmentNo = '',
    this.assignedDate = '',
    this.taskData,
    required this.onCancel,
    required this.selectedIndex,
    required this.saveTasks
  });

  @override
  State<CustomerAcknowledgmentPopup> createState() =>
      _CustomerAcknowledgmentPopupState();
}

class _CustomerAcknowledgmentPopupState
    extends State<CustomerAcknowledgmentPopup> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerContactController =
  TextEditingController();
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  bool _isSignatureStarted = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill if data exists
    if (widget.customerName != null && widget.customerName!.isNotEmpty) {
      _customerNameController.text = widget.customerName!;
    }
    if (widget.customerContact != null && widget.customerContact!.isNotEmpty) {
      _customerContactController.text = widget.customerContact!;
    }
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerContactController.dispose();
    super.dispose();
  }

  bool _isSignatureEmpty() {
    return !_isSignatureStarted;
  }

  void _showToast(String message, {required bool isError}) {
    if (!mounted) return;

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: isError ? const Color(0xFFE74C3C) : const Color(0xFF27AE60),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<String?> _getSignatureAsBase64() async {
    try {
      final signatureData =
      await _signaturePadKey.currentState?.toImage(pixelRatio: 3.0);
      if (signatureData == null) return null;

      final byteData =
      await signatureData.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return null;

      final bytes = byteData.buffer.asUint8List();
      return bytes.toString(); // You can convert to base64 if needed
    } catch (e) {
      print('Error getting signature: $e');
      return null;
    }
  }

  Future<void> _handleSubmit() async {
    // Validate inputs
    if (_customerNameController.text.trim().isEmpty) {
      _showToast('Please enter customer name', isError: true);
      return;
    }

    if (_customerContactController.text.trim().isEmpty) {
      _showToast('Please enter customer contact number', isError: true);
      return;
    }

    if (_isSignatureEmpty()) {
      _showToast('Please provide customer signature', isError: true);
      return;
    }

    setState(() {
      _isSubmitting = true;
      myTask[widget.selectedIndex].customerName = _customerNameController.text.toString();
      myTask[widget.selectedIndex].customerContact = _customerContactController.text.toString();

      widget.saveTasks(myTask);

    });

    try {
      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      final isOnline = connectivityResult != ConnectivityResult.none;

      // Get signature data
      final signatureData = await _getSignatureAsBase64();

      // Prepare complete task data
      final completeTaskData = {
        ...?widget.taskData, // Merge existing task data
        'customerName': _customerNameController.text.trim(),
        'customerContact': _customerContactController.text.trim(),
        'customerSignature': signatureData,
        'submittedAt': DateTime.now().toIso8601String(),
      };

      if (isOnline) {
        // Submit directly if online
        await _submitTaskOnline(completeTaskData);

        if (mounted) {
          _showToast('Task submitted successfully!', isError: false);
          await Future.delayed(const Duration(seconds: 1));
          myTask[widget.selectedIndex].status = "Completed";
          myTask[widget.selectedIndex].timeEnd = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

          final DateFormat fmt = DateFormat('dd-MM-yyyy HH:mm:ss');
          DateTime startTime = fmt.parse(myTask[widget.selectedIndex].timeStart);
          DateTime endTime   = fmt.parse(myTask[widget.selectedIndex].timeEnd);

          Duration diff = endTime.difference(startTime);
          double totalHours = diff.inMinutes / 60;

          if(totalHours < 1){
            myTask[widget.selectedIndex].duration = 1.toString();
          }else{
            myTask[widget.selectedIndex].duration = totalHours.toString();
          }

          widget.saveTasks(myTask);

          _navigateToCompletedScreen();
        }
      } else {
        // Save to outbox if offline

        myTask[widget.selectedIndex].status = "Outbox";
        widget.saveTasks(myTask);

        final outboxTask = OutboxTask(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          swoNumber: widget.swoNumber,
          taskType: widget.taskType,
          dept: widget.dept,
          equipmentNo: widget.equipmentNo,
          assignedDate: widget.assignedDate,
          taskData: completeTaskData,
          savedAt: DateTime.now(),
        );

        final saved = await OutboxService().saveToOutbox(outboxTask);

        if (mounted) {
          if (saved) {
            _showToast(
              'No internet. Task saved to outbox.',
              isError: false,
            );
            await Future.delayed(const Duration(seconds: 2));
            Navigator.of(context).pop(); // Close popup
            Navigator.of(context).pop(); // Go back to task list
          } else {
            _showToast('Failed to save task. Please try again.', isError: true);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        _showToast('Submission failed: ${e.toString()}', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _submitTaskOnline(Map<String, dynamic> taskData) async {
    // TODO: Replace with your actual API call
    // Example:
    // final response = await http.post(
    //   Uri.parse('YOUR_API_ENDPOINT/submit-task'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(taskData),
    // );
    //
    // if (response.statusCode != 200) {
    //   throw Exception('Failed to submit task');
    // }

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
  }

  void _navigateToCompletedScreen() {
    if (!mounted) return;

    if (widget.taskType.toUpperCase() == 'BD') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => CompletedTaskBD(
            /*
            subtaskNumber: widget.subtaskNumber,
            taskType: widget.taskType,
            equipmentNo: widget.equipmentNo,
            assignedDate: widget.assignedDate,
            dept: widget.dept,
            customerName: widget.customerName,
            customerContact: widget.customerContact,
            */
            selectedIndex: widget.selectedIndex,
            // Pass other required data from widget.taskData if needed
          ),
        ),
      );
    } else if (widget.taskType.toUpperCase() == 'PM') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => CompletedTaskPM(
            /*
            subtaskNumber: widget.subtaskNumber,
            taskType: widget.taskType,
            equipmentNo: widget.equipmentNo,
            assignedDate: widget.assignedDate,
            dept: widget.dept,
            customerName: widget.customerName,
            customerContact: widget.customerContact,
            */
            selectedIndex: widget.selectedIndex,
            // Pass other required data from widget.taskData if needed
          ),
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        width: 420,
        constraints: const BoxConstraints(maxHeight: 580),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Modern Header with gradient
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0A4D8C),
                    Color(0xFF0A57A3),
                    Color(0xFF0D7AC4),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Customer Acknowledgment',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Customer Name Field
                    const Text(
                      'Customer Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _customerNameController,
                      decoration: InputDecoration(
                        hintText: 'Enter customer name',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.grey.shade500,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF3498DB),
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Customer Contact Field
                    const Text(
                      'Customer Contact No.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _customerContactController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter contact number',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          color: Colors.grey.shade500,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF3498DB),
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Customer Signature
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Customer Signature',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        if (_isSignatureStarted)
                          TextButton.icon(
                            onPressed: () {
                              _signaturePadKey.currentState?.clear();
                              setState(() {
                                _isSignatureStarted = false;
                              });
                            },
                            icon: const Icon(Icons.refresh, size: 18),
                            label: const Text('Clear'),
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFFE74C3C),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Signature Pad
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF3498DB),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            SfSignaturePad(
                              key: _signaturePadKey,
                              minimumStrokeWidth: 1.5,
                              maximumStrokeWidth: 3.5,
                              strokeColor: const Color(0xFF2C3E50),
                              backgroundColor: Colors.white,
                              onDrawStart: () {
                                setState(() {
                                  _isSignatureStarted = true;
                                });
                                return false;
                              },
                            ),
                            if (!_isSignatureStarted)
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.gesture,
                                      size: 48,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Sign Here',
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer Buttons
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isSubmitting ? null : widget.onCancel,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isSubmitting
                            ? Colors.grey.shade300
                            : const Color(0xFF27AE60),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: _isSubmitting ? 0 : 2,
                      ),
                      child: _isSubmitting
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Submitting...',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                          : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Submit',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Demo completion screens
class CompletedTaskBDDemo extends StatelessWidget {
  const CompletedTaskBDDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Task - BD'),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Color(0xFF27AE60)),
            const SizedBox(height: 16),
            const Text(
              'Task Completed Successfully!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Breakdown Task Type',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

class CompletedTaskPMDemo extends StatelessWidget {
  const CompletedTaskPMDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Task - PM'),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Color(0xFF27AE60)),
            const SizedBox(height: 16),
            const Text(
              'Task Completed Successfully!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Preventive Maintenance Task Type',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}