import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/presentation/login/controller/auth_states.dart';
import 'package:racer_app/repository/auth_repo.dart';

class LoginBloc extends Cubit<LoginState>{

  final AuthRepo repo;

  LoginBloc(
    this.repo
  ):super(LoginInitialState());

  void login(String email, String password) async{
    await Future.delayed(Duration.zero);
    emit(LoginLoadingState());
    final response = await repo.login(email, password);

    if(response.value1 != null){
      emit(LoginFailureState(response.value1!));
    }else{
      emit(LoginSuccessState());
    }
  }
}