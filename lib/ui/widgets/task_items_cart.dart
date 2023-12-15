// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/new_tasks_controller.dart';
import 'package:task_manager/controllers/tasks_count_controller.dart';
import 'package:task_manager/data/models/task.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/widgets/horizontal.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancled,
}

class TasksItemCard extends StatefulWidget {
  const TasksItemCard(
      {super.key,
      required this.task,
      required this.onStatusChange,
      required this.onPressDeleted,
      required this.showProgress});
  final Task task;
  final VoidCallback onStatusChange;
  final Function(bool) showProgress;
  final Function(String) onPressDeleted;

  @override
  State<TasksItemCard> createState() => _TasksItemCardState();
}

class _TasksItemCardState extends State<TasksItemCard> {
  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    setState(() {});
    final response = await NetworkCaller().getRequest(
      Urls.updateTaskStatus(widget.task.sId ?? '', status),
    );
    if (response.isSuccess) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 8),
              child: Text(
                widget.task.title ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
            Text(
              widget.task.description ?? '',
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.black),
            ),
            verticle(8),
            Text(
              widget.task.createdDate ?? '',
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.black),
            ),
            verticle(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Chip(
                    label: Text(widget.task.status ?? ''),
                    backgroundColor: Colors.blue,
                  ),
                ),
                Wrap(
                  children: [
                    IconButton(
                        onPressed: () {
                          showUpdateStatusModal();
                        },
                        icon: const Icon(Icons.edit)),
                    horizontal(8),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return alertDialog(context);
                            });
                            Get.find<NewTasksController>().getNewTaskList();
                            Get.find<TasksCountController>().taskSummeryCount();
                      },
                      icon: const Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.red,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  AlertDialog alertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Do you want to delete",
        style: TextStyle(fontSize: 21),
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
      ),
      actions: [
        ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () {
                    widget.onPressDeleted(widget.task.sId.toString());
                    Navigator.pop(context);
                  },
                  child: const Text('Yes'),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        ),
      ],
    );
  }

  void showUpdateStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map(
          (e) => ListTile(
            title: Text(e.name),
            onTap: () {
              updateTaskStatus(e.name);
              Navigator.pop(context);
            },
          ),
        )
        .toList();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update status"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancle'),
                  ),
                ],
              )
            ],
          );
        });
  }
}
