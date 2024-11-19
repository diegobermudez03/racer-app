import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/core/custom_navigator.dart';
import 'package:racer_app/presentation/auth/controller/auth_blocs.dart';
import 'package:racer_app/presentation/auth/controller/auth_states.dart';
import 'package:racer_app/presentation/auth/widgets/custom_button.dart';
import 'package:racer_app/presentation/auth/widgets/custom_text_field.dart';
import 'package:racer_app/presentation/auth/widgets/profile_picture_display.dart';
import 'package:racer_app/shared/camera_handler.dart';
import 'package:racer_app/shared/gallery_handler.dart';
import 'package:racer_app/utilities/custom_dialogs.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({
    super.key
  });

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
  final heightController = TextEditingController();
  final weightController = TextEditingController();

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
              CustomDialogs.showFailureDialog(context, state.message);
            }
            if(state is RegisterSuccessState){
              CustomNavigator.goToHomepage(context);
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return switch(state){
                RegisterLoadingState() => const Center(child: CircularProgressIndicator()),
                RegisterState() => _printFormulary(context, provider)
              };
            },
          ),
        ));
  }

  Widget _printFormulary(BuildContext context, RegisterBloc provider) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: ProfilePictureDisplay(image: _image),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _galleryHandler(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primaryContainer,
                  foregroundColor: colorScheme.onPrimaryContainer,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.photo),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => _cameraHandler(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primaryContainer,
                  foregroundColor: colorScheme.onPrimaryContainer,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.camera_alt),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            labelText: AppStrings.emailHint,
            controller: emailController,
            onChanged: (_) => _checkFields(),
          ),
          CustomTextField(
            labelText: AppStrings.passwordHint,
            controller: passwordController,
            obscureText: true,
            onChanged: (_) => _checkFields(),
          ),
          CustomTextField(
            labelText: AppStrings.fullNameHint,
            controller: fullNameController,
            onChanged: (_) => _checkFields(),
          ),
          CustomTextField(
            labelText: AppStrings.userNameHint,
            controller: userNameController,
            onChanged: (_) => _checkFields(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    labelText: AppStrings.ageHint,
                    controller: ageController,
                    onChanged: (_) => _checkFields(),
                    keyboardType: TextInputType.number,
                    horizontalPadding: 2,
                    formatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    labelText: AppStrings.heightHint,
                    controller: heightController,
                    onChanged: (_) => _checkFields(),
                    horizontalPadding: 2,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    formatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    labelText: AppStrings.weightHint,
                    controller: weightController,
                    onChanged: (_) => _checkFields(),
                    horizontalPadding: 2,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    formatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: CustomButton(
              text: AppStrings.register,
              onPressed: readyToRegister ? () => _registerCallback(provider) : null,
            ),
          ),
        ],
      ),
    );
  }

  void _registerCallback(RegisterBloc provider) {
    provider.register(emailController.text, passwordController.text, userNameController.text, fullNameController.text,
        int.parse(ageController.text), 
        double.parse(heightController.text), 
        double.parse(weightController.text), 
        _image!);
  }

  void _checkFields() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        userNameController.text.isEmpty ||
        fullNameController.text.isEmpty ||
        ageController.text.isEmpty ||
        heightController.text.isEmpty ||
        weightController.text.isEmpty ||
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
    _checkFields();
  }

  void _cameraHandler(BuildContext context) async {
    File? image = await CameraHandler.takePicture(context);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
    _checkFields();
  }
}
