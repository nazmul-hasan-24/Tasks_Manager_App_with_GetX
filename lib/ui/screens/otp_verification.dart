import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/controllers/aouth_controller.dart';
import 'package:task_manager/controllers/otp_verifaction_screen_controller.dart';
import 'package:task_manager/ui/screens/set_new_password.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

OtpVerificationScreenController pinVerificationScreenController = Get.find<OtpVerificationScreenController>();
  Future<void> otpVerification() async {
    if (_formKey.currentState!.validate()) {
  
      final  response =
          await pinVerificationScreenController.otpVerification(email: widget.email, otp: _pinController.text);

      if (response) {
       AuthController.initializeUserCache( _pinController.text);
         Get.to(()=>SetPassword(email: widget.email, otp: _pinController.text));
        if (mounted) {
          showSnackMessage(context, pinVerificationScreenController.message);
        }
        } else {
        if (mounted) {
          showSnackMessage(
              context, pinVerificationScreenController.message);
          
        }
      }
    }
  }

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
                  "Pin Verification",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "A 6 digit verification pin will send to your email address",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                verticle(15),
                Form(
                  key: _formKey,
                  child: PinCodeTextField(
                    keyboardType: TextInputType.number,
                    controller: _pinController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter valid OTP";
                      } else if(value!.length <6){
                        return "OTP must be 6 characters";
                      }
                      return null;
                    },
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    // errorAnimationController: errorController,
                    // controller: textEditingController,
                    onCompleted: (v) {},
                  ),
                ),
                verticle(16.0),
                GetBuilder<OtpVerificationScreenController>(
                  builder: (otpVerificationController) {
                    return Visibility(
                      visible: otpVerificationController.showProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                          onPressed: () {
                    otpVerification();
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    );
                  }
                ),
                verticle(30.0),
                Row(
                  children: [
                    const Text(
                      "Have an account?",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                        onPressed: () {
                          otpVerification();
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
}
