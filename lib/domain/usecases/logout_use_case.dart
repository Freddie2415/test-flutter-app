import '../repositories/auth_repository_interface.dart';

class LogoutUseCase {
  final AuthRepositoryInterface _authRepository;

  LogoutUseCase(this._authRepository);

  Future<void> call() {
    return _authRepository.logout();
  }
}
