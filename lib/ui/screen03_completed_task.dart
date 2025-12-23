import 'package:flutter/material.dart';

import 'components/card_completed.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  // Dummy data for completed tasks
  List<Map<String, String>> dummyCompletedTasks = [
    {
      'subtaskNumber': 'SWO-2024-101',
      'taskType': 'BD',
      'equipmentNo': 'EQ-54321',
      'dept': 'EE',
      'startDate': '2024-11-01',
      'endDate': '2024-11-05',
      'assignedDate': '2024-11-01',
    },
    {
      'subtaskNumber': 'SWO-2024-102',
      'taskType': 'PM',
      'equipmentNo': 'EQ-98765',
      'dept': 'ME',
      'startDate': '2024-11-10',
      'endDate': '2024-11-15',
      'assignedDate': '2024-11-10',
    },
    {
      'subtaskNumber': 'SWO-2024-103',
      'taskType': 'BD',
      'equipmentNo': 'EQ-44444',
      'dept': 'EE',
      'startDate': '2024-11-20',
      'endDate': '2024-11-22',
      'assignedDate': '2024-11-20',
    },
    {
      'subtaskNumber': 'SWO-2024-104',
      'taskType': 'PM',
      'equipmentNo': 'EQ-55555',
      'dept': 'ME',
      'startDate': '2024-12-01',
      'endDate': '2024-12-05',
      'assignedDate': '2024-12-01',
    },
    {
      'subtaskNumber': 'SWO-2024-105',
      'taskType': 'BD',
      'equipmentNo': 'EQ-66666',
      'dept': 'EE',
      'startDate': '2024-12-10',
      'endDate': '2024-12-12',
      'assignedDate': '2024-12-10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0A57A3),
                      Color(0xFF0097A7),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Complete Task",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 40),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            onChanged: (val) {
                              // Search functionality placeholder
                            },
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                              suffixIcon: Icon(Icons.search),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                color: Color(0xffececec),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: dummyCompletedTasks.length,
                    itemBuilder: (context, index) {
                      return CardCompletedTask(
                        subtaskNumber: dummyCompletedTasks[index]['subtaskNumber'] ?? '',
                        equipmentNo: dummyCompletedTasks[index]['equipmentNo'] ?? '',
                        taskType: dummyCompletedTasks[index]['taskType'] ?? '',
                        dept: dummyCompletedTasks[index]['dept'] ?? '',
                        startDate: dummyCompletedTasks[index]['startDate'] ?? '',
                        endDate: dummyCompletedTasks[index]['endDate'] ?? '',
                        assignedDate: dummyCompletedTasks[index]['assignedDate'] ?? '',
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}