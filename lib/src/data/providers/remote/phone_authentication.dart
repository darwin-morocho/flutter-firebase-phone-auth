import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart' show required;

class PhoneAuthentication {
  final FirebaseAuth _auth;
  PhoneAuthentication(this._auth);

  PhoneAuthenticationMixin _mixin;

  addListener(PhoneAuthenticationMixin _mixin) {
    this._mixin = _mixin;
  }

  Future<void> verifyPhoneNumber(String phoneNumber, {int resendToken}) {
    return _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: _mixin.onCodeSent,
      forceResendingToken: resendToken,
      codeAutoRetrievalTimeout: _mixin.onCodeAutoRetrievalTimeout,
    );
  }

  void verifySmsCode({
    @required String verificationId,
    @required String smsCode,
  }) {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    _onVerificationCompleted(credential);
  }

  void _onVerificationCompleted(PhoneAuthCredential credential) async {
    try {
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final String idToken = await userCredential.user.getIdToken();
      _mixin.onVerificationCompleted(idToken);
    } on FirebaseAuthException catch (e) {
      _onVerificationFailed(e);
    }
  }

  void _onVerificationFailed(FirebaseAuthException e) {
    _mixin.onVerificationFailed(e.code);
  }
}

mixin PhoneAuthenticationMixin {
  void onVerificationFailed(String error);
  void onVerificationCompleted(String idToken);
  void onCodeSent(String verificationId, int resendToken);
  void onCodeAutoRetrievalTimeout(String verificationId);
}
