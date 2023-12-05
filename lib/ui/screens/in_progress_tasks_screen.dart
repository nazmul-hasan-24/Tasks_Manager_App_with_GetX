import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';
import 'package:task_manager/ui/widgets/task_items_cart.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {
bool  getProgressTaskInProgress = false;
TaskListModel taskListModel = TaskListModel();
    Future<void> getProgressTaskList() async {
    getProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getInProgressTasks);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getProgressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }}

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

      getProgressTaskList();
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
    getProgressTaskList();
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
                visible: getProgressTaskInProgress == false,
                // replacement: const Center(
                //   child: CircularProgressIndicator(),
                // ),
                 replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getProgressTaskList,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10.0),
                      itemCount: taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TasksItemCard(
                          task: taskListModel.taskList![index],
                          onStatusChange: () {
                            getProgressTaskList();
                          },
                          showProgress: (inProgress){
                            getProgressTaskInProgress = inProgress;
                            if(mounted){
                              setState(() { });
                            }
                          },
                          onPressDeleted: (String id){
                            deleteTaskById(id);
                          },
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
       
      ),
    );
  }
}

