import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const ProfileSummery(
              enableOnTab: false,
            ),
            Expanded(
              child: BodyBackGround(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticle(60),
                        Text(
                          "Update Profile",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        verticle(20),
                        imagePicker(),
                        verticle(16),
                        TextFormField(
                          decoration: const InputDecoration(hintText: "Email"),
                        ),
                        verticle(16),
                        TextFormField(
                          decoration:
                              const InputDecoration(hintText: "First Name"),
                        ),
                        verticle(16),
                        TextFormField(
                          decoration:
                              const InputDecoration(hintText: "Last Name"),
                        ),
                        verticle(16),
                        TextFormField(
                          decoration: const InputDecoration(hintText: "Mobile"),
                        ),
                        verticle(16),
                        TextFormField(
                          decoration:
                              const InputDecoration(hintText: "Password"),
                          obscureText: true,
                        ),
                        verticle(16),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Icon(Icons.arrow_circle_right_outlined))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container imagePicker() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(10))),
            child: const Text("Photo"),
          ),
        ),
        Expanded(flex: 3, child: Container()),
      ]),
    );
  }
}
