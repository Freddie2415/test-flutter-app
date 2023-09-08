import '../entities/user.dart';
import '../repositories/auth_repository_interface.dart';

class GetCurrentUserUseCase {
  final AuthRepositoryInterface _authRepository;

  GetCurrentUserUseCase(this._authRepository);

  Future<User> call() {
    return _authRepository.getMe();
  }
}
