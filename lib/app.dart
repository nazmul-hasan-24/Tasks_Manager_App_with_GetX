

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/add_new_task_controller.dart';
import 'package:task_manager/controllers/cancle_tasks_controller.dart';
import 'package:task_manager/controllers/complete_tasks_controller.dart';
import 'package:task_manager/controllers/delete_task_controller.dart';
import 'package:task_manager/controllers/edit_profile_controller.dart';
import 'package:task_manager/controllers/email_verifaction_controller.dart';
import 'package:task_manager/controllers/in_progress_tasks_controller.dart';
import 'package:task_manager/controllers/login_controller.dart';
import 'package:task_manager/controllers/main_bottom_navigation_controller.dart';
import 'package:task_manager/controllers/new_tasks_controller.dart';
import 'package:task_manager/controllers/otp_verifaction_screen_controller.dart';
import 'package:task_manager/controllers/set_new_password_controller.dart';
import 'package:task_manager/controllers/sign_up_controller.dart';
import 'package:task_manager/controllers/tasks_count_controller.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';


class TaskManager extends StatelessWidget {
  const TaskManager({super.key});
  static GlobalKey<NavigatorState>  navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationKey,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
           fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600
          ),
          bodyMedium: TextStyle(
            fontSize: 16, 
          color: Colors.black38,
          )
        ),
        elevatedButtonTheme:   const ElevatedButtonThemeData(
        style:ButtonStyle(
          minimumSize: MaterialStatePropertyAll<Size>(Size(double.infinity, 13)),
          padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 12))
        )
        ),
        primaryColor: Colors.green,
        primarySwatch: Colors.green
      ),
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(NewTasksController());
    Get.put(TasksCountController());
    Get.put(DeleteTaskController());
    Get.put(InProgressTasksController());
    Get.put(CompleteTasksController());
    Get.put(CancleTasksController());
    Get.put(AddNewTaskController());
    Get.put(SignUpController());
    Get.put(EmailVerifactionController());
    Get.put(EditProfileController());
    Get.put(MainBottomNavigationController());
    Get.put(OtpVerificationScreenController());
    Get.put(SetNewPasswordController());

  }

}