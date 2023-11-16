import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/horizontal.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

class TasksItemCard extends StatelessWidget {
  const TasksItemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 8),
              child: Text(
                "Title will be here",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
            const Text(
              "Description",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.black),
            ),
            verticle(8),
            const Text(
              "Crated date: 11/11/2023",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.black),
            ),
            verticle(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Chip(label: Text("New")),
                ),
                Wrap(
                  children: [
                    const Icon(Icons.edit),
                    horizontal(8),
                    const Icon(Icons.delete_forever_rounded)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
