

import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add New Task",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            verticle(20),
                           
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: "Subject"),
                            ),
                            verticle(10),
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: "Descriptions"),
                              maxLines: 8,
                            ),
                            verticle(15),
                            ElevatedButton(
                                onPressed: () {},
                                child: const Icon(Icons.arrow_circle_right_outlined))
                          ],
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
}
