import 'package:get/get.dart';
import 'package:task_manager/data/models/task_count_summary_list.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class TasksCountController extends GetxController{
  bool _getTaskSummaryCountInProgress = false;
  bool get getTaskSummaryCountInProgress => _getTaskSummaryCountInProgress;
     TaskCountSummaryList _taskCountSummaryListModel = TaskCountSummaryList();
    TaskCountSummaryList get taskCountSummaryListModel=> _taskCountSummaryListModel;

//    Future<bool> taskSummeryCount() async {
// bool isSuccess = false;

//     _getTaskSummaryCountInProgress = true;
//   update();
//     final NetworkResponse response =
//         await NetworkCaller().getRequest(Urls.getTaskSummaryCount);
//     if (response.isSuccess) {
//       _getTaskSummaryCountInProgress = false;
//       update();
//     } else {
//     update();
//     } return isSuccess;
//   } 

   Future<void> taskSummeryCount() async {
    _getTaskSummaryCountInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskSummaryCount);
    if (response.isSuccess) {
      _taskCountSummaryListModel =
          TaskCountSummaryList.fromJson(response.jsonResponse);
      _getTaskSummaryCountInProgress = false;
     update();
    } else {
     _getTaskSummaryCountInProgress = false;
     update();
    }
  }
}

