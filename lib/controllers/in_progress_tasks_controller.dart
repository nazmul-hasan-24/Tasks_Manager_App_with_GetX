import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class InProgressTasksController extends GetxController{
  bool  _getProgressTaskInProgress = false;
  bool get getProgressTaskInProgress => _getProgressTaskInProgress;
TaskListModel _taskListModel = TaskListModel();
TaskListModel get taskListModel => _taskListModel;
    Future<void> getProgressTaskList() async {
    _getProgressTaskInProgress = true;
   update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getInProgressTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    _getProgressTaskInProgress = false;
   update();
}
}