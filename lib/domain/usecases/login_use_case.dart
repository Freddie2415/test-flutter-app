import 'package:app/data/datasources/interfaces/token_datasource.dart';

import '../entities/token.dart';
import '../repositories/auth_repository_interface.dart';

class LoginUseCase {
  final AuthRepositoryInterface _authRepository;
  final TokenDataSource accessTokenStorage;
  final TokenDataSource refreshTokenStorage;

  LoginUseCase(
    this._authRepository,
    this.accessTokenStorage,
    this.refreshTokenStorage,
  );

  Future<void> login(String login, String password) async {
    Token token = await _authRepository.login(login: login, password: password);
    await accessTokenStorage.setToken(token.accessToken);
    await refreshTokenStorage.setToken(token.refreshToken);
  }
}
