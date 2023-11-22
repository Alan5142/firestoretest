import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthLoginEvent>(_handleLoginEvent);
    on<AuthLogoutEvent>(_handleLogoutEvent);
    on<AuthRegisterEvent>(_handleRegisterEvent);
    on<AuthCheckEvent>(_handleCheckEvent);
  }

  FutureOr<void> _handleLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: event.email, password: event.password);
      emit(AuthSuccessState(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message!));
    }
  }

  FutureOr<void> _handleLogoutEvent(
      AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await FirebaseAuth.instance.signOut();
      emit(AuthInitialState());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message!));
    }
  }

  FutureOr<void> _handleRegisterEvent(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: event.email, password: event.password);
      emit(AuthSuccessState(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message!));
    }
  }

  FutureOr<void> _handleCheckEvent(
      AuthCheckEvent event, Emitter<AuthState> emit) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(AuthNotLoggedInState());
    } else {
      emit(AuthSuccessState(user));
    }
  }
}
