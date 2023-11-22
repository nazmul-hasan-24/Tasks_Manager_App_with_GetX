import 'package:flutter/material.dart';
import 'package:task_manager/controllers/aouth_controller.dart';
import 'package:task_manager/ui/screens/edit_profile_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';

class ProfileSummery extends StatefulWidget {
  const ProfileSummery({
    super.key,
    this.enableOnTab = true,
  });
  final bool enableOnTab;

  @override
  State<ProfileSummery> createState() => _ProfileSummeryState();
}

class _ProfileSummeryState extends State<ProfileSummery> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.enableOnTab) {
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
      title: Text(
        fullName,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        AuthController.user?.email ?? '',
        style: const TextStyle(
            color: Colors.white, overflow: TextOverflow.ellipsis),
      ),
      trailing: widget.enableOnTab
          ? IconButton(
              onPressed: () async {
                await AuthController.clearAuthData();
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SplashScreen()),
                      (route) => false);
                }
              },
              icon: const Icon(Icons.logout_rounded))
          : null,
    );
  }

  String get fullName{
    return '${AuthController.user?.firstName??''} ${AuthController.user?.lastName??""}';
  }
}
