

import 'package:task_manager/data/models/tasks_count.dart';

class TaskCountSummaryList {
  String? status;
  List<TasksCount>? taskCountList;

  TaskCountSummaryList({this.status, this.taskCountList});

  TaskCountSummaryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCountList = <TasksCount>[];
      json['data'].forEach((v) {
        taskCountList!.add(TasksCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    if (taskCountList != null) {
      data['data'] = taskCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

