import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/delete_task_controller.dart';
import 'package:task_manager/controllers/in_progress_tasks_controller.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/task_items_cart.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {


  //    bool showProgress = false;
  // Future<void> deleteTaskById(String id) async {
  //   showProgress = true;
  //   setState(() {});
  //   final response = await NetworkCaller().getRequest(
  //     Urls.deleteTask(id),
  //   );
  //   if (response.isSuccess) {
  //     if (mounted) {
  //       showSnackMessage(context, "Task deleted successfully");
  //     }

  //     getProgressTaskList();
  //   } else {
  //     if (mounted) {
  //       showProgress = false;
        
  //       showSnackMessage(context, "Task deletion failed");
  //       setState(() {
          
  //       });
  //     }
  //   }
  // }

    @override
  void initState() {
    super.initState();
   Get.find<InProgressTasksController>().getProgressTaskList();
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
              child: GetBuilder<InProgressTasksController>(
                builder: (inProgressTasksList) {
                  return Visibility(
                    visible: inProgressTasksList.getProgressTaskInProgress == false,
                    
                     replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: RefreshIndicator(
                      onRefresh: inProgressTasksList.getProgressTaskList,
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10.0),
                          itemCount: inProgressTasksList.taskListModel.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TasksItemCard(
                              task: inProgressTasksList.taskListModel.taskList![index],
                              onStatusChange: () {
                                inProgressTasksList.getProgressTaskList();
                              },
                              showProgress: (inProgress){
                               
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
            ),
          ],
        ),
       
      ),
    );
  }
}

