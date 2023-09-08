import '../entities/user.dart';
import '../repositories/auth_repository_interface.dart';

class RegisterUseCase {
  final AuthRepositoryInterface _authRepository;

  RegisterUseCase(this._authRepository);

  Future<User> register({
    required String address,
    required String fullName,
    required String projectName,
    required int categoryId,
    required String phoneNumber,
  }) {
    return _authRepository.register(
      address: address,
      fullName: fullName,
      projectName: projectName,
      categoryId: categoryId,
      phoneNumber: phoneNumber,
    );
  }
}
