import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/login_controller.dart';
import 'package:task_manager/ui/screens/email_verification.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/sign_up_page.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController __emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackGround(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text("Get Started With",
                        style: Theme.of(context).textTheme.titleLarge),
                    verticle(20.0),
                    TextFormField(
                      controller: __emailTEController,
                      validator: (value) {
                        if (value!.trim().isEmpty ||
                            !RegExp(r'^[\w-\.]+@').hasMatch(value)) {
                          return "Enter valid Email";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    verticle(20.0),
                    TextFormField(
                      controller: _passwordTEController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter valid password";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    verticle(16.0),
                    GetBuilder<LoginController>(builder: (loginController) {
                      return Visibility(
                        visible: loginController.loginInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: login,
                            child: const Icon(Icons.arrow_circle_right)),
                      );
                    }),
                    verticle(48),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.to(const ForgotPasswordScreen());
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account?"),
                        TextButton(
                          onPressed: () {
                            Get.to(const SignupPage());
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (mounted) {
      setState(() {});
    }
    final response = await _loginController.login(
        __emailTEController.text.trim(), _passwordTEController.text);
    if (response) {
        Get.to(() => const MainBottomNavScreen());
    } else {
      if (mounted) {
        showSnackMessage(context, _loginController.failedMessage);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    __emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
