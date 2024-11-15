import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/presentation/auth/controller/auth_blocs.dart';
import 'package:racer_app/presentation/auth/controller/auth_states.dart';
import 'package:racer_app/presentation/auth/pages/register_page.dart';
import 'package:racer_app/presentation/feed/controller/feed_bloc.dart';
import 'package:racer_app/presentation/feed/pages/feed_page.dart';

class LoginPage extends StatefulWidget {
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
          padding: EdgeInsets.symmetric(vertical: 50),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if(state is LoginFailureState){
                showDialog(context: context, builder: (context) => AlertDialog(
                  content: Text(state.message),
                ),);
              }
              if(state is LoginSuccessState){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (con)=> BlocProvider(
                      create: (c)=>GetIt.instance.get<FeedBloc>(),
                      child: FeedPage(),
                    )
                  )
                );
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return switch(state){
                  LoginLoadingState()=>Center(child: CircularProgressIndicator(),),
                  LoginState()=>_printLoginPage(provider)
                };
              },
            ),
          ),
        ),
      ),
    );
  }

  Column _printLoginPage(LoginBloc provider){
    return Column(
      children: [
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
        TextButton(
            onPressed: ableToLogin ? () => _loginHandler(provider) : null, child: Text(AppStrings.login)),
        TextButton(onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (con)=> BlocProvider(
                create: (c)=>GetIt.instance.get<RegisterBloc>(),
                child: RegisterPage(),
              )
            )
          );
        }, child: Text(AppStrings.register)),
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
