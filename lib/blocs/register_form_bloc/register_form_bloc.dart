import 'dart:async';

import 'package:authapp/repositories/user_repository.dart';
import 'package:authapp/utils/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_form_event.dart';
part 'register_form_state.dart';

class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  final UserRepository _userRepository;

  RegisterFormBloc(this._userRepository) : super(RegisterFormState.initial());

  @override
  Stream<RegisterFormState> mapEventToState(
    RegisterFormEvent event,
  ) async* {
    if (event is RegisterFormEmailChanged) {
      yield* _mapRegisterEmailChangeToState(event.email);
    } else if (event is RegisterFormPasswordChanged) {
      yield* _mapRegisterPasswordChangeToState(event.password);
    } else if (event is RegisterFormSubmitted) {
      yield* _mapRegisterSubmittedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<RegisterFormState> _mapRegisterEmailChangeToState(
    String email,
  ) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterFormState> _mapRegisterPasswordChangeToState(
    String password,
  ) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterFormState> _mapRegisterSubmittedToState({
    String email,
    String password,
  }) async* {
    yield RegisterFormState.loading();

    try {
      await _userRepository.signUp(email: email, password: password);
      yield RegisterFormState.success();
    } catch (error) {
      print(error);
      yield RegisterFormState.failure();
    }
  }
}
