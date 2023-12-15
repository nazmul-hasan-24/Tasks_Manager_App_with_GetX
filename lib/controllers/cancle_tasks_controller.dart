import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class CancleTasksController extends GetxController{
  bool _getCancleTaskInProgress = false;
  bool get getCancleTaskInProgress=> _getCancleTaskInProgress;
TaskListModel _taskListModel = TaskListModel();
TaskListModel get taskListModel =>_taskListModel;
Future<void> getCancleTaskList() async {
    _getCancleTaskInProgress = true;
   update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCancleTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    _getCancleTaskInProgress = false;
  update();
    }
}