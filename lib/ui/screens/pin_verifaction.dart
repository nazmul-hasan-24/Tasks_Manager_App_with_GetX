import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/set_password.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

class PinVerifactionScreen extends StatefulWidget {
  const PinVerifactionScreen({super.key});

  @override
  State<PinVerifactionScreen> createState() => _PinVerifactionScreenState();
}

class _PinVerifactionScreenState extends State<PinVerifactionScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyBackGround(
        child: Padding(
          padding:const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticle(80),
                Text("Pin Verifaction",
                style: Theme.of(context).textTheme.titleLarge,),
                Text("A 6 digit verification pin will send to your\nemail address",
                style: Theme.of(context).textTheme.bodyMedium,),
                verticle(15),
          PinCodeTextField(
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
  animationDuration:const Duration(milliseconds: 300),
  enableActiveFill: true,
  // errorAnimationController: errorController,
  // controller: textEditingController,
  onCompleted: (v) {
   
  },
 
 
),
                 verticle(16.0),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const   SetPassword();
                  }));
                }, child: const Icon(Icons.arrow_circle_right_outlined)),
                 verticle(30.0),
                 Row(
                  children: [
                  const  Text("Have an account?",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
                    TextButton(onPressed:(){
                      Navigator.pop(context);
                    },child: const Text("Sing In",style: TextStyle(color: Colors.green),))
                  ],
                )
              ],
            ),
          ),),
      ),
    );
  }
}