import 'package:flutter/material.dart';

import '../utils/constant/color_constant.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    this.gradient = const LinearGradient(
      colors: [
        ColorConstant.gradient1,
        ColorConstant.gradient2,
        ColorConstant.gradient3,
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    ),
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient!.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
