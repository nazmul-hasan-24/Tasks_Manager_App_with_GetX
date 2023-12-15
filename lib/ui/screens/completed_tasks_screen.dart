import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/complete_tasks_controller.dart';
import 'package:task_manager/controllers/delete_task_controller.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/task_items_cart.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
 
  @override
  void initState() {
    super.initState();
   Get.find<CompleteTasksController>().getCompleteTaskList();
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
              child: GetBuilder<CompleteTasksController>(
                builder: (completeTasksController) {
                  return Visibility(
                    visible: completeTasksController.getCompleteTaskInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: RefreshIndicator(
                      onRefresh: completeTasksController.getCompleteTaskList,
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10.0),
                          itemCount: completeTasksController.taskListModel.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TasksItemCard(
                              task: completeTasksController.taskListModel.taskList![index],
                              onStatusChange: () {
                                completeTasksController.getCompleteTaskList();
                              },
                              showProgress: (inProgress) {
                              
                              
                              },
                              onPressDeleted: (String id){
                                Get.find<DeleteTaskController>().deleteTaskById(id);
                              },
                            );
                          }),
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
