 import 'package:flutter/material.dart';

 void showMessage(BuildContext context, String text, [bool isError = false]) {
  
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: isError? Colors.red:null,
        ),
      );
  
   }