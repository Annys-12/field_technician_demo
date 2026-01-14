// import 'dart:convert';
//
// import 'package:field_technician_demo/ui/data_model/task_model.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../ui/screen01_login.dart';
// import '../ui/screen02_dashboard.dart';
// import '../ui/screen03_outbox_service.dart';
// import '../ui/screen03_pending_task.dart';
// import 'app_data.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Start auto-sync service
//   final outboxService = OutboxService();
//   outboxService.startAutoSync();
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Field Technician - Task Report Apps',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.light(
//             primary: const Color(0xFF01264A),
//             secondary: const Color(0xFF0031A5),
//             tertiary: const Color(0xFFE2F1FF),
//             outline: Colors.grey.shade400
//         ),
//         useMaterial3: true,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   void initState() {
//
//     getSavedTask();
//
//     super.initState();
//   }
//
//   getSavedTask() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString(taskKey);
//
//     if (jsonString != null){
//       final List decoded = jsonDecode(jsonString);
//       myTask = decoded.map((e) => TaskModel.fromJson(e as Map<String, dynamic>)).toList();
//     }else{
//       addDummyData();
//     }
//   }
//
//   addDummyData(){
//     myTask.add(TaskModel(
//         id: 'Task1',
//         swoNumber: 'SWO-ES-00123',
//         taskType: 'BD',
//         dept: 'EE',
//         equipmentId: 'PG02075',
//         assignedDate: '12/08/2025',
//         savedAt: DateTime.now(),
//         status: "New Task",
//         timeStart: '---',
//         timeEnd: '---',
//         duration: '0',
//         pauseTime: '-',
//         pauseReason: '-',
//         imagePath: [],
//         spareParts: [
//           {
//             'item_name': 'Brake Pad Set',
//             'item_code': 'BP-3456',
//             'quantity': '1',
//           },
//           {
//             'item_name': 'Hydraulic Hose',
//             'item_code': 'HH-7890',
//             'quantity': '5',
//           },
//         ],
//         serviceChecklist: [
//           { "name": "Engine Check", "completed": false },
//           { "name": "Oil Level Inspection", "completed": false },
//           { "name": "Hydraulic System", "completed": false },
//         ],
//         myCompanyInfo: CompanyInfo(
//             rentalCompany: "ABC Rental Sdn Bhd",
//             picName: "Ahmed Ali",
//             picContactNum: "+60156244825",
//             latitude: 3.074118505289,
//             longitude: 101.6251485159
//         ),
//         breakdownCausedBy: "",
//         breakdownItems: [],
//         technicianNotes: "",
//         hourMeter1: "0",
//         hourMeter2: "0",
//         customerName: "",
//         customerContact: ""
//     )
//     );
//
//     myTask.add(TaskModel(
//         id: 'Task2',
//         swoNumber: 'SWO-ES-00124',
//         taskType: 'PM',
//         dept: 'EE',
//         equipmentId: 'PG02076',
//         assignedDate: '22/08/2025',
//         savedAt: DateTime.now(),
//         status: "New Task",
//         timeStart: '---',
//         timeEnd: '---',
//         duration: '0',
//         pauseTime: '-',
//         pauseReason: '-',
//         imagePath: [],
//         spareParts: [
//           {
//             'item_name': 'Engine Belt',
//             'item_code': 'EB-2345',
//             'quantity': '3',
//           },
//           {
//             'item_name': 'Hydraulic Hose',
//             'item_code': 'HH-7890',
//             'quantity': '1',
//           },
//         ],
//         serviceChecklist: [
//           { "name": "Engine Check", "completed": false },
//           { "name": "Hydraulic System", "completed": false },
//           { "name": "Brake System", "completed": false }
//         ],
//         myCompanyInfo: CompanyInfo(
//             rentalCompany: "Cre8 IOT Sdn Bhd",
//             picName: "Naga",
//             picContactNum: "+6014436667",
//             latitude: 3.074118505289,
//             longitude: 101.6251485159
//         ),
//         breakdownCausedBy: "",
//         breakdownItems: [],
//         technicianNotes: "",
//         hourMeter1: "0",
//         hourMeter2: "0",
//         customerName: "",
//         customerContact: ""
//     )
//     );
//
//     myTask.add(TaskModel(
//         id: 'Task3',
//         swoNumber: 'SWO-ES-00125',
//         taskType: 'BD',
//         dept: 'ME',
//         equipmentId: 'EQ-22222',
//         assignedDate: '12/09/2025',
//         savedAt: DateTime.now(),
//         status: "New Task",
//         timeStart: '---',
//         timeEnd: '---',
//         duration: '0',
//         pauseTime: '-',
//         pauseReason: '-',
//         imagePath: [],
//         spareParts: [
//           {
//             'item_name': 'Engine Belt',
//             'item_code': 'EB-2345',
//             'quantity': '3',
//           },
//           {
//             'item_name': 'Coolant Fluid',
//             'item_code': 'CF-6789',
//             'quantity': '5',
//           },
//         ],
//         serviceChecklist: [
//           { "name": "Engine Check", "completed": false },
//           { "name": "Hydraulic System", "completed": false },
//           { "name": "Brake System", "completed": false }
//         ],
//         myCompanyInfo: CompanyInfo(
//             rentalCompany: "Cre8 IOT Sdn Bhd",
//             picName: "Naga",
//             picContactNum: "+6014436667",
//             latitude: 3.074118505289,
//             longitude: 101.6251485159
//         ),
//         breakdownCausedBy: "",
//         breakdownItems: [],
//         technicianNotes: "",
//         hourMeter1: "0",
//         hourMeter2: "0",
//         customerName: "",
//         customerContact: ""
//     )
//     );
//
//     myTask.add(TaskModel(
//         id: 'Task4',
//         swoNumber: 'SWO-ES-00126',
//         taskType: 'BD',
//         dept: 'EE',
//         equipmentId: 'PG02077',
//         assignedDate: '21/09/2025',
//         savedAt: DateTime.now(),
//         status: "New Task",
//         timeStart: '---',
//         timeEnd: '---',
//         duration: '0',
//         pauseTime: '-',
//         pauseReason: '-',
//         imagePath: [],
//         spareParts: [
//           {
//             'item_name': 'Hydraulic Hose',
//             'item_code': 'HH-7890',
//             'quantity': '5',
//           },
//           {
//             'item_name': 'Coolant Fluid',
//             'item_code': 'CF-6789',
//             'quantity': '4',
//           },
//         ],
//         serviceChecklist: [
//           { "name": "Oil Level Inspection", "completed": false },
//           { "name": "Brake System", "completed": false }
//         ],
//         myCompanyInfo: CompanyInfo(
//             rentalCompany: "ABC Rental Sdn Bhd",
//             picName: "Ahmed Ali",
//             picContactNum: "+60156244825",
//             latitude: 3.074118505289,
//             longitude: 101.6251485159
//         ),
//         breakdownCausedBy: "",
//         breakdownItems: [],
//         technicianNotes: "",
//         hourMeter1: "0",
//         hourMeter2: "0",
//         customerName: "",
//         customerContact: ""
//     )
//     );
//
//     myTask.add(TaskModel(
//         id: 'Task5',
//         swoNumber: 'SWO-ES-00126',
//         taskType: 'PM',
//         dept: 'EE',
//         equipmentId: 'PG02080',
//         assignedDate: '04/10/2025',
//         savedAt: DateTime.now(),
//         status: "New Task",
//         timeStart: '---',
//         timeEnd: '---',
//         duration: '0',
//         pauseTime: '-',
//         pauseReason: '-',
//         imagePath: [],
//         spareParts: [
//           {
//             'item_name': 'Engine Belt',
//             'item_code': 'EB-2345',
//             'quantity': '3',
//           },
//           {
//             'item_name': 'Hydraulic Hose',
//             'item_code': 'HH-7890',
//             'quantity': '1',
//           },
//         ],
//         serviceChecklist: [
//           { "name": "Engine Check", "completed": false },
//           { "name": "Oil Level Inspection", "completed": false },
//         ],
//         myCompanyInfo: CompanyInfo(
//             rentalCompany: "Cre8 IOT Sdn Bhd",
//             picName: "Naga",
//             picContactNum: "+6014436667",
//             latitude: 3.074118505289,
//             longitude: 101.6251485159
//         ),
//         breakdownCausedBy: "",
//         breakdownItems: [],
//         technicianNotes: "",
//         hourMeter1: "0",
//         hourMeter2: "0",
//         customerName: "",
//         customerContact: ""
//     )
//     );
//
//     myTask.add(TaskModel(
//         id: 'Task6',
//         swoNumber: 'SWO-ES-00127',
//         taskType: 'BD',
//         dept: 'ME',
//         equipmentId: 'EQ-22342',
//         assignedDate: '15/10/2025',
//         savedAt: DateTime.now(),
//         status: "New Task",
//         timeStart: '---',
//         timeEnd: '---',
//         duration: '0',
//         pauseTime: '-',
//         pauseReason: '-',
//         imagePath: [],
//         spareParts: [
//           {
//             'item_name': 'Brake Pad Set',
//             'item_code': 'BP-3456',
//             'quantity': '2',
//           },
//           {
//             'item_name': 'Coolant Fluid',
//             'item_code': 'CF-6789',
//             'quantity': '5',
//           },
//         ],
//         serviceChecklist: [
//           { "name": "Engine Check", "completed": false },
//           { "name": "Oil Level Inspection", "completed": false },
//           { "name": "Hydraulic System", "completed": false },
//         ],
//         myCompanyInfo: CompanyInfo(
//             rentalCompany: "Cre8 IOT Sdn Bhd",
//             picName: "Naga",
//             picContactNum: "+6014436667",
//             latitude: 3.074118505289,
//             longitude: 101.6251485159
//         ),
//         breakdownCausedBy: "",
//         breakdownItems: [],
//         technicianNotes: "",
//         hourMeter1: "0",
//         hourMeter2: "0",
//         customerName: "",
//         customerContact: ""
//     )
//     );
//
//     myTask.add(TaskModel(
//         id: 'Task7',
//         swoNumber: 'SWO-ES-00128',
//         taskType: 'BD',
//         dept: 'EE',
//         equipmentId: 'PG02085',
//         assignedDate: '28/10/2025',
//         savedAt: DateTime.now(),
//         status: "New Task",
//         timeStart: '---',
//         timeEnd: '---',
//         duration: '0',
//         pauseTime: '-',
//         pauseReason: '-',
//         imagePath: [],
//         spareParts: [
//           {
//             'item_name': 'Hydraulic Hose',
//             'item_code': 'HH-7890',
//             'quantity': '5',
//           },
//           {
//             'item_name': 'Coolant Fluid',
//             'item_code': 'CF-6789',
//             'quantity': '4',
//           },
//         ],
//         serviceChecklist: [
//           { "name": "Engine Check", "completed": false },
//           { "name": "Brake System", "completed": false }
//         ],
//         myCompanyInfo: CompanyInfo(
//             rentalCompany: "ABC Rental Sdn Bhd",
//             picName: "Ahmed Ali",
//             picContactNum: "+60156244825",
//             latitude: 3.074118505289,
//             longitude: 101.6251485159
//         ),
//         breakdownCausedBy: "",
//         breakdownItems: [],
//         technicianNotes: "",
//         hourMeter1: "0",
//         hourMeter2: "0",
//         customerName: "",
//         customerContact: ""
//     )
//     );
//
//     myTask.add(TaskModel(
//         id: 'Task8',
//         swoNumber: 'SWO-ES-00129',
//         taskType: 'PM',
//         dept: 'EE',
//         equipmentId: 'PG02086',
//         assignedDate: '01/11/2025',
//         savedAt: DateTime.now(),
//         status: "New Task",
//         timeStart: '---',
//         timeEnd: '---',
//         duration: '0',
//         pauseTime: '-',
//         pauseReason: '-',
//         imagePath: [],
//         spareParts: [
//           {
//             'item_name': 'Engine Belt',
//             'item_code': 'EB-2345',
//             'quantity': '3',
//           },
//           {
//             'item_name': 'Hydraulic Hose',
//             'item_code': 'HH-7890',
//             'quantity': '1',
//           },
//         ],
//         serviceChecklist: [
//           { "name": "Engine Check", "completed": false },
//           { "name": "Oil Level Inspection", "completed": false },
//           { "name": "Brake System", "completed": false }
//         ],
//         myCompanyInfo: CompanyInfo(
//             rentalCompany: "Cre8 IOT Sdn Bhd",
//             picName: "Naga",
//             picContactNum: "+6014436667",
//             latitude: 3.074118505289,
//             longitude: 101.6251485159
//         ),
//         breakdownCausedBy: "",
//         breakdownItems: [],
//         technicianNotes: "",
//         hourMeter1: "0",
//         hourMeter2: "0",
//         customerName: "",
//         customerContact: ""
//     )
//     );
//
//     myTask.add(TaskModel(
//         id: 'Task9',
//         swoNumber: 'SWO-ES-00130',
//         taskType: 'BD',
//         dept: 'ME',
//         equipmentId: 'EQ-22362',
//         assignedDate: '11/11/2025',
//         savedAt: DateTime.now(),
//         status: "New Task",
//         timeStart: '---',
//         timeEnd: '---',
//         duration: '0',
//         pauseTime: '-',
//         pauseReason: '-',
//         imagePath: [],
//         spareParts: [
//           {
//             'item_name': 'Brake Pad Set',
//             'item_code': 'BP-3456',
//             'quantity': '2',
//           },
//           {
//             'item_name': 'Hydraulic Hose',
//             'item_code': 'HH-7890',
//             'quantity': '1',
//           },
//         ],
//         serviceChecklist: [
//           { "name": "Hydraulic System", "completed": false },
//           { "name": "Brake System", "completed": false }
//         ],
//         myCompanyInfo: CompanyInfo(
//             rentalCompany: "Cre8 IOT Sdn Bhd",
//             picName: "Naga",
//             picContactNum: "+6014436667",
//             latitude: 3.074118505289,
//             longitude: 101.6251485159
//         ),
//         breakdownCausedBy: "",
//         breakdownItems: [],
//         technicianNotes: "",
//         hourMeter1: "0",
//         hourMeter2: "0",
//         customerName: "",
//         customerContact: ""
//     )
//     );
//
//     myTask.add(TaskModel(
//         id: 'Task10',
//         swoNumber: 'SWO-ES-00131',
//         taskType: 'BD',
//         dept: 'EE',
//         equipmentId: 'PG02090',
//         assignedDate: '21/11/2025',
//         savedAt: DateTime.now(),
//         status: "New Task",
//         timeStart: '---',
//         timeEnd: '---',
//         duration: '0',
//         pauseTime: '-',
//         pauseReason: '-',
//         imagePath: [],
//         spareParts: [
//           {
//             'item_name': 'Brake Pad Set',
//             'item_code': 'BP-3456',
//             'quantity': '1',
//           },
//           {
//             'item_name': 'Hydraulic Hose',
//             'item_code': 'HH-7890',
//             'quantity': '5',
//           },
//         ],
//         serviceChecklist: [
//           { "name": "Engine Check", "completed": false },
//           { "name": "Brake System", "completed": false }
//         ],
//         myCompanyInfo: CompanyInfo(
//             rentalCompany: "ABC Rental Sdn Bhd",
//             picName: "Ahmed Ali",
//             picContactNum: "+60156244825",
//             latitude: 3.074118505289,
//             longitude: 101.6251485159
//         ),
//         breakdownCausedBy: "",
//         breakdownItems: [],
//         technicianNotes: "",
//         hourMeter1: "0",
//         hourMeter2: "0",
//         customerName: "",
//         customerContact: ""
//     )
//     );
//
//     saveTasks(myTask);
//   }
//
//
//   Future<void> saveTasks(List<TaskModel> tasks) async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = jsonEncode(
//       tasks.map((e) => e.toJson()).toList(),
//     );
//     await prefs.setString(taskKey, jsonString);
//
//     setState(() {
//       getSavedTask();
//       refreshTask();
//     });
//   }
//
//   refreshTask(){
//     intPendingTask = 0;
//     intCompleteTask = 0;
//     intOutboxTask = 0;
//     intAssignedTask = 0;
//
//     for(var i in myTask){
//       switch(i.status){
//         case "In Progress":
//           intPendingTask += 1;
//           break;
//         case "Paused":
//           intPendingTask += 1;
//           break;
//         case "Completed":
//           intCompleteTask += 1;
//           break;
//         default:
//           intAssignedTask += 1;
//           break;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LoginScreen(
//       saveTasks: saveTasks,
//     );
//     //return DashboardScreen();
//     //return PendingTaskScreen();
//
//   }
// }

import 'dart:convert';

import 'package:field_technician_demo/ui/data_model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ui/screen01_login.dart';
import '../ui/screen02_dashboard.dart';
import '../ui/screen03_outbox_service.dart';
import '../ui/screen03_pending_task.dart';
import 'app_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Start auto-sync service
  final outboxService = OutboxService();
  outboxService.startAutoSync();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Field Technician - Task Report Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
            primary: const Color(0xFF01264A),
            secondary: const Color(0xFF0031A5),
            tertiary: const Color(0xFFE2F1FF),
            outline: Colors.grey.shade400
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    getSavedTask();
    getSavedOutboxTask();
    super.initState();
  }

  getSavedTask() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(taskKey);

    if (jsonString != null){
      final List decoded = jsonDecode(jsonString);
      myTask = decoded.map((e) => TaskModel.fromJson(e as Map<String, dynamic>)).toList();
    }else{
      addDummyData();
    }
  }

  getSavedOutboxTask() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(outboxTaskKey);

    if (jsonString != null){
      final List decoded = jsonDecode(jsonString);
      myOutboxTask = decoded.map((e) => TaskModel.fromJson(e as Map<String, dynamic>)).toList();
    }else{
      addDummyOutboxData();
    }
  }

  addDummyData(){
    myTask.add(TaskModel(
        id: 'Task1',
        swoNumber: 'SWO-ES-00123',
        taskType: 'BD',
        dept: 'EE',
        equipmentId: 'PG02075',
        assignedDate: '12/08/2025',
        savedAt: DateTime.now(),
        status: "New Task",
        timeStart: '---',
        timeEnd: '---',
        duration: '0',
        pauseTime: '-',
        pauseReason: '-',
        startDate: '',
        endDate: '',
        imagePath: [],
        spareParts: [
          {
            'item_name': 'Brake Pad Set',
            'item_code': 'BP-3456',
            'quantity': '1',
          },
          {
            'item_name': 'Hydraulic Hose',
            'item_code': 'HH-7890',
            'quantity': '5',
          },
        ],
        serviceChecklist: [
          { "name": "Engine Check", "completed": false },
          { "name": "Oil Level Inspection", "completed": false },
          { "name": "Hydraulic System", "completed": false },
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "ABC Rental Sdn Bhd",
            picName: "Ahmed Ali",
            picContactNum: "+60156244825",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "",
        breakdownItems: [],
        technicianNotes: "",
        hourMeter1: "0",
        hourMeter2: "0",
        customerName: "",
        customerContact: ""
    ));

    myTask.add(TaskModel(
        id: 'Task2',
        swoNumber: 'SWO-ES-00124',
        taskType: 'PM',
        dept: 'EE',
        equipmentId: 'PG02076',
        assignedDate: '22/08/2025',
        savedAt: DateTime.now(),
        status: "New Task",
        timeStart: '---',
        timeEnd: '---',
        duration: '0',
        pauseTime: '-',
        pauseReason: '-',
        startDate: '',
        endDate: '',
        imagePath: [],
        spareParts: [
          {
            'item_name': 'Engine Belt',
            'item_code': 'EB-2345',
            'quantity': '3',
          },
          {
            'item_name': 'Hydraulic Hose',
            'item_code': 'HH-7890',
            'quantity': '1',
          },
        ],
        serviceChecklist: [
          { "name": "Engine Check", "completed": false },
          { "name": "Hydraulic System", "completed": false },
          { "name": "Brake System", "completed": false }
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "Cre8 IOT Sdn Bhd",
            picName: "Naga",
            picContactNum: "+6014436667",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "",
        breakdownItems: [],
        technicianNotes: "",
        hourMeter1: "0",
        hourMeter2: "0",
        customerName: "",
        customerContact: ""
    ));

    myTask.add(TaskModel(
        id: 'Task3',
        swoNumber: 'SWO-ES-00125',
        taskType: 'BD',
        dept: 'ME',
        equipmentId: 'EQ-22222',
        assignedDate: '12/09/2025',
        savedAt: DateTime.now(),
        status: "New Task",
        timeStart: '---',
        timeEnd: '---',
        duration: '0',
        pauseTime: '-',
        pauseReason: '-',
        startDate: '',
        endDate: '',
        imagePath: [],
        spareParts: [
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
        serviceChecklist: [
          { "name": "Engine Check", "completed": false },
          { "name": "Hydraulic System", "completed": false },
          { "name": "Brake System", "completed": false }
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "Cre8 IOT Sdn Bhd",
            picName: "Naga",
            picContactNum: "+6014436667",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "",
        breakdownItems: [],
        technicianNotes: "",
        hourMeter1: "0",
        hourMeter2: "0",
        customerName: "",
        customerContact: ""
    ));

    myTask.add(TaskModel(
        id: 'Task4',
        swoNumber: 'SWO-ES-00126',
        taskType: 'BD',
        dept: 'EE',
        equipmentId: 'PG02077',
        assignedDate: '21/09/2025',
        savedAt: DateTime.now(),
        status: "New Task",
        timeStart: '---',
        timeEnd: '---',
        duration: '0',
        pauseTime: '-',
        pauseReason: '-',
        startDate: '',
        endDate: '',
        imagePath: [],
        spareParts: [
          {
            'item_name': 'Hydraulic Hose',
            'item_code': 'HH-7890',
            'quantity': '5',
          },
          {
            'item_name': 'Coolant Fluid',
            'item_code': 'CF-6789',
            'quantity': '4',
          },
        ],
        serviceChecklist: [
          { "name": "Oil Level Inspection", "completed": false },
          { "name": "Brake System", "completed": false }
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "ABC Rental Sdn Bhd",
            picName: "Ahmed Ali",
            picContactNum: "+60156244825",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "",
        breakdownItems: [],
        technicianNotes: "",
        hourMeter1: "0",
        hourMeter2: "0",
        customerName: "",
        customerContact: ""
    ));

    myTask.add(TaskModel(
        id: 'Task5',
        swoNumber: 'SWO-ES-00127',
        taskType: 'PM',
        dept: 'EE',
        equipmentId: 'PG02080',
        assignedDate: '04/10/2025',
        savedAt: DateTime.now(),
        status: "New Task",
        timeStart: '---',
        timeEnd: '---',
        duration: '0',
        pauseTime: '-',
        pauseReason: '-',
        startDate: '',
        endDate: '',
        imagePath: [],
        spareParts: [
          {
            'item_name': 'Engine Belt',
            'item_code': 'EB-2345',
            'quantity': '3',
          },
          {
            'item_name': 'Hydraulic Hose',
            'item_code': 'HH-7890',
            'quantity': '1',
          },
        ],
        serviceChecklist: [
          { "name": "Engine Check", "completed": false },
          { "name": "Oil Level Inspection", "completed": false },
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "Cre8 IOT Sdn Bhd",
            picName: "Naga",
            picContactNum: "+6014436667",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "",
        breakdownItems: [],
        technicianNotes: "",
        hourMeter1: "0",
        hourMeter2: "0",
        customerName: "",
        customerContact: ""
    ));

    myTask.add(TaskModel(
        id: 'Task6',
        swoNumber: 'SWO-ES-00128',
        taskType: 'BD',
        dept: 'ME',
        equipmentId: 'EQ-22342',
        assignedDate: '15/10/2025',
        savedAt: DateTime.now(),
        status: "New Task",
        timeStart: '---',
        timeEnd: '---',
        duration: '0',
        pauseTime: '-',
        pauseReason: '-',
        startDate: '',
        endDate: '',
        imagePath: [],
        spareParts: [
          {
            'item_name': 'Brake Pad Set',
            'item_code': 'BP-3456',
            'quantity': '2',
          },
          {
            'item_name': 'Coolant Fluid',
            'item_code': 'CF-6789',
            'quantity': '5',
          },
        ],
        serviceChecklist: [
          { "name": "Engine Check", "completed": false },
          { "name": "Oil Level Inspection", "completed": false },
          { "name": "Hydraulic System", "completed": false },
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "Cre8 IOT Sdn Bhd",
            picName: "Naga",
            picContactNum: "+6014436667",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "",
        breakdownItems: [],
        technicianNotes: "",
        hourMeter1: "0",
        hourMeter2: "0",
        customerName: "",
        customerContact: ""
    ));

    myTask.add(TaskModel(
        id: 'Task7',
        swoNumber: 'SWO-ES-00129',
        taskType: 'BD',
        dept: 'EE',
        equipmentId: 'PG02085',
        assignedDate: '28/10/2025',
        savedAt: DateTime.now(),
        status: "New Task",
        timeStart: '---',
        timeEnd: '---',
        duration: '0',
        pauseTime: '-',
        pauseReason: '-',
        startDate: '',
        endDate: '',
        imagePath: [],
        spareParts: [
          {
            'item_name': 'Hydraulic Hose',
            'item_code': 'HH-7890',
            'quantity': '5',
          },
          {
            'item_name': 'Coolant Fluid',
            'item_code': 'CF-6789',
            'quantity': '4',
          },
        ],
        serviceChecklist: [
          { "name": "Engine Check", "completed": false },
          { "name": "Brake System", "completed": false }
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "ABC Rental Sdn Bhd",
            picName: "Ahmed Ali",
            picContactNum: "+60156244825",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "",
        breakdownItems: [],
        technicianNotes: "",
        hourMeter1: "0",
        hourMeter2: "0",
        customerName: "",
        customerContact: ""
    ));

    myTask.add(TaskModel(
        id: 'Task8',
        swoNumber: 'SWO-ES-00130',
        taskType: 'PM',
        dept: 'EE',
        equipmentId: 'PG02086',
        assignedDate: '01/11/2025',
        savedAt: DateTime.now(),
        status: "New Task",
        timeStart: '---',
        timeEnd: '---',
        duration: '0',
        pauseTime: '-',
        pauseReason: '-',
        startDate: '',
        endDate: '',
        imagePath: [],
        spareParts: [
          {
            'item_name': 'Engine Belt',
            'item_code': 'EB-2345',
            'quantity': '3',
          },
          {
            'item_name': 'Hydraulic Hose',
            'item_code': 'HH-7890',
            'quantity': '1',
          },
        ],
        serviceChecklist: [
          { "name": "Engine Check", "completed": false },
          { "name": "Oil Level Inspection", "completed": false },
          { "name": "Brake System", "completed": false }
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "Cre8 IOT Sdn Bhd",
            picName: "Naga",
            picContactNum: "+6014436667",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "",
        breakdownItems: [],
        technicianNotes: "",
        hourMeter1: "0",
        hourMeter2: "0",
        customerName: "",
        customerContact: ""
    ));

    myTask.add(TaskModel(
        id: 'Task9',
        swoNumber: 'SWO-ES-00131',
        taskType: 'BD',
        dept: 'ME',
        equipmentId: 'EQ-22362',
        assignedDate: '11/11/2025',
        savedAt: DateTime.now(),
        status: "New Task",
        timeStart: '---',
        timeEnd: '---',
        duration: '0',
        pauseTime: '-',
        pauseReason: '-',
        startDate: '',
        endDate: '',
        imagePath: [],
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
        ],
        serviceChecklist: [
          { "name": "Hydraulic System", "completed": false },
          { "name": "Brake System", "completed": false }
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "Cre8 IOT Sdn Bhd",
            picName: "Naga",
            picContactNum: "+6014436667",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "",
        breakdownItems: [],
        technicianNotes: "",
        hourMeter1: "0",
        hourMeter2: "0",
        customerName: "",
        customerContact: ""
    ));

    myTask.add(TaskModel(
        id: 'Task10',
        swoNumber: 'SWO-ES-00132',
        taskType: 'BD',
        dept: 'EE',
        equipmentId: 'PG02090',
        assignedDate: '21/11/2025',
        savedAt: DateTime.now(),
        status: "New Task",
        timeStart: '---',
        timeEnd: '---',
        duration: '0',
        pauseTime: '-',
        pauseReason: '-',
        startDate: '',
        endDate: '',
        imagePath: [],
        spareParts: [
          {
            'item_name': 'Brake Pad Set',
            'item_code': 'BP-3456',
            'quantity': '1',
          },
          {
            'item_name': 'Hydraulic Hose',
            'item_code': 'HH-7890',
            'quantity': '5',
          },
        ],
        serviceChecklist: [
          { "name": "Engine Check", "completed": false },
          { "name": "Brake System", "completed": false }
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "ABC Rental Sdn Bhd",
            picName: "Ahmed Ali",
            picContactNum: "+60156244825",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "",
        breakdownItems: [],
        technicianNotes: "",
        hourMeter1: "0",
        hourMeter2: "0",
        customerName: "",
        customerContact: ""
    ));

    saveTasks(myTask);
  }

  addDummyOutboxData(){
    // 1. PENDING - Recent breakdown task
    myOutboxTask.add(TaskModel(
        id: 'OutboxTask1',
        swoNumber: 'SWO-2024-201',
        taskType: 'BD',
        dept: 'EE',
        equipmentId: 'PG02088',
        assignedDate: '17/12/2025',
        savedAt: DateTime.now(),
        status: "pending_upload",
        timeStart: '17-12-2025 08:30:00',
        timeEnd: '27-12-2025 11:30:00',
        duration: '7',
        pauseTime: '0',
        pauseReason: '-',
        startDate: '17-12-2025',
        endDate: '',
        imagePath: [],
        spareParts: [
          {
            'item_name': 'Brake Pad Set',
            'item_code': 'BP-3456',
            'quantity': '2',
          },
          {
            'item_name': 'Hydraulic Hose',
            'item_code': 'HH-7890',
            'quantity': '3',
          },
        ],
        serviceChecklist: [
          { "name": "Engine Check", "completed": true },
          { "name": "Brake System", "completed": true },
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "ABC Rental Sdn Bhd",
            picName: "Ahmed Ali",
            picContactNum: "+60156244825",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "Customer/User",
        breakdownItems: [],
        technicianNotes: "Replaced brake pads and checked hydraulic system",
        hourMeter1: "1250",
        hourMeter2: "1253",
        customerName: "John Tan",
        customerContact: "+60123456789"
    ));

    // 2. FAILED - PM task with network error
    myOutboxTask.add(TaskModel(
        id: 'OutboxTask2',
        swoNumber: 'SWO-2024-202',
        taskType: 'PM',
        dept: 'ME',
        equipmentId: 'EQ-22456',
        assignedDate: '16/12/2025',
        savedAt: DateTime.now(),
        status: "failed",
        errorMessage: "Network timeout - Unable to reach server",
        retryCount: 2,
        timeStart: '16-12-2025 09:30:00',
        timeEnd: '24-12-2024 08:30:00',
        duration: '3',
        pauseTime: '18-12-2024 08:30:00',
        pauseReason: 'Waiting for spare parts',
        startDate: '16-12-2025',
        endDate: '',
        imagePath: [],
        spareParts: [
          {
            'item_name': 'Engine Belt',
            'item_code': 'EB-2345',
            'quantity': '1',
          },
          {
            'item_name': 'Coolant Fluid',
            'item_code': 'CF-6789',
            'quantity': '5',
          },
        ],
        serviceChecklist: [
          { "name": "Engine Check", "completed": true },
          { "name": "Hydraulic System", "completed": true },
          { "name": "Oil Level Inspection", "completed": true },
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "Cre8 IOT Sdn Bhd",
            picName: "Naga",
            picContactNum: "+6014436667",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "Customer/User",
        breakdownItems: [],
        technicianNotes: "Regular preventive maintenance completed",
        hourMeter1: "2100",
        hourMeter2: "2104",
        customerName: "Siti Aminah",
        customerContact: "+60198765432"
    ));

    // 3. PENDING - Breakdown task
    myOutboxTask.add(TaskModel(
        id: 'OutboxTask3',
        swoNumber: 'SWO-2024-203',
        taskType: 'BD',
        dept: 'EE',
        equipmentId: 'PG02091',
        assignedDate: '15/12/2025',
        savedAt: DateTime.now(),
        status: "pending_upload",
        timeStart: '15-12-2024 09:00:00',
        timeEnd: '20-12-2024 08:30:00',
        duration: '2',
        pauseTime: '0',
        pauseReason: '-',
        startDate: '15-12-2024 09:00:00',
        endDate: '',
        imagePath: [],
        spareParts: [
          {
            'item_name': 'Hydraulic Hose',
            'item_code': 'HH-7890',
            'quantity': '2',
          },
        ],
        serviceChecklist: [
          { "name": "Engine Check", "completed": true },
          { "name": "Hydraulic System", "completed": true },
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "ABC Rental Sdn Bhd",
            picName: "Ahmed Ali",
            picContactNum: "+60156244825",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "Vendor/Provider",
        breakdownItems: [],
        technicianNotes: "Fixed hydraulic hose connection",
        hourMeter1: "3400",
        hourMeter2: "3402",
        customerName: "Kumar Raj",
        customerContact: "+60134567890"
    ));

    // 4. FAILED - BD task with server error
    myOutboxTask.add(TaskModel(
        id: 'OutboxTask4',
        swoNumber: 'SWO-2024-204',
        taskType: 'BD',
        dept: 'ME',
        equipmentId: 'EQ-22789',
        assignedDate: '14/12/2025',
        savedAt: DateTime.now().subtract(Duration(hours: 12)),
        status: "failed",
        errorMessage: "Server error 500 - Upload failed",
        retryCount: 3,
        timeStart: '14-12-2025 08:55:00',
        timeEnd: '19-12-2025 17:30:00',
        duration: '1',
        pauseTime: '15-12-2025 13:00:00',
        pauseReason: 'On break',
        startDate: '14-12-2024',
        endDate: '',
        imagePath: [],
        spareParts: [
          {
            'item_name': 'Brake Pad Set',
            'item_code': 'BP-3456',
            'quantity': '1',
          },
          {
            'item_name': 'Engine Belt',
            'item_code': 'EB-2345',
            'quantity': '2',
          },
          {
            'item_name': 'Coolant Fluid',
            'item_code': 'CF-6789',
            'quantity': '3',
          },
        ],
        serviceChecklist: [
          { "name": "Engine Check", "completed": true },
          { "name": "Brake System", "completed": true },
          { "name": "Hydraulic System", "completed": true },
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "Cre8 IOT Sdn Bhd",
            picName: "Naga",
            picContactNum: "+6014436667",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "Vendor/Provider",
        breakdownItems: [],
        technicianNotes: "Replaced coolant and belts, fixed brake system",
        hourMeter1: "4500",
        hourMeter2: "4504",
        customerName: "Lee Wei Ming",
        customerContact: "+60176543210"
    ));

    // 5. PENDING - PM task ready to upload
    myOutboxTask.add(TaskModel(
        id: 'OutboxTask5',
        swoNumber: 'SWO-2024-205',
        taskType: 'PM',
        dept: 'EE',
        equipmentId: 'PG02095',
        assignedDate: '13/12/2025',
        savedAt: DateTime.now().subtract(Duration(minutes: 45)),
        status: "pending_upload",
        timeStart: '13-12-2025 08:30:00',
        timeEnd: '17-12-2025 08:30:00',
        duration: '2',
        pauseTime: '0',
        pauseReason: '-',
        startDate: '13-12-2024',
        endDate: '',
        imagePath: [],
        spareParts: [
          {
            'item_name': 'Engine Belt',
            'item_code': 'EB-2345',
            'quantity': '1',
          },
          {
            'item_name': 'Hydraulic Hose',
            'item_code': 'HH-7890',
            'quantity': '1',
          },
        ],
        serviceChecklist: [
          { "name": "Engine Check", "completed": true },
          { "name": "Oil Level Inspection", "completed": true },
        ],
        myCompanyInfo: CompanyInfo(
            rentalCompany: "ABC Rental Sdn Bhd",
            picName: "Ahmed Ali",
            picContactNum: "+60156244825",
            latitude: 3.074118505289,
            longitude: 101.6251485159
        ),
        breakdownCausedBy: "Customer/User",
        breakdownItems: [],
        technicianNotes: "Routine preventive maintenance - all systems OK",
        hourMeter1: "5200",
        hourMeter2: "5202",
        customerName: "Ahmad Ibrahim",
        customerContact: "+60189876543"
    ));

    saveOutboxTasks(myOutboxTask);
  }

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(
      tasks.map((e) => e.toJson()).toList(),
    );
    await prefs.setString(taskKey, jsonString);

    setState(() {
      getSavedTask();
      refreshTask();
    });
  }

  Future<void> saveOutboxTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(
      tasks.map((e) => e.toJson()).toList(),
    );
    await prefs.setString(outboxTaskKey, jsonString);

    setState(() {
      getSavedOutboxTask();
      refreshTask();
    });
  }

  refreshTask(){
    intPendingTask = 0;
    intCompleteTask = 0;
    intOutboxTask = 0;
    intAssignedTask = 0;

    // Count tasks from myTask
    for(var i in myTask){
      switch(i.status){
        case "In Progress":
          intPendingTask += 1;
          break;
        case "Paused":
          intPendingTask += 1;
          break;
        case "Completed":
          intCompleteTask += 1;
          break;
        default:
          intAssignedTask += 1;
          break;
      }
    }

    // Count outbox tasks from myOutboxTask list
    intOutboxTask = myOutboxTask.length;
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen(
      saveTasks: saveTasks,
      saveOutboxTasks: saveOutboxTasks,
    );
  }
}
