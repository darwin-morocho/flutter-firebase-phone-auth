import 'dart:async';

import 'package:flutter_phone_auth/src/data/providers/remote/phone_authentication.dart';
import 'package:flutter_phone_auth/src/data/repositories/phone_authentication_repository.dart';
import 'package:flutter_phone_auth/src/pages/login/login_state.dart';
import 'package:meedu/get.dart';
import 'package:meedu/state.dart';
import 'package:meedu/rx.dart';

enum LoginStatus {
  fetching,
  error,
  ok,
  none,
}

class LoginController extends StateController<LoginState> with PhoneAuthenticationMixin {
  LoginController() : super(LoginState());

  final _repository = Get.i.lazyFind<PhoneAuthenticationRepository>();
  final Rx<LoginStatus> _status = Rx(LoginStatus.none);
  Rx<LoginStatus> get status => _status;

  String _error = '';
  String get error => _error;

  StreamSubscription _subscription;

  set subscription(StreamSubscription subscription) {
    _subscription = subscription;
  }

  @override
  void onInit() {
    _repository.addPhoneListener(this);
  }

  void onTextChanged(String text) {
    if (!state.sent) {
      update(state.copyWith(phoneNumber: text));
    } else {
      update(state.copyWith(smsCode: text));
    }
  }

  Future<void> sendMeACode() {
    _status.value = LoginStatus.fetching;
    return _repository.verifyPhoneNumber(
      state.phoneNumber,
      resendToken: state.resendToken,
    );
  }

  void verifyCode() {
    _status.value = LoginStatus.fetching;
    _repository.verifySmsCode(verificationId: state.verificationId, smsCode: state.smsCode);
  }

  @override
  void onCodeAutoRetrievalTimeout(String verificationId) {
    update(
      this.state.copyWith(verificationId: verificationId),
    );
  }

  @override
  void onCodeSent(String verificationId, int resendToken) {
    print("✅ sent");
    status.value = LoginStatus.none;
    update(
      this.state.copyWith(
            sent: true,
            resendToken: resendToken,
            verificationId: verificationId,
          ),
    );
  }

  @override
  void onVerificationCompleted(String idToken) {
    _status.value = LoginStatus.ok;
  }

  @override
  void onVerificationFailed(String error) {
    print("❌ $error");
    _error = error;
    _status.value = LoginStatus.error;
  }

  @override
  void onDispose() {
    _subscription?.cancel();
    _status.close();
    super.onDispose();
  }
}
