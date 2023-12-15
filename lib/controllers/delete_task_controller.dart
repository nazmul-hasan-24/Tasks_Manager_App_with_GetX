import 'package:get/get.dart';
import 'package:task_manager/controllers/new_tasks_controller.dart';
import 'package:task_manager/controllers/tasks_count_controller.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class DeleteTaskController extends GetxController{
  bool _deleteInProgress = false;
    bool get deleteInProgress => _deleteInProgress;
    String _deleationMessage = '';
    String get deleationMessage => _deleationMessage;
  Future<void> deleteTaskById(String id) async {
    _deleteInProgress = true;
     update();
    final response = await NetworkCaller().getRequest(
      Urls.deleteTask(id),
    );
    if (response.isSuccess) {
    _deleationMessage= "Task deleted successfully";
      

      NewTasksController().getNewTaskList();
      Get.find<TasksCountController>().taskSummeryCount();
    } else {
  
        _deleteInProgress = false;

        _deleationMessage= "Task deleted failed";
        update();
      
    }
  }
}