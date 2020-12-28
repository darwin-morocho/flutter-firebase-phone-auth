import 'package:flutter_phone_auth/src/data/providers/remote/phone_authentication.dart';
import 'package:meta/meta.dart' show required;

abstract class PhoneAuthenticationRepository {
  void addPhoneListener(PhoneAuthenticationMixin _mixin);
  Future<void> verifyPhoneNumber(String phoneNumber, {int resendToken});
  void verifySmsCode({
    @required String verificationId,
    @required String smsCode,
  });
}

class PhoneAuthenticationRepositoryImpl implements PhoneAuthenticationRepository {
  final PhoneAuthentication _phoneAuthentication;

  PhoneAuthenticationRepositoryImpl(this._phoneAuthentication);

  @override
  void addPhoneListener(PhoneAuthenticationMixin _mixin) {
    _phoneAuthentication.addListener(_mixin);
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber, {int resendToken}) {
    return _phoneAuthentication.verifyPhoneNumber(phoneNumber, resendToken: resendToken);
  }

  @override
  void verifySmsCode({String verificationId, String smsCode}) {
    _phoneAuthentication.verifySmsCode(verificationId: verificationId, smsCode: smsCode);
  }
}
