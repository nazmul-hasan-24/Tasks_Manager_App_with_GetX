 import 'package:flutter/material.dart';

 void showSnackMessage(BuildContext context, String text, [bool isError = false]) {
  
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: isError? Colors.red:null,
        ),
      );
  
   }