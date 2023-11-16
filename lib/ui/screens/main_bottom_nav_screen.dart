import 'package:flutter/material.dart';
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
List screen =const [ 
  NewTaskScreen(),
  ProgressTasksScreen(),
  CompletedTaskScreen(),
  CancledTaskScreen()
];

  int _seletedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: screen[_seletedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
    _seletedIndex=value;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _seletedIndex,
        items: const [
         BottomNavigationBarItem(
       
            icon: Icon(
              Icons.text_rotate_vertical,
            ),
            label: ("New Task")
          ),
           BottomNavigationBarItem(
            icon: Icon(
              Icons.work_history,
            ),
            label: ("Inprogress")
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
