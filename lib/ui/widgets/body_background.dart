import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BodyBackGround extends StatelessWidget {
  final Widget child;
  const BodyBackGround({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
        SvgPicture.asset(
          "assets/images/background.svg",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          
        ),
        child
      ]);
  }
}