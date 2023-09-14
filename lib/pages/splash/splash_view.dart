import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myprofile/gen/assets.gen.dart';
import 'package:myprofile/gen/fonts.gen.dart';
import 'package:myprofile/widgets/common_image_view.dart';
import '../../utils/helper/responsive_utils.dart';
import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonImageView(
              imagePath: Assets.images.signinBalls.path,
            ),
            const Spacer(),
            Text(
              "My Profile",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.urbanist,
                  fontSize: getFontSize(21)),
            ),
            const Spacer(),
            Text(
              "Splash Screen",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.urbanist,
                  fontSize: getFontSize(14)),
            ),
            Transform.flip(
              flipX: true,
              flipY: true,
              child: CommonImageView(
                imagePath: Assets.images.signinBalls.path,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
