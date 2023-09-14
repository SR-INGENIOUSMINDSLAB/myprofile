import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myprofile/gen/fonts.gen.dart';
import 'package:myprofile/utils/constant/color_constant.dart';
import 'package:myprofile/utils/helper/responsive_utils.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hintText,
      this.controller,
      this.validator,
      this.onChanged,
      this.isNumber = false});
  final bool? isNumber;
  final String hintText;
  TextEditingController? controller;
  String? Function(String?)? validator;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        keyboardType:
            isNumber! ? TextInputType.number : TextInputType.emailAddress,
        inputFormatters: [
          isNumber == true
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter
        ],
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        style: const TextStyle(
            color: Colors.black,
            fontFamily: FontFamily.urbanist,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.urbanist,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorConstant.borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(getRadius(10)),
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: getWidth(20), vertical: getHeight(5)),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(getRadius(10)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorConstant.gradient2,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(getRadius(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorConstant.borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(getRadius(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorConstant.gradient2,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(getRadius(10)),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  PasswordField(
      {super.key, required this.hintText, this.controller, this.validator});
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  RxBool enableBtn = false.obs;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: Obx(
        () => TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          controller: controller,
          obscureText: !enableBtn.value,
          validator: validator,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: FontFamily.urbanist,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                enableBtn.value = !enableBtn.value;
              },
              icon: Obx(() => Icon(
                    enableBtn.value ? Icons.visibility : Icons.visibility_off,
                    color: ColorConstant.gradient2,
                  )),
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.urbanist,
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: getWidth(20), vertical: getHeight(5)),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorConstant.borderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(getRadius(10)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(getRadius(10)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorConstant.gradient2,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(getRadius(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorConstant.gradient2,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(getRadius(10)),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorConstant.borderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(getRadius(10)),
            ),
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
