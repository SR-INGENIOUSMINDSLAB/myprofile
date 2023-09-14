import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myprofile/gen/fonts.gen.dart';
import 'package:myprofile/utils/constant/color_constant.dart';
import 'package:myprofile/utils/helper/responsive_utils.dart';

import '../../../gen/assets.gen.dart';
import '../../../utils/helper/validators.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/login_field.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: FontFamily.urbanist,
                          fontWeight: FontWeight.bold,
                          fontSize: getFontSize(24),
                        ),
                      ),
                      const SizedBox(height: 50),
                      CustomTextField(
                        controller: controller.emailController,
                        onChanged: (value) {},
                        validator: (value) {
                          return Validator.validateEmails(value!);
                        },
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 15),
                      PasswordField(
                        controller: controller.passwordController,
                        hintText: 'Password',
                        validator: (value) {
                          return Validator.validatePassword(value!);
                        },
                      ),
                      SizedBox(
                        height: getHeight(10),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 400,
                        ),
                        child: ListTileTheme(
                          horizontalTitleGap: 0.0,
                          dense: true,
                          enableFeedback: true,
                          contentPadding: const EdgeInsets.all(0),
                          child: Obx(() => CheckboxListTile(
                                activeColor: ColorConstant.gradient1,
                                visualDensity: const VisualDensity(
                                    horizontal: -2, vertical: -4),
                                contentPadding: EdgeInsets.zero,
                                enableFeedback: true,
                                title: Text(
                                  'Remember Me?',
                                  style: TextStyle(
                                      fontSize: getFontSize(15),
                                      fontWeight: FontWeight.w400),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                dense: true,
                                value: controller.checkboxValue.value,
                                onChanged: (bool? value) {
                                  controller.onChangeCheckBox(value);
                                },
                              )),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GradientButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.onLoginClick();
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
    );
  }
}
