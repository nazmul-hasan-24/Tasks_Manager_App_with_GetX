import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/widgets/body_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToLogin();
  }

  void goToLogin()  async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   String? token = sharedPreferences.getString('token');
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return token == null? const LoginScreen(): const MainBottomNavScreen();
        }), (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyBackGround(
      child: Center(
        child: SvgPicture.asset(
          "assets/images/logo.svg",
          width: 120,
        ),
      ),
    ));
  }
}
