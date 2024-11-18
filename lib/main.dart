import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:racer_app/core/app_theme.dart';
import 'package:racer_app/dependency_injection.dart';
import 'package:racer_app/presentation/auth/controller/auth_blocs.dart';
import 'package:racer_app/presentation/auth/pages/login_page.dart';

void main() async {
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Racer app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: MaterialTheme.lightScheme(),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (context) => GetIt.instance.get<LoginBloc>(),
          child: LoginPage(),
        ));
  }
}
