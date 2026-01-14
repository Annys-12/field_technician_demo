import 'package:flutter/material.dart';

import '../app_data.dart';
import 'components/card_in_progress.dart';

class PendingTaskScreen extends StatefulWidget {

  Function saveTasks;
  Function refreshTask;


  PendingTaskScreen({
    super.key,
    required this.saveTasks,
    required this.refreshTask
  });

  @override
  State<PendingTaskScreen> createState() => _PendingTaskScreenState();
}

class _PendingTaskScreenState extends State<PendingTaskScreen> {
  final TextEditingController _searchController = TextEditingController();
  List filteredTasks = [];

  // Dummy data for in-progress tasks
  List<Map<String, String>> dummyInProgressTasks = [
    {
      'swoNumber': 'SWO-ES-00123',
      'taskType': 'BD',
      'dept': 'EE',
      'equipmentId': 'PG02075',
      'date': '12/08/2024',
      'equipmentNo': 'PG00275',
      'timeStart': '02.02.2024 / 8.00 am',
      'duration': '1 hr 30 min',
      'pauseTime': '30 min',
      'pauseReason': 'Simply',
    },
    {
      'swoNumber': 'SWO-ME-00456',
      'taskType': 'PM',
      'dept': 'ME',
      'equipmentId': 'PG02076',
      'date': '12/09/2024',
      'equipmentNo': 'PG00276',
      'timeStart': '03.02.2024 / 9.00 am',
      'duration': '2 hr 15 min',
      'pauseTime': '45 min',
      'pauseReason': 'Lunch Break',
    },
    {
      'swoNumber': 'SWO-EE-00789',
      'taskType': 'BD',
      'dept': 'EE',
      'equipmentId': 'PG02077',
      'date': '12/10/2024',
      'equipmentNo': 'PG00277',
      'timeStart': '04.02.2024 / 10.00 am',
      'duration': '45 min',
      'pauseTime': '15 min',
      'pauseReason': 'Material Wait',
    },
    {
      'swoNumber': 'SWO-ME-01012',
      'taskType': 'PM',
      'dept': 'ME',
      'equipmentId': 'PG02078',
      'date': '12/11/2024',
      'equipmentNo': 'PG00278',
      'timeStart': '05.02.2024 / 11.00 am',
      'duration': '3 hr 00 min',
      'pauseTime': '60 min',
      'pauseReason': 'Equipment Cool Down',
    },
    {
      'swoNumber': 'SWO-EE-01345',
      'taskType': 'BD',
      'dept': 'EE',
      'equipmentId': 'PG02079',
      'date': '12/12/2024',
      'equipmentNo': 'PG00279',
      'timeStart': '06.02.2024 / 1.00 pm',
      'duration': '1 hr 00 min',
      'pauseTime': '20 min',
      'pauseReason': 'Safety Check',
    },
  ];

  @override
  void initState() {
    filteredTasks = myTask;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTasks(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredTasks = myTask;
      } else {
        filteredTasks = myTask.where((task) {
          final swoNumber = task.swoNumber?.toLowerCase() ?? '';
          final taskType = task.taskType?.toLowerCase() ?? '';
          final equipmentId = task.equipmentId?.toLowerCase() ?? '';
          final dept = task.dept?.toLowerCase() ?? '';
          final searchLower = query.toLowerCase();

          return swoNumber.contains(searchLower) ||
              taskType.contains(searchLower) ||
              equipmentId.contains(searchLower) ||
              dept.contains(searchLower);
        }).toList();
      }
    });
  }

  refreshList(){
    setState(() {
      myTask.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10),
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
                                    "Pending Task",
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
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
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
                                controller: _searchController,
                                onChanged: _filterTasks,
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
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      if(filteredTasks[index].status == "In Progress" || filteredTasks[index].status == "Paused"){
                        return CardInProgress(
                          swoNumber: filteredTasks[index].swoNumber ?? '',
                          taskType: filteredTasks[index].taskType ?? '',
                          dept: filteredTasks[index].dept ?? '',
                          equipmentId: filteredTasks[index].equipmentId ?? '',
                          date: filteredTasks[index].assignedDate ?? '',
                          equipmentNo: filteredTasks[index].equipmentId ?? '',
                          timeStart: filteredTasks[index].timeStart ?? '',
                          duration: filteredTasks[index].duration ?? '',
                          pauseTime: filteredTasks[index].pauseTime ?? '',
                          pauseReason: filteredTasks[index].pauseReason ?? '',
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