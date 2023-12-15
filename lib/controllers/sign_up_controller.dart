import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class SignUpController extends GetxController{
  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;
  String _message = '';
  String get message=>_message;
  Future<bool> signup({required String email, required String firstName, required String lastName, required String mobile, required String password}) async {
    _signUpInProgress = true;
  update();
   
   NetworkResponse networkResponse = await NetworkCaller().postRequest(
        Urls.registration,
        body: {
          "email": email,
          "firstName": firstName,
          "lastName": lastName,
          "mobile": mobile,
          "password": password,
          
        },
      );
      _signUpInProgress = false;
      update();
      if (networkResponse.isSuccess) {
        
        update();
          _message= "Account has been created! Please login.";
          return true;
        
      } else {
        _message= "Account creation failed! Try again"; true;
        } return false;
      }
    }
  
