import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' show XFile ;
import 'package:image_picker/image_picker.dart' show ImagePicker ;
import 'package:image_picker/image_picker.dart' show ImageSource ;
import 'package:task_manager/controllers/aouth_controller.dart';
import 'package:task_manager/controllers/edit_profile_controller.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/profile_summery.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';
import 'package:task_manager/ui/widgets/verticle.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EditProfileController editProfileController = Get.find<EditProfileController>();

  XFile? photo;
  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.user?.email ?? '';
    _firstTEController.text = AuthController.user?.firstName ?? '';
    _lastNameTEController.text = AuthController.user?.lastName ?? '';
    _mobileTEController.text = AuthController.user?.mobile ?? '';
    editProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const ProfileSummery(
              enableOnTab: false,
            ),
            Expanded(
              child: BodyBackGround(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticle(60),
                          Text(
                            "Update Profile",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          verticle(20),
                          imagePicker(),
                          verticle(16),
                          TextFormField(
                            controller: _emailTEController,
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Enter Email";
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: "Email"),
                          ),
                          verticle(16),
                          TextFormField(
                            controller: _firstTEController,
                            validator: (String? value) {
                              if (value!.trim().isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                return "Enter correct name";
                              } else {}
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: "First Name"),
                          ),
                          verticle(16),
                          TextFormField(
                            controller: _lastNameTEController,
                            validator: (String? value) {
                              if (value!.trim().isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                return "Enter correct name";
                              } else {}
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: "Last Name"),
                          ),
                          verticle(16),
                          TextFormField(
                            controller: _mobileTEController,
                            validator: (String? value) {
                              if (value!.length == 11) {
                              } else {
                                return "Number must be 11 digits: $value";
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: "Mobile"),
                          ),
                          verticle(16),
                          TextFormField(
                            controller: _passwordTEController,
                            // validator: (String? value) {
                            //   if (value?.trim().isEmpty ?? true) {
                            //     return "Enter valid password";
                            //   }
                            //   if (value!.length < 6) {
                            //     return "Enter password more then 6 digits";
                            //   }

                            //   return null;
                            // },
                            decoration: const InputDecoration(
                                hintText: "Password(Optional)"),
                            obscureText: true,
                          ),
                          verticle(16),
                          GetBuilder<EditProfileController>(
                            builder: (editProfileController) {
                              return Visibility(
                              visible:editProfileController.updateProfileInProgress == false,
                              replacement: const Center(
                                child: Center(child: CircularProgressIndicator()),
                              ),
                              child: ElevatedButton(
                                onPressed: editProfile,
                                child:
                                    const Icon(Icons.arrow_circle_right_outlined),
                              ),
                            );
                            },
                          ),
                          verticle(25),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
 
  Future<void> editProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
   
    String? photoInBase64;
    Map<String, dynamic> inputData = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "photo": '',
    };
    if (_passwordTEController.text.isNotEmpty) {
      inputData['password'] = _passwordTEController.text;
    }

if(photo != null){
  List<int> imageBytes = await photo!.readAsBytes();
  String photoInBase64 = base64Encode(imageBytes);
  inputData['photo'] = photoInBase64;
}
    final NetworkResponse networkResponse =
        await NetworkCaller().postRequest(Urls.updateProfile, body: inputData);
    if (networkResponse.isSuccess) {
      AuthController.updateUserInformation(UserModel(
        email: _emailTEController.text.trim(),
        firstName: _firstTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        mobile: _mobileTEController.text.trim(),
       photo: photoInBase64 ?? AuthController.user?.photo
      ));

      if (mounted) {
        showSnackMessage(context, editProfileController.message);
      }
    } else {
      if (mounted) {
        showSnackMessage(context, editProfileController.message);
      }
    }
  }

  Container imagePicker() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Container(
            
            alignment: Alignment.center,
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(10))),
            child: const Text("Photo"),
          ),
        ),
        Expanded(
            flex: 3,
            child: InkWell(
              onTap: () async{
                print('Photo');
                final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
                if(image!=null){
                  photo =image;
                  if(mounted){
                    setState(() {});
                  }
                }
              },
              child: Container(
              padding: const EdgeInsets.only(left: 20),
                child: Visibility(
                  visible: photo == null,
                  replacement: Text(photo?.name?? ''),
                  child: const Text("Select a photo"),
                ),
              ),
            )),
      ]),
    );
  }
}
