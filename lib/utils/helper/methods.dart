import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myprofile/routes/app_routes.dart';
import 'package:myprofile/utils/constant/app_constants.dart';
import 'package:myprofile/widgets/custom_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

// Function to show an alert dialog with customizable options
void showAlertDialog(
  String title,
  String msg,
  Function(bool) callBack, {
  bool isCancel = false,
  bool isSuccess = false,
  String strCancel = "Cancel",
  String strSuccess = "Ok",
}) {
  if (GetPlatform.isIOS) {
    // Show Cupertino-style dialog for iOS platforms
    showCupertinoDialog(
      context: Get.overlayContext!,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              fontFamily: 'arial',
            ),
          ),
          content: Text(
            msg,
            style: const TextStyle(
              fontFamily: 'arial',
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            if (isCancel)
              CupertinoDialogAction(
                child: Text(
                  strCancel,
                  style: const TextStyle(
                    fontFamily: 'arial',
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  callBack(false);
                  Navigator.pop(context);
                },
              ),
            if (isSuccess)
              CupertinoDialogAction(
                child: Text(
                  strSuccess,
                  style: const TextStyle(
                    fontFamily: 'arial',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  callBack(true);
                  Navigator.pop(context);
                },
              ),
          ],
        );
      },
    );
  } else {
    // Show Material-style dialog for other platforms
    Get.dialog(
      AlertDialog(
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w600,
            fontFamily: 'arial',
          ),
        ),
        content: Text(
          msg,
          style: const TextStyle(
            fontFamily: 'arial',
            fontSize: 16,
          ),
        ),
        actionsPadding: const EdgeInsets.all(2),
        actions: [
          if (isCancel)
            TextButton(
              onPressed: () {
                callBack(false);
                Get.back();
              },
              child: Text(
                strCancel,
                style: const TextStyle(
                  fontFamily: 'arial',
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
          if (isSuccess)
            TextButton(
              onPressed: () {
                callBack(true);
                Get.back();
              },
              child: Text(
                strSuccess,
                style: const TextStyle(
                  fontFamily: 'arial',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Function to perform logout and remove login state
onPresslogout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove(login);
  Get.offAllNamed(AppRoutes.loginScreen);
}

// Function to save user data to shared preferences
saveDataToSharedPreference(data) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String user = jsonEncode(UserModel.fromJson(data));
  pref.setString('userData', user);
}

// Function to read user data from shared preferences
Future<UserModel?> readDataFromSharedPreference() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? data = pref.getString('userData');
  if (data != null) {
    Map<String, dynamic> json = jsonDecode(data);
    var user = UserModel.fromJson(json);
    return user;
  } else {
    return null;
  }
}

// Function to save an image to local storage
Future<String?> saveImage(File imageFile) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/user_selected_image.jpg';

    await imageFile.copy(imagePath);

    final file = File(imagePath);
    final fileLength = await file.length();
    print("Saved image file length: $fileLength");

    return imagePath;
  } catch (e) {
    ShowMToast().errorToast(Get.context!,
        message: "Error saving the image: $e",
        alignment: Alignment.bottomCenter);

    return null;
  }
}

// Function to retrieve an image from local storage
Future<String?> retrieveImage() async {
  final directory = await getApplicationDocumentsDirectory();
  final imagePath = '${directory.path}/user_selected_image.jpg';

  final file = File(imagePath);

  if (await file.exists()) {
    var path = await file.length();
    print("Retrieved image file length: $path");
    return imagePath;
  } else {
    return null;
  }
}
