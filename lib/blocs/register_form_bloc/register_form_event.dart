part of 'register_form_bloc.dart';

abstract class RegisterFormEvent extends Equatable {
  const RegisterFormEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class RegisterFormEmailChanged extends RegisterFormEvent {
  final String email;

  const RegisterFormEmailChanged({this.email});

  @override
  List<Object> get props => [email];
}

class RegisterFormPasswordChanged extends RegisterFormEvent {
  final String password;

  const RegisterFormPasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class RegisterFormSubmitted extends RegisterFormEvent {
  final String email;
  final String password;

  const RegisterFormSubmitted({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
