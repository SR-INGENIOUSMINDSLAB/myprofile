import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myprofile/utils/constant/color_constant.dart';

// Enum to represent the media options (camera or gallery)
enum MediaOption { camera, gallery }

class WidgetHelper {
  // Show a modal dialog to choose between camera and gallery options
  void showMediaOptionDialog(
      BuildContext context, Function(MediaOption, CroppedFile) callBack) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext cont) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () async {
                  _openCamera(callBack); // Open the camera option
                  Get.back();
                },
                child: const Text(
                  'Camera',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  _openGallery(callBack); // Open the gallery option
                  Get.back();
                },
                child: const Text(
                  'Gallery',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          );
        });
  }

  // Open the gallery option to pick an image
  void _openGallery(Function(MediaOption p1, CroppedFile p2) callBack) async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxHeight: 480,
        maxWidth: 640);
    if (pickedFile != null) {
      _cropImage(pickedFile, MediaOption.gallery, callBack);
    }
  }

  // Open the camera option to capture an image
  void _openCamera(Function(MediaOption p1, CroppedFile p2) callBack) async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxHeight: 480,
        maxWidth: 640);
    if (pickedFile != null) {
      _cropImage(pickedFile, MediaOption.camera, callBack);
    }
  }

  // Crop the selected image using the ImageCropper package
  Future<void> _cropImage(XFile pickedFile, MediaOption camera,
      Function(MediaOption p1, CroppedFile p2) callBack) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      aspectRatio: const CropAspectRatio(ratioX: 512, ratioY: 512),
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Your Image',
            toolbarColor: ColorConstant.gradient1,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop Your Image',
        ),
        WebUiSettings(
          context: Get.context!,
          presentStyle: CropperPresentStyle.dialog,
          boundary: const CroppieBoundary(
            width: 520,
            height: 520,
          ),
          viewPort:
              const CroppieViewPort(width: 480, height: 480, type: 'circle'),
          enableExif: true,
          enableZoom: true,
          showZoomer: true,
        ),
      ],
    );
    if (croppedFile != null) {
      callBack(MediaOption.camera, croppedFile);
    }
  }
}
