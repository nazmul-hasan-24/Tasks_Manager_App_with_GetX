import 'package:get/get.dart';
import 'package:task_manager/controllers/aouth_controller.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class EditProfileController extends GetxController{
   bool _updateProfileInProgress = false;
   bool get updateProfileInProgress=> _updateProfileInProgress;
   
   String _message = '';
   String get message=>_message;
  Future<void> editProfile({required String email, required String firstName, required String lastName, required String mobile, required String photo}) async {
 
    _updateProfileInProgress = true;
   update();
    String? photoInBase64;
    Map<String, dynamic> inputData = {
      "email":email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "photo": photo,
    };

    final NetworkResponse networkResponse =
        await NetworkCaller().postRequest(Urls.updateProfile, body: inputData);
    _updateProfileInProgress = false;
   update();
    if (networkResponse.isSuccess) {
      AuthController.updateUserInformation(UserModel(
        email:email,
        firstName:firstName,
        lastName: lastName,
        mobile: mobile,
       photo: photoInBase64 ?? AuthController.user?.photo
      ),);
update();
        _message= 'Profile update successful';
      
    } else {
        _message= 'Profile updation failed';
      }
    }
  }
