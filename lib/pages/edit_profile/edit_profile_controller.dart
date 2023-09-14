import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myprofile/pages/home/home_controller.dart';
import 'package:myprofile/routes/app_routes.dart';

import '../../models/user_model.dart';
import '../../utils/helper/methods.dart';
import '../../widgets/custom_toast.dart';

class EditProfileController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
// TextEditingController for Edit Profile functionality
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  TextEditingController workController = TextEditingController();
  RxString currentPath = ''.obs; // Observable string for avatar image path
  RxBool isImageEdited =
      false.obs; // Observable boolean for image editing state
  @override
  void onInit() {
    readData();
    retriveImage();
    super.onInit();
  }
  // Function to read user data from shared preferences and populate the form

  readData() async {
    UserModel? user = await readDataFromSharedPreference();
    if (user != null) {
      nameController.text = user.name!;
      emailController.text = user.email!;
      skillController.text = user.skills!.join(",");
      workController.text = user.expereince!;
    }
  }
  // Function to save user data to shared preferences and update the profile

  saveData() {
    var jsonData = UserModel(
      name: nameController.text,
      email: emailController.text,
      expereince: workController.text,
      skills: skillController.text.split(","),
      avatarPath: currentPath.value,
    ).toJson();
    saveDataToSharedPreference(jsonData);

    // Save the image to local storage if an image is edited

    if (currentPath.value.isNotEmpty) {
      saveImageInLocalStorage();
    }
    // Refresh dashboard data and navigate to the home screen

    final controller = Get.put(HomeController());
    controller.getDashBoardData();
    Get.offAllNamed(AppRoutes.homeScreen);
    // Show a success toast message

    ShowMToast().successToast(Get.context!,
        message: "Profile updated Successfully",
        alignment: Alignment.bottomCenter);
  }
  // Function to check if there are unsaved changes and show a confirmation popup

  Future<bool> shouldShowPopup() async {
    UserModel? user = await readDataFromSharedPreference();

    if (currentPath.value != user?.avatarPath ||
        nameController.text != user!.name! ||
        emailController.text != user.email! ||
        workController.text != user.expereince ||
        skillController.text != user.skills!.join(",")) {
      showAlertDialog(
          "Changes Not Saved!", "Its Seems you forget to saved Changes", (p0) {
        if (p0) {
          Get.back();
        } else {
          return false;
        }
      },
          isCancel: true,
          isSuccess: true,
          strCancel: "Okay",
          strSuccess: "Discard Changes");
      return true;
    } else {
      return true;
    }
  }
  // Function to save the edited image to local storage

  saveImageInLocalStorage() async {
    String? imageFile = await saveImage(
      File(
        currentPath.value,
      ),
    );

    retriveImage();
  }

  RxBool isImageLoading = false.obs;
  // Function to retrieve the user's avatar image

  retriveImage() async {
    isImageLoading(true);
    String? imageFromFile = await retrieveImage();
    if (imageFromFile != null) {
      currentPath.value = imageFromFile;
    }
    isImageLoading(false);
  }
}
