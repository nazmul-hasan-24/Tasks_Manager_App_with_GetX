import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class NewTasksController extends GetxController {
  bool _getNewTaskInProgress = false;
  bool get getNewTaskInProgress => _getNewTaskInProgress;

  TaskListModel _taskListModel = TaskListModel();
TaskListModel get taskListModel => _taskListModel;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTaskInProgress = true;
    update();
     final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTasks);
    _getNewTaskInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    } 
    update();
    return isSuccess;
  }
}
