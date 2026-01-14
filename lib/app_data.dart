import 'package:field_technician_demo/ui/data_model/task_model.dart';

String taskKey = "my_task";
List<TaskModel> myTask = [];

List<TaskModel> myOutboxTask = [];
const String outboxTaskKey = 'outbox_tasks';

String appVersion = "v4";

int TASK_ASSIGNED = 0;
int TASK_PENDING = 1;
int TASK_OUTBOX = 2;
int TASK_COMPLETE = 3;

int intAssignedTask = 0;
int intPendingTask = 0;
int intOutboxTask = 0;
int intCompleteTask = 0;
