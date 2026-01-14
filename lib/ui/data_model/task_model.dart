import 'outbox_model.dart';

class TaskModel {
  final String id;
  final String swoNumber;
  final String taskType;
  final String dept;
  final String equipmentId;
  String timeStart;
  String timeEnd;
  String duration;
  String pauseTime;
  String pauseReason;
  String assignedDate;
  DateTime savedAt;
  String status;
  late final String? errorMessage;
  late final int retryCount;
  List<String> imagePath;
  List<Map<String, dynamic>> spareParts;
  List<Map<String, dynamic>> serviceChecklist;
  CompanyInfo myCompanyInfo;
  String breakdownCausedBy;
  List<Map<String, String>> breakdownItems;
  String technicianNotes;
  String hourMeter1;
  String hourMeter2;
  String customerName;
  String customerContact;
  String startDate;
  String endDate;
  bool isPartsRequested = false;

  TaskModel({
    required this.id,
    required this.swoNumber,
    required this.taskType,
    required this.dept,
    required this.equipmentId,
    required this.timeStart,
    required this.timeEnd,
    required this.duration,
    required this.pauseTime,
    required this.pauseReason,
    required this.assignedDate,
    required this.savedAt,
    required this.status,
    this.errorMessage,
    this.retryCount = 0,
    required this.imagePath,
    required this.spareParts,
    required this.serviceChecklist,
    required this.myCompanyInfo,
    required this.breakdownCausedBy,
    required this.breakdownItems,
    required this.technicianNotes,
    required this.hourMeter1,
    required this.hourMeter2,
    required this.customerName,
    required this.customerContact,
    this.startDate = '',
    this.endDate = '',
    this.isPartsRequested = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'swoNumber': swoNumber,
      'taskType': taskType,
      'dept': dept,
      'equipmentId': equipmentId,
      'timeStart': timeStart,
      'timeEnd': timeEnd,
      'duration': duration,
      'pauseTime': pauseTime,
      'pauseReason': pauseReason,
      'assignedDate': assignedDate,
      'savedAt': savedAt.toIso8601String(),
      'status': status,
      'errorMessage': errorMessage,
      'retryCount': retryCount,
      'imagePath': imagePath,
      'spareParts': spareParts,
      'serviceChecklist': serviceChecklist,
      'myCompanyInfo': myCompanyInfo.toJson(),
      'breakdownCausedBy': breakdownCausedBy,
      'breakdownItems': breakdownItems,
      'technicianNotes': technicianNotes,
      'hourMeter1': hourMeter1,
      'hourMeter2': hourMeter2,
      'customerName': customerName,
      'customerContact': customerContact,
      'startDate': startDate,
      'endDate': endDate,
      'isPartsRequested': isPartsRequested,

    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      swoNumber: json['swoNumber'] as String,
      taskType: json['taskType'] as String,
      dept: json['dept'] as String,
      equipmentId: json['equipmentId'] as String,
      timeStart: json['timeStart'] as String,
      timeEnd: json['timeEnd'] as String,
      duration: json['duration'] as String,
      pauseTime: json['pauseTime'] as String,
      pauseReason: json['pauseReason'] as String,
      assignedDate: json['assignedDate'] as String,
      savedAt: DateTime.parse(json['savedAt'] as String),
      status: json['status'] as String,
      errorMessage: json['errorMessage'] as String?,
      retryCount: json['retryCount'] as int? ?? 0,
      imagePath: (json['imagePath'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      spareParts: (json['spareParts'] as List<dynamic>? ?? [])
          .map((e) => Map<String, dynamic>.from(e))
          .toList(),
      serviceChecklist:
      (json['serviceChecklist'] as List<dynamic>? ?? [])
          .map((e) => Map<String, dynamic>.from(e))
          .toList(),
      myCompanyInfo: CompanyInfo.fromJson(json['myCompanyInfo'] as Map<String, dynamic>),
      breakdownCausedBy: json['breakdownCausedBy'] as String,
      breakdownItems: (json['breakdownItems'] as List<dynamic>? ?? [])
          .map((e) => Map<String, String>.from(e))
          .toList(),
      technicianNotes: json['technicianNotes'] as String,
      hourMeter1: json['hourMeter1'] as String,
      hourMeter2: json['hourMeter2'] as String,
      customerName: json['customerName'] as String,
      customerContact: json['customerContact'] as String,
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      isPartsRequested: json['isPartsRequested'] as bool? ?? false,
    );
  }
}


class CompanyInfo {
  final String rentalCompany;
  final String picName;
  final String picContactNum;
  final double latitude;
  final double longitude;


  CompanyInfo({
    required this.rentalCompany,
    required this.picName,
    required this.picContactNum,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'rentalCompany': rentalCompany,
      'picName': picName,
      'picContactNum': picContactNum,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
      rentalCompany: json['rentalCompany'] as String,
      picName: json['picName'] as String,
      picContactNum: json['picContactNum'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}


