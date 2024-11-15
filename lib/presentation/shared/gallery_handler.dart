import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:racer_app/core/app_strings.dart';

class GalleryHandler{
  static Future<bool> _requestGalleryPermission() async {
    PermissionStatus status = await Permission.photos.request();
    return status.isGranted;
  }

  static Future<File?> pickImage(BuildContext context) async {
    if (await _requestGalleryPermission()) {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.galleryPermissionsDenied)),
      );
    }
    return null;
  }
}