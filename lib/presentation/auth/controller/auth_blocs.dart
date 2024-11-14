import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racer_app/presentation/auth/controller/auth_states.dart';
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

class RegisterBloc extends Cubit<RegisterState>{

  final AuthRepo repo;

  RegisterBloc(
    this.repo
  ):super(RegisterInitialState());

  void register(String email, String password, String userName, )async{

  }
}