import 'package:field_technician_demo/app_data.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'components/card_customer_acknowledgement.dart';

class SubmitForm extends StatefulWidget {
  final String swoNumber;
  final String swoType;
  List<Map<String, dynamic>> spareParts;
  final List<File> photos;
  final int selectedIndex;
  Function saveTasks;

  SubmitForm({
    super.key,
    required this.swoNumber,
    required this.swoType,
    required this.spareParts,
    this.photos = const [],
    required this.selectedIndex,
    required this.saveTasks
  });

  @override
  State<SubmitForm> createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  final TextEditingController _notesController = TextEditingController();
  final Map<String, TextEditingController> _quantityControllers = {};
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Initialize quantity controllers for each spare part
    for (var i = 0; i < widget.spareParts.length; i++) {
      _quantityControllers['$i'] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    _quantityControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _showSuccessToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF27AE60),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showErrorToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFE74C3C),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  bool _validateForm() {
    // Check if all quantities are filled (allow 0 as valid input)
    for (var i = 0; i < widget.spareParts.length; i++) {
      String value = _quantityControllers['$i']?.text.trim() ?? '';
      if (value.isEmpty) {
        return false;
      }
      // Check if the value is a valid number
      if (int.tryParse(value) == null) {
        return false;
      }
    }

    for (var i = 0; i < widget.spareParts.length; i++) {
      String value = _quantityControllers['$i']?.text.trim() ?? '';
      myTask[widget.selectedIndex].spareParts[i]['quantity'] = value;
    }

    widget.saveTasks(myTask);

    return true;
  }

  Future<void> _handleSubmit() async {
    if (!_validateForm()) {
      _showErrorToast('Please enter quantity for all consumed spare parts');
      return;
    }

    // Check if task type requires customer acknowledgment (BD or PM)
    final requiresCustomerAck = ['BD', 'PM'].contains(widget.swoType.toUpperCase());

    myTask[widget.selectedIndex].technicianNotes = _notesController.text.toString();
    widget.saveTasks(myTask);

    if (requiresCustomerAck) {
      // Show customer acknowledgment popup
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomerAcknowledgmentPopup(
            swoNumber: widget.swoNumber,
            taskType: widget.swoType,
            onCancel: () => Navigator.of(context).pop(),
            selectedIndex: widget.selectedIndex,
            saveTasks: widget.saveTasks,
          );
        },
      );
    } else {
      // Direct submission for other task types
      setState(() {
        _isSubmitting = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
        _showSuccessToast('Task submitted successfully!');

        setState(() {
          myTask[widget.selectedIndex].status = "Completed";
          widget.saveTasks(myTask);
        });

        // Navigate back after delay
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          // Modern Header
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
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'Submit Task',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.swoNumber,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Technician Notes Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Technician Notes',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _notesController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: 'Enter your notes here...',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
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
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Spare Parts Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Consumed Spare Parts',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Header Row
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3498DB).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Part Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xFF3498DB),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Quantity',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xFF3498DB),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Spare Parts List
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.spareParts.length,
                          itemBuilder: (context, index) {
                            var part = widget.spareParts[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          part['item_name'] ?? '',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF2C3E50),
                                          ),
                                        ),
                                        if (part['item_code'] != null) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            part['item_code'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: 48,
                                      child: TextField(
                                        controller: _quantityControllers['$index'],
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: '0',
                                          hintStyle: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontSize: 14,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF3498DB),
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // Submit Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isSubmitting
                      ? Colors.grey.shade300
                      : const Color(0xFF27AE60),
                  foregroundColor: Colors.white,
                  elevation: _isSubmitting ? 0 : 4,
                  shadowColor: const Color(0xFF27AE60).withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isSubmitting
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Submitting...',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
                    : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Submit Task',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
// Example usage with dummy data
class SubmitFormDemo extends StatelessWidget {
  const SubmitFormDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SubmitForm(
      swoNumber: 'SWO-2025-001',
      swoType: 'PM',
      spareParts: [
        {'name': 'Engine Oil Filter', 'code': 'EOF-1234'},
        {'name': 'Air Filter', 'code': 'AF-5678'},
        {'name': 'Hydraulic Oil', 'code': 'HO-9012'},
        {'name': 'Brake Pad Set', 'code': 'BP-3456'},
      ],
      photos: [], selectedIndex: 0, saveTasks: ,
    );
  }
}
*/