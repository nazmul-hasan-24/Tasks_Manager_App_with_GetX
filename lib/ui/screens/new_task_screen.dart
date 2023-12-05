import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_count_summary_list.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/tasks_count.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/screens/add_new_tasks.dart';
import 'package:task_manager/ui/widgets/card_summery.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';
import 'package:task_manager/ui/widgets/task_items_cart.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({
    super.key,
  });

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool getNewTaskInProgress = false;
  bool getTaskSummaryCountInProgress = false;

  TaskListModel taskListModel = TaskListModel();
  TaskCountSummaryList taskCountSummaryListModel = TaskCountSummaryList();

  Future<void> getNewTaskList() async {
    getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTasks);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> taskSummeryCount() async {
    getTaskSummaryCountInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskSummaryCount);
    if (response.isSuccess) {
      taskCountSummaryListModel =
          TaskCountSummaryList.fromJson(response.jsonResponse);
          getTaskSummaryCountInProgress = false;
          setState(() {
             getTaskSummaryCountInProgress = false;
          });
    } else{
       getTaskSummaryCountInProgress = false;
    if (mounted) {
      setState(() {});
    }
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

      getNewTaskList();
      taskSummeryCount();
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
    getNewTaskList();
    taskSummeryCount();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(

          children: [
            const ProfileSummery(),
            Visibility(
              visible: getTaskSummaryCountInProgress == false &&
                  (taskCountSummaryListModel.taskCountList?.isNotEmpty ??
                      true),
              replacement: const LinearProgressIndicator(),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: taskCountSummaryListModel.taskCountList?.length,
                  itemBuilder: (context, index) {
                    TasksCount tasksCount =
                        taskCountSummaryListModel.taskCountList![index];
                    return FittedBox(
                      child: SummaryCard(
                          count: tasksCount.sum.toString(),
                          title: tasksCount.sId ?? ''),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: getNewTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getNewTaskList,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10.0),
                      itemCount: taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TasksItemCard(
                          task: taskListModel.taskList![index],
                          onStatusChange: () {
                            getNewTaskList();

                          },
                          showProgress: (inProgress) {
                            getNewTaskInProgress = inProgress;
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
        floatingActionButton: FloatingActionButton(
          // onPressed: navigateToAddPage,
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNewTask(),
              ),
            );
            setState(() {
              getNewTaskInProgress = true;
            });
            getNewTaskList();
          },
          child: const Icon(
            (Icons.add),
          ),
        ),
      ),
    );
  }
}





