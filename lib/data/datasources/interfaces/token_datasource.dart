abstract class TokenDataSource {
  late final String tokenKey;

  String? getToken();

  Future<bool> setToken(String token);

  Future<bool> deleteToken();
}
