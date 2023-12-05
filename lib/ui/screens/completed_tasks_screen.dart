import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';
import 'package:task_manager/ui/widgets/task_items_cart.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool getCompleteTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();
  Future<void> getCompleteTaskList() async {
    getCompleteTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCompleteTasks);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getCompleteTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

   bool showProgress = false;
  Future<void> deleteTaskById(String id) async {
    showProgress = true;
    setState(() {});
    final response = await NetworkCaller().getRequest(
      Urls.deleteTask(id),
    );
    if (response.isSuccess) {
      if (mounted) {
        showSnackMessage(context, "Task deleted successfully");
      }

      getCompleteTaskList();
    } else {
      if (mounted) {
        showProgress = false;
        
        showSnackMessage(context, "Task deleted failed");
        setState(() {
          
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCompleteTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileSummery(),
            Expanded(
              child: Visibility(
                visible: getCompleteTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getCompleteTaskList,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10.0),
                      itemCount: taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TasksItemCard(
                          task: taskListModel.taskList![index],
                          onStatusChange: () {
                            getCompleteTaskList();
                          },
                          showProgress: (inProgress) {
                            getCompleteTaskInProgress = inProgress;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          onPressDeleted: (String id){
                            deleteTaskById(id);
                          },
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
