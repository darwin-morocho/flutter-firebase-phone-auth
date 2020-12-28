import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationClient {
  final FirebaseAuth _auth;
  AuthenticationClient(this._auth);

  User get user => _auth.currentUser;
  Future<String> get accessToken => user?.getIdToken();

  Future<void> signOut() {
    return _auth.signOut();
  }
}
