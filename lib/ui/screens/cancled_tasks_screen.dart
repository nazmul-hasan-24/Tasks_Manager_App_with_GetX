import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/cancle_tasks_controller.dart';
import 'package:task_manager/controllers/delete_task_controller.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/task_items_cart.dart';

class CancledTaskScreen extends StatefulWidget {
  const CancledTaskScreen({super.key});

  @override
  State<CancledTaskScreen> createState() => _CancledTaskScreenState();
}

class _CancledTaskScreenState extends State<CancledTaskScreen> {
  



    @override
  void initState() {
     super.initState();
    Get.find<CancleTasksController>().getCancleTaskList();
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
              child: GetBuilder<CancleTasksController>(
                builder: (cancleTasksController) {
                  return Visibility(
                    visible: cancleTasksController.getCancleTaskInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: RefreshIndicator(
                      onRefresh: cancleTasksController.getCancleTaskList,
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10.0),
                          itemCount: cancleTasksController.taskListModel.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TasksItemCard(
                              task: cancleTasksController.taskListModel.taskList![index],
                              onStatusChange: () {
                                cancleTasksController.getCancleTaskList();
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

