import 'dart:io';
import 'package:flutter/material.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/presentation/shared/camera_handler.dart';
import 'package:racer_app/presentation/shared/gallery_handler.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.register),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null? Text(AppStrings.noProfilePicture) : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()=>_galleryHandler(context),
              child: Icon(Icons.photo),
            ),
            ElevatedButton(
              onPressed:  ()=>_cameraHandler(context), 
              child: Icon(Icons.camera_alt)
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  void _galleryHandler(BuildContext context) async{
    File? image = await GalleryHandler.pickImage(context);
    if(image != null){
      setState(() {
        _image = image;
      });
    }
  }

  void _cameraHandler(BuildContext context) async{
    File? image = await CameraHandler.takePicture(context);
    if(image != null){
      setState(() {
        _image = image;
      });
    }
  }
}