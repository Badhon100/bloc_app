import 'package:bloc_app/core/usecase/usecase.dart';
import 'package:bloc_app/features/auth/domain/entities/user.dart';
import 'package:bloc_app/features/auth/domain/usecases/current_user.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  AuthBloc({
    required UserSignIn userSignIn,
    required UserSignUp userSignUp,
    required CurrentUser currentUser,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthUserLoggedIn>(_onAuthUserLoggedIn);
  }

  void _onAuthUserLoggedIn(
    AuthUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold((l) => emit(AuthFailure(message: l.message)), (r) {
      print(r.id);
      emit(AuthSuccess(uid: r));
    });
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (user) => emit(AuthSuccess(uid: user)));
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (user) => emit(AuthSuccess(uid: user)));
  }
}
