part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User user;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this._();
  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}


// abstract class AuthenticationState extends Equatable {
//   const AuthenticationState();

//   @override
//   List<Object> get props => [];

//   @override
//   bool get stringify => true;
// }

// class AuthenticationInitial extends AuthenticationState {}

// class AuthenticationSuccess extends AuthenticationState {
//   final User firebaseUser;

//   const AuthenticationSuccess(this.firebaseUser);

//   @override
//   List<Object> get props => [firebaseUser];
// }

// class AuthenticationFailure extends AuthenticationState {
//   const AuthenticationFailure();
// }
