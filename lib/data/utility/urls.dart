import 'package:task_manager/ui/widgets/task_items_cart.dart';

class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createNewTask = '$_baseUrl/createTask';
  static String getNewTasks =
      '$_baseUrl/listTaskByStatus/${TaskStatus.New.name}';
  static String getInProgressTasks =
      '$_baseUrl/listTaskByStatus/${TaskStatus.Progress.name}';
  static String getCompleteTasks =
      '$_baseUrl/listTaskByStatus/${TaskStatus.Completed.name}';
  static String getCancleTasks =
      '$_baseUrl/listTaskByStatus/${TaskStatus.Cancled.name}';
  static  String emailVerifaction(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';
  static const String getTaskSummaryCount = '$_baseUrl/taskStatusCount';
  static String updateTaskStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';
  static String deleteTask(String taskId) => '$_baseUrl//deleteTask/$taskId';

  static String updateProfile = '$_baseUrl/profileUpdate';
   static  String test=
      '$_baseUrl/RecoverVerifyEmail/nazmul.soft.bd@gmail.com';
 static String otpVerifaction(String email, String pin) => '$_baseUrl/RecoverVerifyOTP/$email/$pin';

 static String setPassword = '$_baseUrl/RecoverResetPass';
}
