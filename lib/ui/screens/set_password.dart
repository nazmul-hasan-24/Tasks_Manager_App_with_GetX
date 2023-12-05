import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/sign_up_page.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key, required this.email, required this.otp});
  final String email;
  final String otp;

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmpassTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loading = false;
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
                    Text(
                      "Set Password",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text(
                      "Minimum length password 6 characters",
                    ),
                    verticle(20.0),
                    TextFormField(
                      controller: _passwordTEController,
                       validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter password";
                      } else if(value!.length <6){
                        return "Password must be 6 characters or longer";
                      }
                      return null;
                    },
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    verticle(20.0),
                    TextFormField(
                      controller: _confirmpassTEController,
                      validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter password";
                      } else if(value!.length <6){
                        return "Password must be 6 characters or longer";
                      }
                      return null;
                    },
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Confirm Password",
                      ),
                    ),
                    verticle(16.0),
                    Visibility(
                      visible: _loading == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            resetPassword();
                          },
                          style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll<EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(vertical: 15.0))),
                          child: const Text("Confirm")),
                    ),
                    verticle(48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()));
                          },
                          child: const Text(
                            "Sign In",
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

  Future<void> resetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _loading = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller().postRequest(
      Urls.setPassword,
      body: {
        "email": widget.email,
        "OTP": widget.email,
        "password": _passwordTEController.text,
      },

    
    );
    _loading = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            (MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            )),
            (route) => false);
      }
    } else {
      _loading = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _confirmpassTEController.dispose();
    _passwordTEController.dispose();
  }
}
