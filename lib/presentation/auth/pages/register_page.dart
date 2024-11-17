import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/core/custom_navigator.dart';
import 'package:racer_app/presentation/auth/controller/auth_blocs.dart';
import 'package:racer_app/presentation/auth/controller/auth_states.dart';
import 'package:racer_app/presentation/shared/camera_handler.dart';
import 'package:racer_app/presentation/shared/gallery_handler.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? _image;
  bool readyToRegister = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final ageController = TextEditingController();
  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<RegisterBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.register),
        ),
        body: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if(state is RegisterFailureState){
              showDialog(context: context, builder: (context) => AlertDialog(
                  content: Text(state.message),
              ),);
            }
            if(state is RegisterSuccessState){
              CustomNavigator.goToHomepage(context);
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return switch(state){
                RegisterLoadingState() => CircularProgressIndicator(),
                RegisterState() => _printFormulary(context, provider)
              };
            },
          ),
        ));
  }

  Column _printFormulary(BuildContext context, RegisterBloc provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _image == null ? Text(AppStrings.noProfilePicture) : Image.file(_image!, width: 100,),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _galleryHandler(context),
          child: Icon(Icons.photo),
        ),
        ElevatedButton(onPressed: () => _cameraHandler(context), child: Icon(Icons.camera_alt)),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration.collapsed(hintText: AppStrings.emailHint),
          onChanged: (_) => _checkFields(),
          controller: emailController,
        ),
        TextField(
          decoration: InputDecoration.collapsed(hintText: AppStrings.passwordHint),
          onChanged: (_) => _checkFields(),
          controller: passwordController,
        ),
        TextField(
          decoration: InputDecoration.collapsed(hintText: AppStrings.fullNameHint),
          onChanged: (_) => _checkFields(),
          controller: fullNameController,
        ),
        TextField(
          decoration: InputDecoration.collapsed(hintText: AppStrings.userNameHint),
          onChanged: (_) => _checkFields(),
          controller: userNameController,
        ),
        TextField(
          decoration: InputDecoration.collapsed(hintText: AppStrings.ageHint),
          onChanged: (_) => _checkFields(),
          controller: ageController,
        ),
        ElevatedButton(onPressed: readyToRegister? () => _registerCallback(provider): null, child: Text(AppStrings.register))
      ],
    );
  }

  void _registerCallback(RegisterBloc provider) {
    provider.register(emailController.text, passwordController.text, userNameController.text, fullNameController.text,
        int.parse(ageController.text), _image!);
  }

  void _checkFields() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        userNameController.text.isEmpty ||
        fullNameController.text.isEmpty ||
        ageController.text.isEmpty ||
        _image == null) {
      if (readyToRegister) {
        setState(() {
          readyToRegister = false;
        });
      }
    } else {
      setState(() {
        readyToRegister = true;
      });
    }
  }

  void _galleryHandler(BuildContext context) async {
    File? image = await GalleryHandler.pickImage(context);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void _cameraHandler(BuildContext context) async {
    File? image = await CameraHandler.takePicture(context);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }
}
