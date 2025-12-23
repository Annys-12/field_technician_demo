import 'package:field_technician_demo/ui/screen05_request_spare_part.dart';
import 'package:field_technician_demo/ui/screen08_submit.dart';
import 'package:field_technician_demo/ui/screen09_breakdown_notes.dart';
import 'package:field_technician_demo/ui/screen10_service_checklist.dart';
import 'package:field_technician_demo/ui/screen12_rental_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class SwoChecklistBD extends StatefulWidget {
  final String subtaskNumber;
  final String taskType;
  final String equipmentNo;
  final String assignedDate;
  final String dept;

  const SwoChecklistBD({
    super.key,
    this.subtaskNumber = '',
    this.taskType = '',
    this.equipmentNo = '',
    this.assignedDate = '',
    this.dept = '',
  });

  @override
  State<SwoChecklistBD> createState() => _SwoChecklistBDState();
}

class _SwoChecklistBDState extends State<SwoChecklistBD> {
  // Task status
  String currentStatus = 'New Task';
  String timeStart = '---';
  String duration = '0 hour';
  String pauseTime = '-';
  String pauseReason = '-';


  final List<String> pauseReasons = [
    'Waiting for Spare Part',
    'Waiting for Approval',
    'Cannot Complete Today',
    'Prioritize Another Task',
    'On Break',
  ];

  // Start Task Method
  void startTask() {
    setState(() {
      isServiceTaskDetailsExpanded = false;
      if (currentStatus == 'New Task' || currentStatus == 'Paused') {
        currentStatus = 'In Progress';
        if (timeStart == '---') {
          timeStart = '18-12-2025 09:30:00';
        }
        // Clear pause data when resuming
        if (pauseTime != '-') {
          pauseTime = '-';
          pauseReason = '-';
        }
      }
    });
    _showToast('Task started successfully', isError: false);
  }

// Pause Task Method
  void pauseTask() {
    if (currentStatus != 'In Progress') {
      _showToast('Task must be in progress to pause', isError: true);
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String selectedReason = '';
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Pause Task',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Service Task ID: ${widget.subtaskNumber}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Select Reason',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Pause reason buttons
                    ...pauseReasons.map((reason) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => setDialogState(() => selectedReason = reason),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: reason == selectedReason
                                ? const Color(0xFF3498DB)
                                : const Color(0xFFF8F9FA),
                            foregroundColor: reason == selectedReason
                                ? Colors.white
                                : const Color(0xFF2C3E50),
                            elevation: reason == selectedReason ? 2 : 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: reason == selectedReason
                                    ? const Color(0xFF3498DB)
                                    : Colors.grey.shade300,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Text(
                            reason,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: reason == selectedReason
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(color: Color(0xFF3498DB), width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Color(0xFF3498DB),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: selectedReason.isEmpty
                                ? null
                                : () {
                              Navigator.pop(context);
                              setState(() {
                                isServiceTaskDetailsExpanded = false;
                                currentStatus = 'Paused';
                                pauseReason = selectedReason;
                                pauseTime = '18-12-2025 11:30:00';
                                duration = '2 hours'; // Example duration
                              });
                              _showToast('Task paused', isError: false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedReason.isEmpty
                                  ? Colors.grey.shade300
                                  : const Color(0xFFE74C3C),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: selectedReason.isEmpty ? 0 : 2,
                            ),
                            child: const Text(
                              'Confirm',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showToast(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError ? const Color(0xFFE74C3C) : const Color(0xFF27AE60),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }



  // UI state
  bool isServiceTaskDetailsExpanded = false;

  // Controllers
  final TextEditingController hourMeter1Controller = TextEditingController();
  final TextEditingController hourMeter2Controller = TextEditingController();

  // Photo functionality
  final ImagePicker _picker = ImagePicker();
  final List<File> _photos = [];
  final int _maxPhotos = 8;

  // Breakdown notes
  final List<Map<String, String>> _breakdownNotes = [];
  bool _isTTLSelected = false;
  bool _isCustomerSelected = false;

  // Dummy service checklist data
  final List<Map<String, dynamic>> serviceChecklist = [
    {'name': 'Engine Check', 'completed': false},
    {'name': 'Oil Level Inspection', 'completed': false},
    {'name': 'Hydraulic System', 'completed': false},
    {'name': 'Brake System', 'completed': false},
  ];

  @override
  void dispose() {
    hourMeter1Controller.dispose();
    hourMeter2Controller.dispose();
    super.dispose();
  }

  Future<void> _takePhoto() async {
    if (_photos.length >= _maxPhotos) {
      _showPhotoLimitDialog();
      return;
    }
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _photos.add(File(photo.path));
      });
    }
  }

  Future<void> _pickFromGallery() async {
    if (_photos.length >= _maxPhotos) {
      _showPhotoLimitDialog();
      return;
    }
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _photos.add(File(image.path));
      });
    }
  }

  void _showPhotoLimitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Photo Limit Reached'),
        content: const Text('You can add a maximum of 8 photos.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _removePhoto(int index) {
    setState(() {
      _photos.removeAt(index);
    });
  }

  void _addBreakdownNote() {
    // Navigate to breakdown notes screen (placeholder)
    setState(() {
      _breakdownNotes.add({
        'item': 'Sample Item ${_breakdownNotes.length + 1}',
        'quantity': '1',
        'notes': 'Sample notes',
      });
    });
  }

  void _removeBreakdownNote(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Remove Note'),
          content: const Text('Are you sure you want to remove this breakdown note?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _breakdownNotes.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Add this method to navigate to the Breakdown Notes page
  void _navigateToBreakdownNotes({int? editIndex}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BreakdownNotesPage(
          swoNumber: widget.subtaskNumber,
          existingNote: editIndex != null ? _breakdownNotes[editIndex] : null,
        ),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        if (editIndex != null) {
          _breakdownNotes[editIndex] = result;
          _showToast('Breakdown note updated', isError: false);
        } else {
          _breakdownNotes.add(result);
          _showToast('Breakdown note added', isError: false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isServiceTaskDetailsExpanded = false;
        });
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
            Color(0xFF0A4D8C),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            children: [
              const Text(
                "Service Work Order",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                widget.subtaskNumber,
                style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Header Section with gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0A4D8C),
                    Color(0xFF0A57A3),
                    Color(0xFF0D7AC4),
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Service Task Details Card
                  Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isServiceTaskDetailsExpanded = !isServiceTaskDetailsExpanded;
                            });
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Service Task Details',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2C3E50),
                                  ),
                                ),
                                Icon(
                                  isServiceTaskDetailsExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: const Color(0xFF3498DB),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isServiceTaskDetailsExpanded)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Column(
                              children: [
                                Divider(color: Colors.grey.shade200),
                                const SizedBox(height: 12),
                                _buildDetailRow('Equipment No.', widget.equipmentNo),
                                _buildDetailRow('SWO Type', widget.taskType),
                                _buildDetailRow('SWO No.', widget.subtaskNumber),
                                _buildDetailRow('Assigned Date', widget.assignedDate),
                                _buildDetailRow('Department', widget.dept),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Action Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            'Rental Details',
                            Icons.description_outlined,
                            Colors.white.withOpacity(0.15),
                            Colors.white,
                                () {
                              // Navigate to Rental Details
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RentalDetailsScreen(
                                    swoNumber: widget.subtaskNumber,
                                    taskType: widget.taskType,
                                    rentalCompanyName: 'ABC Rental Sdn. Bhd.', // Use your dummy data
                                    picName: 'Ahmed Ali',
                                    picContact: '+60 12-345 6789',
                                    latitude: '3.074118505286947', // Your GPS coordinates
                                    longitude: '101.62514851595668',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: _buildActionButton(
                            'Spare Parts',
                            Icons.build_circle_outlined,
                            Colors.white.withOpacity(0.15),
                            Colors.white,
                                () {
                              // Navigate to Spare Parts
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SparePartIssuesScreen(
                                    subtaskNumber: widget.subtaskNumber,
                                    taskType: widget.taskType,
                                    spareParts: [
                                      {
                                        'item_name': 'Brake Pad Set',
                                        'item_code': 'BP-3456',
                                        'quantity': '2',
                                      },
                                      {
                                        'item_name': 'Hydraulic Hose',
                                        'item_code': 'HH-7890',
                                        'quantity': '1',
                                      },
                                      {
                                        'item_name': 'Engine Belt',
                                        'item_code': 'EB-2345',
                                        'quantity': '3',
                                      },
                                      {
                                        'item_name': 'Coolant Fluid',
                                        'item_code': 'CF-6789',
                                        'quantity': '5',
                                      },
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            Container(
              height: 4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffef8906), Color(0xFFF6DA1C)],
                ),
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Task Status Card
                      _buildModernCard(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Task Status',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Color(0xFF2C3E50),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor().withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: _getStatusColor().withOpacity(0.3)),
                                  ),
                                  child: Text(
                                    currentStatus,
                                    style: TextStyle(
                                      color: _getStatusColor(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: currentStatus == 'In Progress' ? null : startTask,
                                    icon: Icon(
                                      currentStatus == 'Paused'
                                          ? Icons.play_arrow
                                          : currentStatus == 'In Progress'
                                          ? Icons.check
                                          : Icons.play_arrow,
                                      size: 18,
                                    ),
                                    label: Text(
                                      currentStatus == 'Paused'
                                          ? 'Resume'
                                          : currentStatus == 'In Progress'
                                          ? 'Started'
                                          : 'Start',
                                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: currentStatus == 'In Progress'
                                          ? Colors.grey.shade300
                                          : const Color(0xFF27AE60),
                                      foregroundColor: currentStatus == 'In Progress'
                                          ? Colors.grey.shade600
                                          : Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      elevation: currentStatus == 'In Progress' ? 0 : 2,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: currentStatus == 'In Progress' ? pauseTask : null,
                                    icon: const Icon(Icons.pause, size: 18),
                                    label: const Text(
                                      'Pause',
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: currentStatus == 'In Progress'
                                          ? const Color(0xFFE74C3C)
                                          : Colors.grey.shade300,
                                      foregroundColor: currentStatus == 'In Progress'
                                          ? Colors.white
                                          : Colors.grey.shade600,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      elevation: currentStatus == 'In Progress' ? 2 : 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Task Details Card
                      _buildModernCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Task Details',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow('Assigned Date', widget.assignedDate),
                            _buildInfoRow('Time Start', timeStart),
                            _buildInfoRow('Duration', '0 hour'),
                            _buildInfoRow('Pause Time', pauseTime),
                            _buildInfoRow('Pause Reason', pauseReason),
                          ],
                        ),
                      ),

                      // Replace the hour meter sections in BD with this:
                      const SizedBox(height: 16),

                      // Hour Meters Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildModernCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Hour Meter 1',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Color(0xFF2C3E50),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: hourMeter1Controller,
                                    decoration: InputDecoration(
                                      hintText: 'Enter value',
                                      hintStyle: TextStyle(color: Colors.grey.shade400),
                                      filled: true,
                                      fillColor: const Color(0xFFF8F9FA),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.grey.shade300),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Color(0xFF3498DB), width: 2),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildModernCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Hour Meter 2',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Color(0xFF2C3E50),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: hourMeter2Controller,
                                    decoration: InputDecoration(
                                      hintText: 'Enter value',
                                      hintStyle: TextStyle(color: Colors.grey.shade400),
                                      filled: true,
                                      fillColor: const Color(0xFFF8F9FA),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.grey.shade300),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Color(0xFF3498DB), width: 2),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Service Checklist
                      _buildModernCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Service Checklist',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...serviceChecklist.asMap().entries.map((entry) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () async {
                                      // Navigate to Service Checklist Screen
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ServiceChecklistScreen(
                                            taskType: widget.taskType,
                                            checklistItem: entry.value['name'],
                                            checklistIndex: entry.key,
                                          ),
                                        ),
                                      );

                                      // Update the status if all subtasks are completed
                                      if (result == true) {
                                        setState(() {
                                          serviceChecklist[entry.key]['completed'] = true;
                                        });
                                        _showToast('${entry.value['name']} completed', isError: false);
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: entry.value['completed']
                                            ? const Color(0xFF27AE60).withOpacity(0.1)
                                            : const Color(0xFFF8F9FA),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: entry.value['completed']
                                              ? const Color(0xFF27AE60)
                                              : Colors.grey.shade200,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              entry.value['name'],
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF2C3E50),
                                              ),
                                            ),
                                          ),
                                          if (entry.value['completed'])
                                            const Icon(
                                              Icons.check_circle,
                                              color: Color(0xFF27AE60),
                                              size: 22,
                                            )
                                          else
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.grey.shade400,
                                              size: 18,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Photos Section
                      _buildModernCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Add Photos',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _buildPhotoOption(
                                  Icons.camera_alt_outlined,
                                  'Camera',
                                  const Color(0xFF3498DB),
                                  _takePhoto,
                                ),
                                const SizedBox(width: 12),
                                _buildPhotoOption(
                                  Icons.image_outlined,
                                  'Gallery',
                                  const Color(0xFF9B59B6),
                                  _pickFromGallery,
                                ),
                              ],
                            ),
                            if (_photos.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: List.generate(_photos.length, (index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: FileImage(_photos[index]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 4,
                                        top: 4,
                                        child: GestureDetector(
                                          onTap: () => _removePhoto(index),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFE74C3C),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      _buildBreakdownNotesSection(),

                      const SizedBox(height: 20),

                      // Complete Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to Submit Page for BD tasks
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubmitForm(
                                  swoNumber: widget.subtaskNumber,
                                  swoType: 'BD',
                                  spareParts: [
                                    {'name': 'Brake Pad Set', 'code': 'BP-3456'},
                                    {'name': 'Hydraulic Hose', 'code': 'HH-7890'},
                                    {'name': 'Engine Belt', 'code': 'EB-2345'},
                                    {'name': 'Coolant Fluid', 'code': 'CF-6789'},
                                  ],
                                  photos: _photos,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF27AE60),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            'Complete Task',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (currentStatus) {
      case 'In Progress':
        return const Color(0xFF3498DB);
      case 'Paused':
        return const Color(0xFFF39C12);
      case 'Completed':
        return const Color(0xFF27AE60);
      default:
        return Colors.grey;
    }
  }

  Widget _buildModernCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildActionButton(
      String label,
      IconData icon,
      Color bgColor,
      Color textColor,
      VoidCallback onPressed,
      ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    );
  }

  Widget _buildPhotoOption(
      IconData icon,
      String label,
      Color color,
      VoidCallback onTap,
      ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Color(0xFF2C3E50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2C3E50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownNotesSection() {
    return _buildModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon
          Row(
            children: [
              const Text(
                'Breakdown Notes',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Add to List Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _navigateToBreakdownNotes(),
              icon: const Icon(Icons.add, size: 20),
              label: const Text(
                'Add to List',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF39C12),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ),

          // List of breakdown notes
          if (_breakdownNotes.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...List.generate(_breakdownNotes.length, (index) {
              final note = _breakdownNotes[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFF39C12).withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Item name with icon
                          Row(
                            children: [
                              const Icon(
                                Icons.build_circle,
                                size: 16,
                                color: Color(0xFFF39C12),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  note['item'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xFF2C3E50),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),

                          // Quantity
                          Row(
                            children: [
                              const Icon(
                                Icons.numbers,
                                size: 14,
                                color: Color(0xFF7F8C8D),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Qty: ${note['quantity']}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),

                          // Notes (if available)
                          if (note['notes']?.isNotEmpty == true) ...[
                            const SizedBox(height: 4),
                            Text(
                              note['notes']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Action buttons (Edit & Delete)
                    Column(
                      children: [
                        IconButton(
                          onPressed: () => _navigateToBreakdownNotes(editIndex: index),
                          icon: const Icon(Icons.edit_outlined),
                          color: const Color(0xFF3498DB),
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(height: 8),
                        IconButton(
                          onPressed: () => _removeBreakdownNote(index),
                          icon: const Icon(Icons.delete_outline),
                          color: const Color(0xFFE74C3C),
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],

          const SizedBox(height: 16),

          // Breakdown Caused by section
          const Text(
            'Breakdown Caused by',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 8),
          _buildCheckbox('TTL', _isTTLSelected, (value) {
            setState(() => _isTTLSelected = value ?? false);
          }),
          _buildCheckbox('Customer', _isCustomerSelected, (value) {
            setState(() => _isCustomerSelected = value ?? false);
          }),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool?) onChanged) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: value ? const Color(0xFF3498DB) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: value ? const Color(0xFF3498DB) : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: value
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2C3E50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}