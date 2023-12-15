import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/aouth_controller.dart';
import 'package:task_manager/controllers/email_verifaction_controller.dart';
import 'package:task_manager/ui/screens/otp_verification.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailVerifactionController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EmailVerifactionController emailVerifactionController =
      Get.find<EmailVerifactionController>();

// @override
//   void initState() {
//      super.initState();
//      emailVerify();
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackGround(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticle(80),
                Text(
                  "Enter your Email Address",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "A 6 digit verification pin will send to your\nemail address",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                verticle(15),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _emailVerifactionController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter valid Email";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                verticle(16.0),
                GetBuilder<EmailVerifactionController>(
                  builder: (emailVerifactionController) => Visibility(
                    visible:
                        emailVerifactionController.codeSentInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          emailVerifaction();

                          print("Verifiy");
                        },
                        child: const Text("Verify")),
                  ),
                ),
                verticle(30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an account?",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sing In",
                          style: TextStyle(color: Colors.green),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> emailVerifaction() async {
    if (_formKey.currentState!.validate()) {
      final response = emailVerifactionController.emailVerification(
          email: _emailVerifactionController.text.trim());
      if (await response) {
        await AuthController.writeEmailVerification(
            _emailVerifactionController.text.trim());
        await AuthController.initializeUserCache(
            _emailVerifactionController.text);

        if (mounted) {
          showSnackMessage(context, emailVerifactionController.message);
        }
        if (mounted) {
          Get.to(()=>OtpVerificationScreen(email: _emailVerifactionController.text,));
        }
      } else {
        if (mounted) {
          showSnackMessage(context, emailVerifactionController.message, true);
        }
      }
    }
  }
}
