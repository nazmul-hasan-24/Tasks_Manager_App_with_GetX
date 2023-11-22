import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_tasks.dart';
import 'package:task_manager/ui/widgets/card_summery.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/task_items_cart.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileSummery(),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SummaryCard(
                    count: "100",
                    title: 'New',
                  ),
                  SummaryCard(count: '12', title: 'In Progress'),
                  SummaryCard(count: '44', title: 'Completed'),
                  SummaryCard(count: '30', title: 'Cancaled'),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const TasksItemCard();
                    }))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNewTask(),
              ),
            );
          },
          child: const Icon(
            (Icons.add),
          ),
        ),
      ),
    );
  }
}
