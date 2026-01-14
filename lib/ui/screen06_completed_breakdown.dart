import 'package:field_technician_demo/app_data.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CompletedTaskBD extends StatefulWidget {

  final int selectedIndex;
  final bool isFromCompletedTask;
  /*
  final String subtaskNumber;
  final String taskType;
  final String equipmentNo;
  final String assignedDate;
  final String dept;
  final String hourMeter1;
  final String hourMeter2;
  final List<File> photos;
  final String pauseReason;
  final String pauseTime;
  final String technicianNotes;
  final String timeStart;
  final String duration;
  final String endTime;
  final String? customerName;
  final String? customerContact;
  final List<Map<String, String>> breakdownNotes;
  final String breakdownCauseBy;
  final List<String> serviceChecklistItems;
  final List<Map<String, dynamic>> consumedParts;
  */

  const CompletedTaskBD({
    super.key,
    required this.selectedIndex,
    this.isFromCompletedTask = false,
    /*
    this.subtaskNumber = '',
    this.taskType = '',
    this.equipmentNo = '',
    this.assignedDate = '',
    this.dept = 'EE',
    this.hourMeter1 = '235',
    this.hourMeter2 = '5576',
    this.photos = const [],
    this.pauseReason = 'Waiting for Spare Part',
    this.pauseTime = '18-08-2025 09:40:00',
    this.timeStart = '18-08-2025 07:40:00',
    this.duration = '1 hour',
    this.serviceChecklistItems = const [
      'Performed load test',
      'Cleaned cooling vents and filters',
      'Updated maintenance log',
    ],
    this.consumedParts = const [
      {'name': 'Motor Bearing SKF 6205', 'quantity': '2'},
      {'name': 'Drive Belt Type A-42', 'quantity': '1'},
      {'name': 'Cooling Fan 120mm', 'quantity': '1'},
    ],
    this.technicianNotes = 'test',
    this.customerName = 'erina',
    this.customerContact = '01732679103',
    this.endTime = '18-08-2025 15:40:00',
    this.breakdownNotes = const [
      {
        'item': 'Motor Bearing',
        'quantity': '2',
        'notes': 'Bearings showing signs of wear and excessive noise'
      },
      {
        'item': 'Drive Belt',
        'quantity': '1',
        'notes': 'Belt tension adjusted and inspected'
      },
    ],
    this.breakdownCauseBy = 'TTL',
    */
  });

  @override
  State<CompletedTaskBD> createState() => _CompletedTaskBDState();
}

class _CompletedTaskBDState extends State<CompletedTaskBD> {
  bool isServiceTaskDetailsExpanded = false;

  @override
  void initState() {
    print("consumed spare parts: ${myTask[widget.selectedIndex].spareParts}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          isServiceTaskDetailsExpanded = false;
        });
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: Column(
          children: [
            // Modern Header
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2C3E50), Color(0xFF3498DB)],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // App Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new,
                                color: Colors.white, size: 20),
                            onPressed: () {
                              if (widget.isFromCompletedTask) {
                                // If coming from completed task, pop only once
                                Navigator.pop(context);
                              } else {
                                // If coming from submit flow, pop 4 times
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Service Work Order",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  myTask[widget.selectedIndex].swoNumber,
                                  style: const TextStyle(
                                    color: Color(0xFFE3F2FD),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 40),
                        ],
                      ),
                    ),

                    // Service Task Details Card
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
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
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
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
                                        ? Icons.keyboard_arrow_up_rounded
                                        : Icons.keyboard_arrow_down_rounded,
                                    color: const Color(0xFF7F8C8D),
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
                                  Divider(height: 1, color: Colors.grey.shade200),
                                  const SizedBox(height: 12),
                                  _buildDetailRow('Equipment No.', myTask[widget.selectedIndex].equipmentId),
                                  _buildDetailRow('SWO Type', myTask[widget.selectedIndex].taskType),
                                  _buildDetailRow('SWO No.', myTask[widget.selectedIndex].swoNumber),
                                  _buildDetailRow('Assigned Date', myTask[widget.selectedIndex].assignedDate),
                                  _buildDetailRow('PIC Remarks', myTask[widget.selectedIndex].technicianNotes),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Status Indicator - Changed to orange for BD
            Container(
              height: 5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
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
                    // Task Details Card
                    _buildModernCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Task Details',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Completed',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: Color(0xFF10B981),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow('Assigned Date', myTask[widget.selectedIndex].assignedDate.isNotEmpty ? myTask[widget.selectedIndex].assignedDate : '---'),
                          _buildInfoRow('Time Start', myTask[widget.selectedIndex].timeStart.isNotEmpty ? myTask[widget.selectedIndex].timeStart : '---'),
                          _buildInfoRow('Duration', myTask[widget.selectedIndex].duration.isNotEmpty ? myTask[widget.selectedIndex].duration : '---'),
                          _buildInfoRow('Pause Time', myTask[widget.selectedIndex].pauseTime.isNotEmpty && myTask[widget.selectedIndex].pauseTime != '-' ? myTask[widget.selectedIndex].pauseTime : 'No pause'),
                          _buildInfoRow('Pause Reason', myTask[widget.selectedIndex].pauseReason.isNotEmpty && myTask[widget.selectedIndex].pauseReason != '-' ? myTask[widget.selectedIndex].pauseReason : 'No pause'),
                          _buildInfoRow('Completed Time', myTask[widget.selectedIndex].timeEnd.isNotEmpty ? myTask[widget.selectedIndex].timeEnd : '---'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Hour Meters
                    Row(
                      children: [
                        Expanded(
                          child: _buildModernCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Hour Meter 1',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: Text(
                                    myTask[widget.selectedIndex].hourMeter1.isEmpty || myTask[widget.selectedIndex].hourMeter1 == 'null' ? '0' : myTask[widget.selectedIndex].hourMeter1,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
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
                                Row(
                                  children: [
                                    const Text(
                                      'Hour Meter 2',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: Text(
                                    myTask[widget.selectedIndex].hourMeter2.isEmpty || myTask[widget.selectedIndex].hourMeter2 == 'null' ? '0' : myTask[widget.selectedIndex].hourMeter2,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
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
                          Row(
                            children: [
                              const Text(
                                'Service Checklist',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          myTask[widget.selectedIndex].serviceChecklist.isEmpty
                              ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  'No service checklist items',
                                  style: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                              : Column(
                            children: myTask[widget.selectedIndex].serviceChecklist.map((item) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFF10B981).withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF10B981),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        item['name'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF1E293B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Photos
                    // _buildModernCard(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           const Text(
                    //             'Photos',
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.w700,
                    //               fontSize: 17,
                    //               color: Color(0xFF1E293B),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       const SizedBox(height: 16),
                    //       myTask[widget.selectedIndex].imagePath.isEmpty
                    //           ? Container(
                    //         width: double.infinity,
                    //         padding: const EdgeInsets.all(20),
                    //         decoration: BoxDecoration(
                    //           color: const Color(0xFFF8FAFC),
                    //           borderRadius: BorderRadius.circular(12),
                    //           border: Border.all(color: const Color(0xFFE2E8F0)),
                    //         ),
                    //         child: const Column(
                    //           children: [
                    //             Text(
                    //               'No photos uploaded',
                    //               style: TextStyle(
                    //                 color: Color(0xFF64748B),
                    //                 fontSize: 14,
                    //               ),
                    //               textAlign: TextAlign.center,
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //           : Wrap(
                    //         spacing: 12,
                    //         runSpacing: 12,
                    //         children: List.generate(myTask[widget.selectedIndex].imagePath.length, (index) {
                    //           return Container(
                    //             width: 100,
                    //             height: 100,
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(16),
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   color: Colors.black.withOpacity(0.1),
                    //                   blurRadius: 8,
                    //                   offset: const Offset(0, 2),
                    //                 ),
                    //               ],
                    //             ),
                    //             child: ClipRRect(
                    //               borderRadius: BorderRadius.circular(16),
                    //               child: Image.file(
                    //                 File(myTask[widget.selectedIndex].imagePath[index]),
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //           );
                    //         }),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // Photos
                    _buildModernCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Photos',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          myTask[widget.selectedIndex].imagePath.isEmpty
                              ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: const Column(
                              children: [
                                // Icon(
                                //   Icons.image_not_supported_outlined,
                                //   size: 40,
                                //   color: Color(0xFF64748B),
                                // ),
                                // SizedBox(height: 8),
                                Text(
                                  'No photos uploaded',
                                  style: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                              : Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: List.generate(
                              myTask[widget.selectedIndex].imagePath.length,
                                  (index) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.file(
                                      File(myTask[widget.selectedIndex].imagePath[index]),
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Icon(
                                            Icons.broken_image,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
                                        );
                                      },
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

                    // Breakdown Notes (BD-specific)
                    _buildModernCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Breakdown Notes',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          myTask[widget.selectedIndex].breakdownItems.isEmpty
                              ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  'No breakdown notes',
                                  style: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: myTask[widget.selectedIndex].breakdownItems.map((note) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFFFCD34D)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Item: ${note['item'] ?? 'Unknown'}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color(0xFF92400E),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF59E0B),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            'Qty: ${note['quantity'] ?? '0'}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (note['notes']?.isNotEmpty ?? false) ...[
                                      const SizedBox(height: 8),
                                      Text(
                                        note['notes']!,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF78350F),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Breakdown Cause By (BD-specific)
                    _buildModernCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Breakdown Caused By',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Text(
                              myTask[widget.selectedIndex].breakdownCausedBy.isEmpty ? 'Not provided' : myTask[widget.selectedIndex].breakdownCausedBy,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Consumed Spare Parts
                    _buildModernCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Consumed Spare Parts',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          myTask[widget.selectedIndex].spareParts.isEmpty
                              ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  'No consumed spare parts',
                                  style: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                              : Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                // Header
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF8B5CF6).withOpacity(0.1),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'Part Name',
                                          style: TextStyle(
                                            color: Color(0xFF1E293B),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Quantity',
                                          style: TextStyle(
                                            color: Color(0xFF1E293B),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Rows
                                ...myTask[widget.selectedIndex].spareParts.asMap().entries.map((entry) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                                    decoration: BoxDecoration(
                                      color: entry.key.isEven ? const Color(0xFFFAFAFA) : Colors.white,
                                      border: Border(
                                        top: BorderSide(color: Colors.grey.shade200),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            entry.value['item_name'] ?? 'Unknown Part',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF1E293B),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            entry.value['quantity'] ?? '0',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1E293B),
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Technician Notes
                    _buildModernCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Technician Notes',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Text(
                              myTask[widget.selectedIndex].technicianNotes.isEmpty ? 'Not provided' : myTask[widget.selectedIndex].technicianNotes,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF475569),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Customer Acknowledgment
                    _buildModernCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Customer Acknowledgment',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildCustomerField('Customer Name', myTask[widget.selectedIndex].customerName ?? ''),
                          const SizedBox(height: 12),
                          _buildCustomerField('Contact No.', myTask[widget.selectedIndex].customerContact ?? ''),
                        ],
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

  Widget _buildModernCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF7F8C8D),
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
                fontSize: 13,
              ),
              textAlign: TextAlign.right,
            ),
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
            child: Text(
              '$label:',
              style: const TextStyle(
                color: Color(0xFF7F8C8D),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF2C3E50),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Text(
            value.isEmpty ? 'Not provided' : value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
      ],
    );
  }
}