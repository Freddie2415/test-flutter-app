import 'dart:async';

import 'package:app/domain/entities/user.dart';
import 'package:app/domain/usecases/get_current_user_use_case.dart';
import 'package:app/domain/usecases/logout_use_case.dart';
import 'package:app/exceptions/exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthBloc(
    this._logoutUseCase,
    this._getCurrentUserUseCase,
  ) : super(AuthInitial()) {
    on<AuthCurrentUserRequested>(_onGetCurrentUser);
    on<AuthLogoutRequested>(_onLogout);
  }

  FutureOr<void> _onGetCurrentUser(
    AuthCurrentUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = await _getCurrentUserUseCase();
      emit(AuthAuthenticated(user));
    } on ServerErrorException catch (e) {
      if (e.statusCode == 401) {
        emit(AuthUnauthorized());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      debugPrint(e.toString());
    }
  }

  FutureOr<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _logoutUseCase();
    emit(AuthUnauthorized());
  }
}
