import 'package:bloc/bloc.dart';
import 'package:clean_flutter/core/usecase/usecase.dart';
import 'package:clean_flutter/features/Auth/domain/entities/users.dart';
import 'package:clean_flutter/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmail signInWithEmail;
  final RegisterWithEmail registerWithEmail;
  final SignOut signOut;

  AuthBloc(
      {required this.signInWithEmail,
      required this.registerWithEmail,
      required this.signOut})
      : super(AuthStateInitial()) {
    on<AuthEventLogin>((event, emit) async {
      emit(AuthStateLoading());
      // proses database
      final data = await signInWithEmail(
          SignInWithEmailParams(email: event.email, password: event.password));
      data.fold((left) {
        emit(AuthStateError(left.toString()));
      }, (right) {
        emit(AuthStateLoaded(right));
      });
    });
    on<AuthEventRegister>((event, emit) async {
      emit(AuthStateLoading());
      // proses database
      final data = await registerWithEmail(RegisterWithEmailParams(
          name: event.name, email: event.email, password: event.password));
      data.fold((left) {
        emit(AuthStateError(left.toString()));
      }, (right) {
        emit(AuthStateLoaded(right));
      });
    });
    on<AuthEventLogout>((event, emit) async {
      emit(AuthStateLoading());
      final result = await signOut(NoParams());
      result.fold((left) => (emit(AuthStateError(left.toString()))),
          (right) => emit(AuthStateLogout()));
    });
  }
}
