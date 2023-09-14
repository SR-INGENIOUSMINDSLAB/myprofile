import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myprofile/models/user_model.dart';
import 'package:myprofile/services/shared_pref.dart';
import 'package:myprofile/utils/helper/methods.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/constant/app_constants.dart';
import '../../../widgets/custom_toast.dart';

class LoginController extends GetxController {
  // Observable boolean for managing checkbox state

  RxBool checkboxValue = false.obs;
  // Controllers for email and password input fields

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // Function to retrieve and set remember data if available

  getRememberData() async {
    int? shouldRemeber = await SharedPref.readInt(shouldRemember);
    if (shouldRemeber == 1) {
      checkboxValue.value = true;
      emailController.text = await SharedPref.readString(email);
      passwordController.text = await SharedPref.readString(password);
    } else {
      checkboxValue.value = false;
    }
  }
  // Function to handle the login button click

  onLoginClick() async {
    UserModel? user = await readDataFromSharedPreference();
    if (user != null) {
      if (emailController.text.toLowerCase().trim() ==
              user.email?.toLowerCase().trim() &&
          passwordController.text.trim() == user.name?.trim()) {
        if (checkboxValue.value) {
          SharedPref.saveString(
              email, emailController.text.toLowerCase().trim());
          SharedPref.saveString(password, passwordController.text);
          SharedPref.saveInt(shouldRemember, 1);
          SharedPref.saveInt(login, 1);
        } else {
          SharedPref.saveInt(shouldRemember, 0);
        }
        SharedPref.saveInt(login, 1);
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        ShowMToast().errorToast(Get.context!,
            message: "Please Check your email id and password",
            alignment: Alignment.bottomCenter);
      }
    }
  }
  // Function to set default login data if no user data is available

  getDefaultLoginData() async {
    UserModel? user = await readDataFromSharedPreference();
    if (user == null) {
      var jsonData = UserModel(
          name: "Developer",
          email: "dev@demo.com",
          expereince: "5",
          skills: [
            "Flutter",
            "Dart",
            "GetX",
            "BloC",
            "Firebase",
            "Stripe",
            "Agora",
            "Twillio",
            "Hive",
            "Google Map API",
          ]).toJson();
      saveDataToSharedPreference(jsonData);
    } else {}
  }

  // Function to handle checkbox value changes

  onChangeCheckBox(value) {
    checkboxValue.value = value;
  }

  @override
  void onInit() {
    getRememberData();
    getDefaultLoginData();
    super.onInit();
  }

  @override
  void onClose() {
    checkboxValue(false);
  }
}
