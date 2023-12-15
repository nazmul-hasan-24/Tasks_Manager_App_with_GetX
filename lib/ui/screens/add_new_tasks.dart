import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddNewTaskController addnewTasksController =
      Get.find<AddNewTaskController>();
  @override
  void initState() {
    super.initState();
    const NewTaskScreen();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const ProfileSummery(
              enableOnTab: false,
            ),
            Expanded(
              child: BodyBackGround(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      verticle(50),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add New Task',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              verticle(20),
                              TextFormField(
                                controller: _subjectTEController,
                                validator: (String? value) {
                                  if (value?.trim().isEmpty ?? true) {
                                    return 'Enter your subject';
                                  }
                                  return null;
                                },
                                decoration:
                                    const InputDecoration(hintText: 'Subject'),
                              ),
                              verticle(10),
                              TextFormField(
                                controller: _descriptionTEController,
                                validator: (String? value) {
                                  if (value?.trim().isEmpty ?? true) {
                                    return 'Enter Description';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: 'Descriptions'),
                                maxLines: 8,
                              ),
                              verticle(15),
                              GetBuilder<AddNewTaskController>(
                                  builder: (addNewTaskController) {
                                return Visibility(
                                  visible: addNewTaskController
                                          .createTaskInProgress ==
                                      false,
                                  replacement: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  child: ElevatedButton(
                                      onPressed: createTask,
                                      child: const Icon(
                                          Icons.arrow_circle_right_outlined)),
                                );
                              })
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> createTask() async {
    if (_formKey.currentState!.validate()) {
      final response = addnewTasksController.addNewTask(
        _subjectTEController.text.trim(),
        _descriptionTEController.text.trim(),
      );

      if (await response) {
        _subjectTEController.clear();
        _descriptionTEController.clear();

        if (mounted) {
          showSnackMessage(context, addnewTasksController.message);

          Get.offAll(() => const MainBottomNavScreen());
        }
      } else {
        if (mounted) {

          showSnackMessage(context, addnewTasksController.message, true);
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionTEController.dispose();
    _subjectTEController.dispose();
  }
}
