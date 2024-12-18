import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/core/custom_navigator.dart';
import 'package:racer_app/presentation/auth/controller/auth_blocs.dart';
import 'package:racer_app/presentation/auth/controller/auth_states.dart';
import 'package:racer_app/presentation/auth/widgets/custom_button.dart';
import 'package:racer_app/presentation/auth/widgets/custom_text_field.dart';
import 'package:racer_app/utilities/custom_dialogs.dart';


class LoginPage extends StatefulWidget {

  LoginPage({
    super.key
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool ableToLogin = false;

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if(state is LoginFailureState){
                CustomDialogs.showFailureDialog(context, state.message);
              }
              if(state is LoginSuccessState){
                CustomNavigator.goToHomepage(context);
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return switch(state){
                  LoginLoadingState()=> const Center(child: CircularProgressIndicator(),),
                  LoginState()=>_printLoginPage(provider, context)
                };
              },
            ),
          ),
        ),
      ),
    );
  }

  Column _printLoginPage(LoginBloc provider, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
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
      CustomButton(
        text: AppStrings.login,
        onPressed: ableToLogin ? () => _loginHandler(provider) : null,
      ),
      CustomButton(
        text: AppStrings.register,
        onPressed: () => CustomNavigator.goToRegisterPage(context),
        isPrimary: false,
      ),
    ],
  );
}

  void _checkFields() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() {
        ableToLogin = true;
      });
    } else if (ableToLogin) {
      setState(() {
        ableToLogin = false;
      });
    }
  }

  void _loginHandler(LoginBloc provider) {
    provider.login(emailController.text, passwordController.text);
  }
}
