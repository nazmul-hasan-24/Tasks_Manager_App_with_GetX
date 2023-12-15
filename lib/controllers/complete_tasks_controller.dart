import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class CompleteTasksController extends GetxController{
   bool _getCompleteTaskInProgress = false;
   bool get getCompleteTaskInProgress=>_getCompleteTaskInProgress;
  TaskListModel _taskListModel = TaskListModel();
  TaskListModel get taskListModel =>_taskListModel;
  Future<void> getCompleteTaskList() async {
    _getCompleteTaskInProgress = true;
   update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCompleteTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    _getCompleteTaskInProgress = false;
   update();
  }
}