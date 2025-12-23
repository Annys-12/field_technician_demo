import 'package:field_technician_demo/ui/screen05_request_spare_part.dart';
import 'package:field_technician_demo/ui/screen08_submit.dart';
import 'package:field_technician_demo/ui/screen10_service_checklist.dart';
import 'package:field_technician_demo/ui/screen12_rental_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SwoChecklistPM extends StatefulWidget {
  final String subtaskNumber;
  final String taskType;
  final String equipmentNo;
  final String assignedDate;
  final String dept;

  const SwoChecklistPM({
    super.key,
    this.subtaskNumber = 'STK-001',
    this.taskType = 'PM',
    this.equipmentNo = 'EQ-12345',
    this.assignedDate = '18-12-2025',
    this.dept = 'EE',
  });

  @override
  State<SwoChecklistPM> createState() => _SwoChecklistPMState();
}

class _SwoChecklistPMState extends State<SwoChecklistPM> {
  // Task status state
  String currentStatus = 'New Task';
  bool isServiceTaskDetailsExpanded = false;

  // Task timing info
  String timeStart = '---';
  String duration = '0 hour';
  String pauseTime = '-';
  String pauseReason = '-';

  // Controllers
  final TextEditingController hourMeter1Controller = TextEditingController(text: '');
  final TextEditingController hourMeter2Controller = TextEditingController(text: '');

  // Photo functionality
  final ImagePicker _picker = ImagePicker();
  final List<File> _photos = [];
  final int _maxPhotos = 8;

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

  void startTask() {
    setState(() {
      isServiceTaskDetailsExpanded = false;
      if (currentStatus == 'New Task' || currentStatus == 'Paused') {
        currentStatus = 'In Progress';
        if (timeStart == '---') {
          timeStart = '18-12-2025 09:30:00';
        }
      }
    });
    _showToast('Task started successfully', isError: false);
  }

  void pauseTask() {
    if (currentStatus != 'In Progress') {
      _showToast('Task must be in progress to pause', isError: true);
      return;
    }

    showDialog(
      context: context,
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
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Service Task ID: ${widget.subtaskNumber}'),
                    const SizedBox(height: 16),
                    const Text(
                      'Select Reason',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    ...['Waiting for Spare Part', 'Waiting for Approval', 'Cannot Complete Today', 'On Break']
                        .map((reason) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => setDialogState(() => selectedReason = reason),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: reason == selectedReason
                                ? const Color(0xFF6366F1)
                                : const Color(0xFFE0E7FF),
                            foregroundColor: reason == selectedReason ? Colors.white : const Color(0xFF6366F1),
                            elevation: reason == selectedReason ? 4 : 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(reason, style: const TextStyle(fontSize: 14)),
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
                              side: const BorderSide(color: Color(0xFF6366F1)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Cancel'),
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
                                currentStatus = 'Paused';
                                pauseReason = selectedReason;
                                pauseTime = '18-12-2025 11:30:00';
                              });
                              _showToast('Task paused', isError: false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6366F1),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
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

  Future<void> _takePhoto() async {
    if (_photos.length >= _maxPhotos) {
      _showToast('Maximum $_maxPhotos photos allowed', isError: true);
      return;
    }
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() => _photos.add(File(photo.path)));
    }
  }

  Future<void> _pickFromGallery() async {
    if (_photos.length >= _maxPhotos) {
      _showToast('Maximum $_maxPhotos photos allowed', isError: true);
      return;
    }
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _photos.add(File(image.path)));
    }
  }

  void _removePhoto(int index) {
    setState(() => _photos.removeAt(index));
  }

  void _showToast(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(isError ? Icons.error_outline : Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError ? const Color(0xFFEF4444) : const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isServiceTaskDetailsExpanded = false);
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF0A4D8C),
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
            // Header Section
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
                        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => setState(() => isServiceTaskDetailsExpanded = !isServiceTaskDetailsExpanded),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Service Task Details',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                                ),
                                Icon(
                                  isServiceTaskDetailsExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                  color: const Color(0xFF64748B),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isServiceTaskDetailsExpanded)
                          Container(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Column(
                              children: [
                                const Divider(height: 1),
                                const SizedBox(height: 12),
                                _buildDetailRow('Equipment No.', widget.equipmentNo),
                                _buildDetailRow('SWO Type', widget.taskType),
                                _buildDetailRow('SWO No.', widget.subtaskNumber),
                                _buildDetailRow('Assigned Date', widget.assignedDate),
                                _buildDetailRow('PIC Remarks', 'Regular maintenance required'),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RentalDetailsScreen(
                                    swoNumber: widget.subtaskNumber,
                                    taskType: widget.taskType,
                                    rentalCompanyName: 'ABC Rental Sdn. Bhd.',
                                    picName: 'Ahmed Ali',
                                    picContact: '+60 12-345 6789',
                                    latitude: '3.074118505286947',
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
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Status Indicator
            Container(
              height: 4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffe10707), Color(0xFFAF0421)],
                ),
              ),
            ),

            // Content Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Task Status Card
                    _buildCard(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Task Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: currentStatus == 'In Progress' ? null : startTask,
                                  icon: Icon(_getStartButtonIcon(), size: 18),
                                  label: Text(_getStartButtonText()),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _getStartButtonColor(),
                                    foregroundColor: Colors.white,
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
                                  label: const Text('Pause'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: currentStatus == 'In Progress'
                                        ? const Color(0xFFEF4444)
                                        : const Color(0xFFE2E8F0),
                                    foregroundColor: currentStatus == 'In Progress' ? Colors.white : const Color(0xFF94A3B8),
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
                    _buildCard(
                      title: 'Task Details',
                      child: Column(
                        children: [
                          _buildInfoRow('Assigned Date', widget.assignedDate),
                          _buildInfoRow('Time Start', timeStart),
                          _buildInfoRow('Duration', duration),
                          _buildInfoRow('Pause Time', pauseTime),
                          _buildInfoRow('Pause Reason', pauseReason),
                        ],
                      ),
                    ),

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
                    _buildCard(
                      title: 'Add Photos',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                        border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
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
                                            color: Color(0xFFEF4444),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.close, color: Colors.white, size: 16),
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

                    const SizedBox(height: 24),

                    // Complete Button onPressed in SwoChecklistPM
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to Submit Page for PM tasks
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubmitForm(
                                swoNumber: widget.subtaskNumber,
                                swoType: 'PM',
                                spareParts: [
                                  {'name': 'Engine Oil Filter', 'code': 'EOF-1234'},
                                  {'name': 'Air Filter', 'code': 'AF-5678'},
                                  {'name': 'Hydraulic Oil', 'code': 'HO-9012'},
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

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({String? title, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
              ),
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, title != null ? 0 : 16, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E293B), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text('$label:', style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF1E293B), fontSize: 14),
            ),
          ),
        ],
      ),
    );
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

  Widget _buildActionButton(String label, IconData icon, Color backgroundColor, Color foregroundColor, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontSize: 13)),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
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

  Color _getStatusColor() {
    switch (currentStatus) {
      case 'In Progress':
        return const Color(0xFF3B82F6);
      case 'Paused':
        return const Color(0xFFF59E0B);
      case 'Completed':
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF64748B);
    }
  }

  Color _getStartButtonColor() {
    return currentStatus == 'In Progress' ? const Color(0xFFE2E8F0) : const Color(
        0xFF27AE60);
  }

  String _getStartButtonText() {
    if (currentStatus == 'Paused') return 'Resume';
    if (currentStatus == 'In Progress') return 'Started';
    return 'Start';
  }

  IconData _getStartButtonIcon() {
    if (currentStatus == 'Paused') return Icons.play_arrow;
    if (currentStatus == 'In Progress') return Icons.check;
    return Icons.play_arrow;
  }
}