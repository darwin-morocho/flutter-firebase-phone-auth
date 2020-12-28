import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String phoneNumber, smsCode;
  final String verificationId;
  final int resendToken;
  final bool sent;

  LoginState({
    this.phoneNumber = '',
    this.smsCode = '',
    this.verificationId,
    this.resendToken,
    this.sent = false,
  });
  LoginState copyWith({
    String phoneNumber,
    String smsCode,
    String verificationId,
    int resendToken,
    bool sent,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      smsCode: smsCode ?? this.smsCode,
      verificationId: verificationId ?? this.verificationId,
      resendToken: resendToken ?? this.resendToken,
      sent: sent ?? this.sent,
    );
  }

  @override
  List<Object> get props => [
        phoneNumber,
        verificationId,
        resendToken,
        smsCode,
        sent,
      ];
}
