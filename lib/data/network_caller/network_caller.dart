import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;
import 'package:http/http.dart' show get;


import 'package:task_manager/app.dart';
import 'package:task_manager/controllers/aouth_controller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/ui/screens/login_screen.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false}) async {
    try {
      log(url);
      log(body.toString());
print('This is token: ${AuthController.token}');
      final Response response =
          await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'Application/json',
        'token': AuthController.token.toString(),
      });
      
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if(response.statusCode == 401){
        if( isLogin){
        backToLogin();}
         return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
      
      else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

   Future<NetworkResponse> getRequest(String url,
      ) async {
    try {
   
      final Response response =
          await get(Uri.parse(url), headers: {
        'Content-type': 'Application/json',
        'token': AuthController.token.toString(),
      });
      
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if(response.statusCode == 401){
       
        backToLogin();
         return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
      
      else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

Future<NetworkResponse> emailVerifyRequest( String url) async{
 Response response = await get(Uri.parse(url), headers: {
  'Content-Type' : 'Application/json'
 });
 print(response.statusCode);
 print(response.body);
 print(response.headers);
 return NetworkResponse(isSuccess: true);
}

  void backToLogin() {
    Navigator.pushAndRemoveUntil(
        TaskManager.navigationKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }
}
