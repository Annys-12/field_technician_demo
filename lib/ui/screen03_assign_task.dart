import 'package:flutter/material.dart';

import '../app_data.dart';
import 'components/card_assigned_task.dart';

class AssignedTaskScreen extends StatefulWidget {

  Function saveTasks;
  Function refreshTask;

  AssignedTaskScreen({
    super.key,
    required this.saveTasks,
    required this.refreshTask
  });

  @override
  State<AssignedTaskScreen> createState() => _AssignedTaskScreenState();
}

class _AssignedTaskScreenState extends State<AssignedTaskScreen> {
  // Dummy data for assigned tasks
  // List<Map<String, String>> dummyTasks = [
  //   {
  //     'subtaskNumber': 'SWO-2024-001',
  //     'taskType': 'BD',
  //     'equipmentNo': 'EQ-12345',
  //     'assignedDate': '2025-12-17',
  //     'dept': 'EE',
  //   },
  //   {
  //     'subtaskNumber': 'SWO-2024-002',
  //     'taskType': 'PM',
  //     'equipmentNo': 'EQ-67890',
  //     'assignedDate': '2025-12-16',
  //     'dept': 'ME',
  //   },
  //   {
  //     'subtaskNumber': 'SWO-2024-003',
  //     'taskType': 'BD',
  //     'equipmentNo': 'EQ-11111',
  //     'assignedDate': '2025-12-15',
  //     'dept': 'EE',
  //   },
  //   {
  //     'subtaskNumber': 'SWO-2024-004',
  //     'taskType': 'PM',
  //     'equipmentNo': 'EQ-22222',
  //     'assignedDate': '2025-12-14',
  //     'dept': 'ME',
  //   },
  //   {
  //     'subtaskNumber': 'SWO-2024-005',
  //     'taskType': 'BD',
  //     'equipmentNo': 'EQ-33333',
  //     'assignedDate': '2025-12-13',
  //     'dept': 'EE',
  //   },
  // ];

  @override
  void initState() {
    print("ListSize: ${myTask.length}");
    super.initState();
  }

  refreshList(){
    setState(() {
      myTask.length;
    });
  }

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
                              widget.refreshTask();
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Assigned Task",
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
                    itemCount: myTask.length,
                    itemBuilder: (context, index) {
                      if(myTask[index].status == "New Task"){
                        return CardAssignedTask(
                          swoNumber: myTask[index].swoNumber ?? '',
                          taskType: myTask[index].taskType ?? '',
                          equipmentNo: myTask[index].equipmentId ?? '',
                          assignedDate: myTask[index].assignedDate ?? '',
                          dept: myTask[index].dept ?? '',
                          selectedIndex: index,
                          saveTasks: widget.saveTasks,
                          refreshList: refreshList,
                        );
                      }else{
                        return SizedBox();
                      }

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