import 'package:get/get.dart';
import 'package:task_manager/controllers/aouth_controller.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class EmailVerifactionController extends GetxController{
  bool _codeSentInProgress = false;
  bool get codeSentInProgress=> _codeSentInProgress;

  String _message = '';
  String get message =>_message;
Future<bool> emailVerification({required String email}) async {
  
      _codeSentInProgress = true;
     update();
      final  response =
          await NetworkCaller().getRequest(Urls.emailVerifaction(email));
   _codeSentInProgress= false;
   update();
      if (response.isSuccess) {
        await AuthController.writeEmailVerification(email);
        await AuthController.initializeUserCache(email);
          _message= ' Verification has been sent!';
          return true;
        }
          else {
            update();
         _message = 'Verification Failed! Try again.'; true;
         
        } return false;
      }
    }
  
