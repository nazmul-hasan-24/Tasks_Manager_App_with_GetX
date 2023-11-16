import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/task_items_cart.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileSummery(),
         
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const TasksItemCard();
                    }))
          ],
        ),
       
      ),
    );
  }
}

