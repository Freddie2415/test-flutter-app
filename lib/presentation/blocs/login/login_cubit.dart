import 'package:app/domain/usecases/login_use_case.dart';
import 'package:app/exceptions/exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../auth/auth_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final AuthBloc _authBloc;

  LoginCubit(this._loginUseCase, this._authBloc) : super(LoginInitial());

  Future<void> login({
    required String login,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      await _loginUseCase.login(login, password);
      emit(LoginSuccess());
      _authBloc.add(AuthCurrentUserRequested());
    } on ServerErrorException catch (e) {
      if (e.statusCode == 400) {
        emit(LoginFailure("Неверный номер телефона или пароль!"));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
