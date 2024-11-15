import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:racer_app/core/app_strings.dart';


class CameraHandler{
  static Future<bool> _requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    return status.isGranted;
  }

  static Future<File?> takePicture(BuildContext context) async {
    if (await _requestCameraPermission()) {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.camerPermissionDenied)),
      );
    }
    return null;
  }

}
