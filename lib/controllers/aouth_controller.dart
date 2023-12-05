import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/user_model.dart';

class AuthController {
  static String? token;
  static UserModel? user;
  static String? e;

  static Future<void> saveUserInformation(String t, UserModel model , {String? email}) async {
    print("Token $t");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', t);
    await sharedPreferences.setString('user', jsonEncode(model.toJson()));
    await sharedPreferences.setString('email', email.toString());
    token = t;
    user = model;
    e= email;
  }

  

  static Future<void> updateUserInformation(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', jsonEncode(model.toJson()));

    user = model;
  }

  static Future<void> initializeUserCache( [String? email,  String? otp]) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    user = UserModel.fromJson(
        jsonDecode(sharedPreferences.getString('user') ?? '{}'));
  }

  static Future<bool> checkAuthState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('token')) {
      await initializeUserCache();
      return true;
    }
    return false;
  }

static Future<void> writeEmailVerification(email) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("email", email);
  }

  static Future<void> otpVerifaction(String otp) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString('otp', otp);
  }


  

  static Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
  }
}
