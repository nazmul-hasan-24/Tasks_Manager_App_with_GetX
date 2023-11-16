import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/pin_verifaction.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                Text("Enter your Email Address",
                style: Theme.of(context).textTheme.titleLarge,),
                Text("A 6 digit verification pin will send to your\nemail address",
                style: Theme.of(context).textTheme.bodyMedium,),
                verticle(15),
                TextFormField(
                  decoration: const InputDecoration(
                  hintText: "Email"
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                 verticle(16.0),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const PinVerifactionScreen()));
                }, child: const Text("Verify")),
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