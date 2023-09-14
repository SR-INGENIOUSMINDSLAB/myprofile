import 'package:flutter/material.dart';
import 'package:myprofile/utils/helper/responsive_utils.dart';
import '../utils/constant/color_constant.dart';

class GradientButton extends StatelessWidget {
  GradientButton(
      {super.key, this.onTap, this.text, this.btnWidth, this.btnHeight});
  void Function()? onTap;

  String? text;
  double? btnWidth;
  double? btnHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              ColorConstant.gradient1,
              ColorConstant.gradient2,
              ColorConstant.gradient3,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(7)),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          fixedSize:
              Size(btnWidth ?? getWidth(395), btnHeight ?? getHeight(40)),
          backgroundColor: Colors.transparent,
          // shadowColor: Colors.transparent,
        ),
        child: Text(
          text ?? 'Sign in',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
