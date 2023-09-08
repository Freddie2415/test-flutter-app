import 'package:app/domain/entities/token.dart';
import 'package:app/domain/entities/user.dart';
import 'package:app/domain/repositories/auth_repository_interface.dart';

import '../datasources/interfaces/token_datasource.dart';
import '../datasources/remote/api/api_provider.dart';

class AuthRepository extends ApiProvider implements AuthRepositoryInterface {
  final TokenDataSource _tokenDataSource;

  AuthRepository(
    super.dio,
    super.baseUrl,
    this._tokenDataSource,
  );

  @override
  Future<Token> login({
    required String login,
    required String password,
  }) async {
    final json = await post(
      "$baseUrl/accounts/login/",
      data: {
        "phone_number": login,
        "password": password,
      },
    );
    return Token.fromJson(json);
  }

  @override
  Future<User> register({
    required String address,
    required String fullName,
    required String projectName,
    required int categoryId,
    required String phoneNumber,
  }) async {
    final json = await post(
      "$baseUrl/accounts/seller/registration/",
      data: {
        "address": address,
        "full_name": fullName,
        "project_name": projectName,
        "category": categoryId,
        "phone_number": phoneNumber,
      },
    );

    return User.fromJson(json);
  }

  @override
  Future<User> getMe() async {
    final json = await get("$baseUrl/accounts/me/");
    return User.fromJson(json);
  }

  @override
  Future<void> logout() async {
    await _tokenDataSource.deleteToken();
  }
}
