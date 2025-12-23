
class OutboxTask {
  final String id;
  final String swoNumber;
  final String taskType;
  final String dept;
  final String equipmentNo;
  final String assignedDate;
  final Map<String, dynamic> taskData;
  final DateTime savedAt;
  final String status;
  final String? errorMessage;
  final int retryCount;

  OutboxTask({
    required this.id,
    required this.swoNumber,
    required this.taskType,
    required this.dept,
    required this.equipmentNo,
    required this.assignedDate,
    required this.taskData,
    required this.savedAt,
    this.status = 'pending_upload',
    this.errorMessage,
    this.retryCount = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'swoNumber': swoNumber,
      'taskType': taskType,
      'dept': dept,
      'equipmentNo': equipmentNo,
      'assignedDate': assignedDate,
      'taskData': taskData,
      'savedAt': savedAt.toIso8601String(),
      'status': status,
      'errorMessage': errorMessage,
      'retryCount': retryCount,
    };
  }

  factory OutboxTask.fromJson(Map<String, dynamic> json) {
    return OutboxTask(
      id: json['id'] as String,
      swoNumber: json['swoNumber'] as String,
      taskType: json['taskType'] as String,
      dept: json['dept'] as String,
      equipmentNo: json['equipmentNo'] as String,
      assignedDate: json['assignedDate'] as String,
      taskData: Map<String, dynamic>.from(json['taskData'] as Map),
      savedAt: DateTime.parse(json['savedAt'] as String),
      status: json['status'] as String? ?? 'pending_upload',
      errorMessage: json['errorMessage'] as String?,
      retryCount: json['retryCount'] as int? ?? 0,
    );
  }

  OutboxTask copyWith({
    String? id,
    String? swoNumber,
    String? taskType,
    String? dept,
    String? equipmentNo,
    String? assignedDate,
    Map<String, dynamic>? taskData,
    DateTime? savedAt,
    String? status,
    String? errorMessage,
    int? retryCount,
  }) {
    return OutboxTask(
      id: id ?? this.id,
      swoNumber: swoNumber ?? this.swoNumber,
      taskType: taskType ?? this.taskType,
      dept: dept ?? this.dept,
      equipmentNo: equipmentNo ?? this.equipmentNo,
      assignedDate: assignedDate ?? this.assignedDate,
      taskData: taskData ?? this.taskData,
      savedAt: savedAt ?? this.savedAt,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      retryCount: retryCount ?? this.retryCount,
    );
  }
}