abstract class LoginState{}

class LoginInitialState implements LoginState{}

class LoginLoadingState implements LoginState{}

class LoginSuccessState implements LoginState{}

class LoginFailureState implements LoginState{
  final String message;

  LoginFailureState(this.message);
}


////////////////////////////////////////////////////////////////////////


abstract class RegisterState{}

class RegisterInitialState implements RegisterState{}

class RegisterLoadingState implements RegisterState{}

class RegisterSuccessState implements RegisterState{}

class RegisterFailureState implements RegisterState{
  final String message;
  RegisterFailureState(this.message);
}

