import 'package:get/get.dart';
import 'package:task_manager/controllers/new_tasks_controller.dart';
import 'package:task_manager/controllers/tasks_count_controller.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class AddNewTaskController extends GetxController {
  bool _createTaskInProgress = false;
  bool get createTaskInProgress => _createTaskInProgress;

  String _message = '';
  String get message => _message;
  Future<bool> addNewTask(String subject, String description) async {
    _createTaskInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller().postRequest(
      Urls.createNewTask,
      body: {
        'title': subject,
        'description': description,
        'status': 'New',
      },
    );
    update();

    if (response.isSuccess) {
      Get.find<NewTasksController>().getNewTaskList();
      Get.find<TasksCountController>().taskSummeryCount();
      _createTaskInProgress = false;
      update();
      _message = 'New task added!';

      // Get.offAll(() => const MainBottomNavScreen());
      return true;
    } else {
      _createTaskInProgress = false;
      update();
      _message = 'Create new task failed! Try again.';
    }
    return false;
  }
}
