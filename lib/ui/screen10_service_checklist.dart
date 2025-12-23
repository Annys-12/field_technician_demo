import 'package:field_technician_demo/ui/screen11_subtask.dart';
import 'package:flutter/material.dart';

class ServiceChecklistScreen extends StatefulWidget {
  final String taskType;
  final String checklistItem;
  final int checklistIndex;

  const ServiceChecklistScreen({
    Key? key,
    required this.taskType,
    required this.checklistItem,
    required this.checklistIndex,
  }) : super(key: key);

  @override
  State<ServiceChecklistScreen> createState() => _ServiceChecklistScreenState();
}

class _ServiceChecklistScreenState extends State<ServiceChecklistScreen> {
  // Dummy data for subtasks
  final List<Map<String, dynamic>> subtasks = [
    {
      'description': 'Alternator Charging (DC)',
      'status': 0,
    },
    {
      'description': 'Change Radiator',
      'status': 0,
    }
  ];

  void updateSubtaskStatus(int index) {
    setState(() {
      subtasks[index]['status'] = 1;
    });
  }

  // Check if all subtasks are completed
  bool get allSubtasksCompleted {
    return subtasks.every((subtask) => subtask['status'] == 1);
  }

  // Handle back navigation
  void _handleBack() {
    Navigator.pop(context, allSubtasksCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _handleBack();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF1E293B),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
            onPressed: _handleBack,
          ),
          title: Column(
            children: [
              const Text(
                "Service Checklist",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                widget.checklistItem,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Gradient separator
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.taskType == 'PM'
                      ? [const Color(0xFFE10707), const Color(0xFFAF0421)]
                      : [Color(0xffef8906), Color(0xFFF6DA1C)],
                ),
              ),
            ),


            // Select Subtask label with completion status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select Subtask",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  // Show completion status
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: allSubtasksCompleted
                          ? const Color(0xFF10B981).withOpacity(0.1)
                          : const Color(0xFF3B82F6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: allSubtasksCompleted
                            ? const Color(0xFF10B981)
                            : const Color(0xFF3B82F6),
                      ),
                    ),
                    child: Text(
                      '${subtasks.where((s) => s['status'] == 1).length}/${subtasks.length}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: allSubtasksCompleted
                            ? const Color(0xFF10B981)
                            : const Color(0xFF3B82F6),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Subtasks list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: subtasks.length,
                itemBuilder: (context, index) {
                  final subtask = subtasks[index];
                  final isCompleted = subtask['status'] == 1;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubtaskServiceChecklist(
                                subtaskName: subtask['description'],
                                taskType: widget.taskType,
                                onComplete: () => updateSubtaskStatus(index),
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? const Color(0xFF10B981).withOpacity(0.08)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isCompleted
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFE2E8F0),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  subtask['description'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                    color: isCompleted
                                        ? const Color(0xFF10B981)
                                        : const Color(0xFF1E293B),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              if (isCompleted)
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF10B981),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                )
                              else
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.grey.shade400,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}