part of 'login_form_bloc.dart';

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class LoginEmailChanged extends LoginFormEvent {
  final String email;

  const LoginEmailChanged({this.email});

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginFormEvent {
  final String password;

  const LoginPasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class LoginWithCredentialsPressed extends LoginFormEvent {
  final String email;
  final String password;

  const LoginWithCredentialsPressed({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginWithGooglePressed extends LoginFormEvent {
  const LoginWithGooglePressed();
}
