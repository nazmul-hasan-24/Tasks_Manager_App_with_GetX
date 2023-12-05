

import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';


class TaskManager extends StatelessWidget {
  const TaskManager({super.key});
  static GlobalKey<NavigatorState>  navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}