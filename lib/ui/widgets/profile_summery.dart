import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/edit_profile_screen.dart';

class ProfileSummery extends StatelessWidget {
  const ProfileSummery({
    super.key,
    this.enableOnTab = true,
  });
  final bool enableOnTab;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (enableOnTab) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileScreen(),
            ),
          );
        }
      },
      tileColor: Colors.green,
      leading: const CircleAvatar(
        child: Icon(Icons.person_2_rounded),
      ),
      title: const Text(
        "Rabbil Hasan",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      subtitle: const Text(
        "rubbil@gmail.com",
        style: TextStyle(color: Colors.white),
      ),
      trailing: enableOnTab? const Icon(Icons.arrow_forward): null,
    );
  }
}
