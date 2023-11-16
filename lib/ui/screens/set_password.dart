import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/sign_up_page.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

class SetPassword extends StatelessWidget {
  const SetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackGround(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                   Text("Set Password", 
                  style: Theme.of(context).textTheme.titleLarge,),
                   const Text("Minimum length password 8 character with\n Latter and number combination",
                      
                         ),
                  verticle(20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Password",
                     
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  verticle(20.0),
                  TextFormField(
                    obscureText: true,
                    
                    decoration: const InputDecoration(
                      hintText: "Confirm Password",
                     
                    ),
                  ),
                  verticle(16.0),
                  ElevatedButton(
                      onPressed: () {},
                      
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll<EdgeInsetsGeometry> (EdgeInsets.symmetric(vertical: 15.0))
                      ),
                      child: const Text("Confirm")
                      ),
                  verticle(48),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an account?"),
                      TextButton(
                      
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignupPage()));
                    }, child: const Text("Sign In",
                    style: TextStyle( color: Colors.green),) , 
                    ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
