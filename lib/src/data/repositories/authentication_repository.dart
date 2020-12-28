import 'package:flutter_phone_auth/src/data/providers/local/authentication_client.dart';

abstract class AuthentiationRepository {
  Future<String> get accessToken;
  Future<void> signOut();
}

class AuthentiationRepositoryImpl implements AuthentiationRepository {
  final AuthenticationClient _client;
  AuthentiationRepositoryImpl(this._client);

  @override
  Future<String> get accessToken => _client.accessToken;

  @override
  Future<void> signOut() {
    return _client.signOut();
  }
}
