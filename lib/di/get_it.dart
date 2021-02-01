import 'package:authapp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:authapp/blocs/login_form_bloc/login_form_bloc.dart';
import 'package:authapp/blocs/register_form_bloc/register_form_bloc.dart';
import 'package:authapp/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance
      .registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getItInstance
      .registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.standard());

  getItInstance.registerLazySingleton(() => UserRepository(
        firebaseAuth: getItInstance(),
        googleSignIn: getItInstance(),
      ));

  getItInstance.registerFactory<AuthenticationBloc>(
      () => AuthenticationBloc(userRepository: getItInstance()));
  getItInstance
      .registerFactory<LoginFormBloc>(() => LoginFormBloc(getItInstance()));
  getItInstance.registerFactory<RegisterFormBloc>(
      () => RegisterFormBloc(getItInstance()));
}
