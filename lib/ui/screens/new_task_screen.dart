import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/delete_task_controller.dart';
import 'package:task_manager/controllers/new_tasks_controller.dart';
import 'package:task_manager/controllers/tasks_count_controller.dart';
import 'package:task_manager/data/models/tasks_count.dart';
import 'package:task_manager/ui/screens/add_new_tasks.dart';
import 'package:task_manager/ui/widgets/card_summery.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/task_items_cart.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({
    super.key,
  });

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  // TaskListModel taskListModel = TaskListModel();

 



  @override
  void initState() {
    super.initState();
   Get.find<NewTasksController>().getNewTaskList();
    Get.find<TasksCountController>().taskSummeryCount();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const ProfileSummery(),
            GetBuilder<TasksCountController>(
              builder: (taskscountController) {
                return Visibility(
                  visible: taskscountController.getTaskSummaryCountInProgress == false &&
                      (taskscountController.taskCountSummaryListModel.taskCountList?.isNotEmpty ?? true),
                  replacement: const LinearProgressIndicator(),
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:taskscountController.taskCountSummaryListModel.taskCountList?.length,
                      itemBuilder: (context, index) {
                        TasksCount? tasksCount =
                           taskscountController.taskCountSummaryListModel.taskCountList?[index];
                        return FittedBox(
                          child: SummaryCard(
                              count: tasksCount?.sum.toString(),
                              title: tasksCount?.sId ?? ''),
                        );
                      },
                    ),
                  ),
                );
              }
            ),
            Expanded(
              child: GetBuilder<NewTasksController>(
                  builder: (newTaskController) {
                return Visibility(
                  visible: newTaskController.getNewTaskInProgress==false ,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh:()=> newTaskController.getNewTaskList(),
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10.0),
                        itemCount:newTaskController.taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TasksItemCard(
                            task: newTaskController.taskListModel.taskList![index],
                            onStatusChange: () {
                             newTaskController.getNewTaskList;
                            },
                            showProgress: (inProgress) {},
                            onPressDeleted: (String id) {
                            Get.find<DeleteTaskController>().deleteTaskById(id);
                            },
                          );
                        }),
                  ),
                );
              }),
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
          
            NewTasksController().getNewTaskList;
          },
          child: const Icon(
            (Icons.add),
          ),
        ),
      ),
    );
  }
}
