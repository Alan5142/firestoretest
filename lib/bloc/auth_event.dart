part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent(this.email, this.password);
}

final class AuthLogoutEvent extends AuthEvent {}

final class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;

  AuthRegisterEvent(this.email, this.password);
}

final class AuthCheckEvent extends AuthEvent {}
