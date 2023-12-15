import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/main_bottom_navigation_controller.dart';
import 'package:task_manager/ui/screens/cancled_tasks_screen.dart';
import 'package:task_manager/ui/screens/completed_tasks_screen.dart';
import 'package:task_manager/ui/screens/in_progress_tasks_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
List screen = const [ 
   NewTaskScreen(),
   ProgressTasksScreen(),
   CompletedTaskScreen(),
   CancledTaskScreen()
];

MainBottomNavigationController mainBottomNavigationController = Get.find<MainBottomNavigationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[mainBottomNavigationController.seletedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
    mainBottomNavigationController.seletedIndex=value;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: mainBottomNavigationController.seletedIndex,
        items: const [
         BottomNavigationBarItem(
       
            icon: Icon(
              Icons.task,
            ),
            label: ("New Task")
          ),
           BottomNavigationBarItem(
            icon: Icon(
              Icons.circle_outlined,
            ),
            label: ("Progressing")
          ),
           BottomNavigationBarItem(
            icon: Icon(
              Icons.done,
            ),
            label: ("Completed")
          ),
           BottomNavigationBarItem(
            icon: Icon(
              Icons.cancel,
            ),
            label: ("Cancled")
          ),
        ],
      ),
    );
  }
}
