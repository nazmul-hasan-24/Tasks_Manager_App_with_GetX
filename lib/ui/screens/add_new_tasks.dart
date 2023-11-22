import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
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
  final TextEditingController _descriptionTEController=  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _createTaskInProgress = false;
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
                                "Add New Task",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              verticle(20),
                              TextFormField(
                                controller: _subjectTEController,
                                validator: (String? value) {
                                  if (value?.trim().isEmpty ?? true) {
                                    return "Enter your subject";
                                  }
                                  return null;
                                },
                                decoration:
                                    const InputDecoration(hintText: "Subject"),
                              ),
                              verticle(10),
                              TextFormField(
                                controller: _descriptionTEController,
                                validator: (String? value) {
                                  if (value?.trim().isEmpty ?? true) {
                                    return "Enter Description";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: "Descriptions"),
                                maxLines: 8,
                              ),
                              verticle(15),
                              Visibility(
                                visible: _createTaskInProgress == false,
                                replacement: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                child: ElevatedButton(
                                    onPressed: createTask,
                                    child: const Icon(
                                        Icons.arrow_circle_right_outlined)),
                              )
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
      _createTaskInProgress = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.createNewTask, body: {
            "title": _subjectTEController.text.trim(),
            "description": _descriptionTEController.text.trim(),
            "status": "New"
          });
      _createTaskInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        _subjectTEController.clear();
        _descriptionTEController.clear();
        if (mounted) {
          showSnackMessage(context, 'New task added!');
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'Create new task failed! Try again.', true);
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
