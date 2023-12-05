import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';
import 'package:task_manager/ui/widgets/task_items_cart.dart';

class CancledTaskScreen extends StatefulWidget {
  const CancledTaskScreen({super.key});

  @override
  State<CancledTaskScreen> createState() => _CancledTaskScreenState();
}

class _CancledTaskScreenState extends State<CancledTaskScreen> {
  
bool getCancleTaskInProgress = false;
TaskListModel taskListModel = TaskListModel();
Future<void> getCancleTaskList() async {
    getCancleTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCancleTasks);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getCancleTaskInProgress = false;
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

      getCancleTaskList();
    } else {
      if (mounted) {
        showProgress = false;
        ;
        showSnackMessage(context, "Task deleted failed");
        setState(() {
          
        });
      }
    }
  }

    @override
  void initState() {
     super.initState();
     getCancleTaskList();
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
                visible: getCancleTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getCancleTaskList,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10.0),
                      itemCount: taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TasksItemCard(
                          task: taskListModel.taskList![index],
                          onStatusChange: () {
                            getCancleTaskList();
                          },
                          showProgress: (inProgress) {
                            getCancleTaskInProgress = inProgress;
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

