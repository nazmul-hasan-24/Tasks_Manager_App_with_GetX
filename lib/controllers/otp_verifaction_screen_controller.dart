import 'package:get/get.dart';
import 'package:task_manager/controllers/aouth_controller.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/screens/set_new_password.dart';

class OtpVerificationScreenController extends GetxController{
  bool _showProgress = false;
  bool get showProgress => _showProgress;
  String _message = '';
  String get message =>_message;
  Future<bool> otpVerification({required String email, required String otp}) async {
      _showProgress = true;
      update();
      final NetworkResponse response =
          await NetworkCaller().getRequest(Urls.otpVerifaction(email, otp));

      if (response.isSuccess  == true) {
       AuthController.initializeUserCache( email);
         _showProgress = false;
         
       update();
       _message = 'OTP Verification Success!';
       Get.to(()=>SetPassword(email: email, otp: otp,));
       return true;
      } else {
          _message= 'OTP Verification Failed! Try again.';
          _showProgress = false;
         update();
        } return false;
      }
    }
