import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myprofile/utils/helper/widget_helper.dart';
import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import '../../utils/helper/responsive_utils.dart';
import '../../utils/helper/validators.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_toast.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/login_field.dart';
import 'edit_profile_controller.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: WillPopScope(
        onWillPop: () async {
          return controller.shouldShowPopup();
        },
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                height: Get.height,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: getHeight(50),
                            ),
                            Center(
                              child: Text(
                                "Edit Profile",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: FontFamily.urbanist,
                                  fontWeight: FontWeight.bold,
                                  fontSize: getFontSize(24),
                                ),
                              ),
                            ),
                            SizedBox(height: getHeight(20)),
                            GestureDetector(
                              onTap: () {
                                WidgetHelper().showMediaOptionDialog(context,
                                    (p0, p1) {
                                  controller.currentPath.value = p1.path;
                                  controller.isImageEdited(true);
                                });
                              },
                              child: Center(
                                child: ClipOval(
                                  child: Stack(
                                    children: [
                                      Obx(
                                        () => controller.isImageLoading.value
                                            ? const CircularProgressIndicator()
                                            : Obx(
                                                () => CommonImageView(
                                                  file: File(controller
                                                      .currentPath.value),
                                                  imagePath:
                                                      Assets.images.avatar.path,
                                                  height: getHeight(90),
                                                  width: getHeight(90),
                                                ),
                                              ),
                                      ),
                                      Obx(() => Visibility(
                                            visible:
                                                !controller.isImageEdited.value,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.2)),
                                              height: getHeight(90),
                                              width: getHeight(90),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: getHeight(20)),
                            CustomTextField(
                              controller: controller.nameController,
                              hintText: "Name",
                              validator: (value) {
                                return Validator.validateName(value!);
                              },
                            ),
                            SizedBox(height: getHeight(10)),
                            CustomTextField(
                              controller: controller.emailController,
                              hintText: "Email",
                              validator: (value) {
                                return Validator.validateEmails(value!);
                              },
                            ),
                            SizedBox(height: getHeight(10)),
                            CustomTextField(
                              controller: controller.skillController,
                              hintText: "Skills",
                            ),
                            SizedBox(height: getHeight(10)),
                            CustomTextField(
                              controller: controller.workController,
                              isNumber: true,
                              hintText: "Work Expereince : ",
                              validator: (value) {
                                return Validator.validateExp(value!);
                              },
                            ),
                            SizedBox(height: getHeight(20)),
                            GradientButton(
                              text: "Save",
                              onTap: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  if (controller.skillController.text.isEmpty) {
                                    ShowMToast().errorToast(Get.context!,
                                        message: "Please add your skills",
                                        alignment: Alignment.bottomCenter);
                                  } else {
                                    controller.saveData();
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(Assets.images.signinBalls.path)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
