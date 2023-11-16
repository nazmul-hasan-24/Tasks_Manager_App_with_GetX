import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/task_items_cart.dart';

class CancledTaskScreen extends StatefulWidget {
  const CancledTaskScreen({super.key});

  @override
  State<CancledTaskScreen> createState() => _CancledTaskScreenState();
}

class _CancledTaskScreenState extends State<CancledTaskScreen> {
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
                  shrinkWrap: true,
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

