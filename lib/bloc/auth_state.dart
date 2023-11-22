part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

final class AuthSuccessState extends AuthState {
  final User user;

  AuthSuccessState(this.user);
}

final class AuthNotLoggedInState extends AuthState {}
