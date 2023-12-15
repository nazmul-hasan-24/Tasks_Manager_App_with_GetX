import 'package:get/get.dart';
import 'package:task_manager/controllers/aouth_controller.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/screens/login_screen.dart';

class SetNewPasswordController extends GetxController{
  bool _loading = false;
  bool get loading => _loading;
   Future<bool> resetPassword({required String email, required String otp, required String password}) async {
    
    _loading = true;
  update();
    NetworkResponse response = await NetworkCaller().postRequest(
      Urls.setPassword,
      body: {
        "email": email,
        "OTP": password,
        "password": password,
      },
 );
    _loading = false;
    
   update();
    if (response.isSuccess) {
      await AuthController.saveUserInformation(response.jsonResponse['token'],
          UserModel.fromJson(response.jsonResponse['data']));
      Get.offAll(()=>const LoginScreen());
      return true;
    } else {
      _loading = false;
      update();
    } return false;
  }
}