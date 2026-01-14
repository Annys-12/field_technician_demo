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
  final TextEditingController _searchController = TextEditingController();
  List filteredTasks = [];

  @override
  void initState() {
    print("ListSize: ${myTask.length}");
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
                      if(filteredTasks[index].status == "New Task"){
                        return CardAssignedTask(
                          swoNumber: filteredTasks[index].swoNumber ?? '',
                          taskType: filteredTasks[index].taskType ?? '',
                          equipmentNo: filteredTasks[index].equipmentId ?? '',
                          assignedDate: filteredTasks[index].assignedDate ?? '',
                          dept: filteredTasks[index].dept ?? '',
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