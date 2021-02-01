import 'dart:async';

import '../../repositories/user_repository.dart';
import '../../utils/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final UserRepository _userRepository;

  LoginFormBloc(this._userRepository) : super(LoginFormState.initial());

  @override
  Stream<LoginFormState> mapEventToState(
    LoginFormEvent event,
  ) async* {
    if (event is LoginEmailChanged) {
      yield _mapLoginEmailChangedToState(event);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(event);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGoogleToState();
    }
  }

  LoginFormState _mapLoginEmailChangedToState(LoginEmailChanged event) {
    return state.update(
      isEmailValid: Validators.isValidEmail(event.email),
    );
  }

  Stream<LoginFormState> _mapLoginWithCredentialsPressedToState(
    LoginWithCredentialsPressed event,
  ) async* {
    yield LoginFormState.loading();
    try {
      await _userRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      yield LoginFormState.success();
    } catch (error) {
      print(error);
      yield LoginFormState.failure();
    }
  }

  Stream<LoginFormState> _mapLoginWithGoogleToState() async* {
    try {
      await _userRepository.signInWithGoogle();
      yield LoginFormState.success();
    } catch (error) {
      print(error);
      yield LoginFormState.failure();
    }
  }
}
