import 'package:app/domain/entities/token.dart';

import '../entities/user.dart';

abstract interface class AuthRepositoryInterface {
  Future<User> register({
    required String address,
    required String fullName,
    required String projectName,
    required int categoryId,
    required String phoneNumber,
  });

  Future<Token> login({
    required String login,
    required String password,
  });

  Future<User> getMe();

  Future<void> logout();
}
