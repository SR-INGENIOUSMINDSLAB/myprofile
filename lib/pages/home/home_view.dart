import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myprofile/gen/fonts.gen.dart';
import 'package:myprofile/routes/app_routes.dart';
import 'package:myprofile/utils/constant/color_constant.dart';
import 'package:myprofile/utils/helper/methods.dart';
import 'package:myprofile/utils/helper/responsive_utils.dart';
import 'package:myprofile/widgets/common_image_view.dart';

import '../../../gen/assets.gen.dart';
import '../../../widgets/gradient_button.dart';
import '../../utils/constant/app_constants.dart';
import '../../widgets/gradient_text.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                showAlertDialog(
                  "Are you sure?",
                  "Are you sure to logout?",
                  (p0) {
                    if (p0 == true) {
                      onPresslogout();
                    }
                  },
                  isCancel: true,
                  isSuccess: true,
                  strCancel: "No",
                  strSuccess: "Yes",
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: getWidth(10)),
                child: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: Obx(
              () => controller.isDataLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: SizedBox(
                        height: Get.height,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: getWidth(20)),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: getHeight(80),
                                  ),
                                  Text(
                                    controller.greeting(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: FontFamily.urbanist,
                                      fontWeight: FontWeight.bold,
                                      fontSize: getFontSize(24),
                                    ),
                                  ),
                                  SizedBox(height: getHeight(20)),
                                  Center(
                                    child: ClipOval(
                                      child: CommonImageView(
                                        imagePath: Assets.images.avatar.path,
                                        file: File(
                                            controller.userModel.avatarPath ??
                                                ''),
                                        height: getHeight(90),
                                        width: getHeight(90),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: getHeight(20)),
                                  HomeScreenListTile(
                                    title: "Name : ",
                                    subTitle: controller.userModel.name ?? "",
                                  ),
                                  HomeScreenListTile(
                                    title: "Email : ",
                                    subTitle: controller.userModel.email ?? "",
                                  ),
                                  const HomeScreenListTile(
                                    title: "Skills : ",
                                    listType: ListTypeEnum.SKILLS,
                                    subTitle: "",
                                  ),
                                  HomeScreenListTile(
                                    title: "Work Expereince : ",
                                    subTitle:
                                        "${controller.userModel.expereince ?? ""} + Years",
                                  ),
                                  SizedBox(height: getHeight(20)),
                                  GradientButton(
                                    text: "Edit Profile",
                                    onTap: () {
                                      Get.toNamed(AppRoutes.editScreen);
                                    },
                                  ),
                                ],
                              ),
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                      Assets.images.signinBalls.path)),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ));
  }
}

class HomeScreenListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final ListTypeEnum? listType;
  const HomeScreenListTile({
    super.key,
    required this.title,
    required this.subTitle,
    this.listType = ListTypeEnum.TEXT,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          title,
          style: TextStyle(
            fontSize: getFontSize(18),
            fontFamily: FontFamily.urbanist,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: getHeight(5),
        ),
        Visibility(
          visible: ListTypeEnum.TEXT == listType,
          child: Text(
            subTitle,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: getFontSize(20)),
          ),
        ),
        Visibility(
          visible: ListTypeEnum.SKILLS == listType,
          child: Wrap(
            children: buildGradientChips(),
          ),
        ),
        SizedBox(
          height: getHeight(10),
        )
      ],
    );
  }
}

List<Widget> buildGradientChips() {
  final controller = Get.put(HomeController());

  return controller.userModel.skills!.map((chipData) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: getWidth(4), vertical: getHeight(5)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getRadius(14)),
          gradient: const LinearGradient(colors: [
            ColorConstant.gradient1,
            ColorConstant.gradient2,
            ColorConstant.gradient3
          ])),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getWidth(20), vertical: getHeight(8)),
        child: Text(
          chipData.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }).toList();
}
