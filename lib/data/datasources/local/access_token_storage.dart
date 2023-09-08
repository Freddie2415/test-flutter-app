import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/token_datasource.dart';

class AccessTokenStorage implements TokenDataSource {
  final SharedPreferences _sharedPreferences;
  @override
  String tokenKey = 'access_token';

  AccessTokenStorage(this._sharedPreferences);

  @override
  String? getToken() {
    return _sharedPreferences.getString(tokenKey);
  }

  @override
  Future<bool> setToken(String token) async {
    return await _sharedPreferences.setString(tokenKey, token);
  }

  @override
  Future<bool> deleteToken() async {
    return await _sharedPreferences.remove(tokenKey);
  }
}
