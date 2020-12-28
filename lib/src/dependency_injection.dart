import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phone_auth/src/data/repositories/authentication_repository.dart';
import 'package:flutter_phone_auth/src/data/repositories/phone_authentication_repository.dart';

import 'data/providers/local/authentication_client.dart';
import 'data/providers/remote/phone_authentication.dart';
import 'package:meedu/get.dart';

abstract class DependencyInjection {
  static void initialize() {
    final firebaseAuth = FirebaseAuth.instance;
    final authenticationClient = AuthenticationClient(firebaseAuth);
    final phoneAuthentication = PhoneAuthentication(firebaseAuth);

    final authentiationRepository = AuthentiationRepositoryImpl(
      authenticationClient,
    );

    Get.i.put<AuthentiationRepository>(authentiationRepository);
    Get.i.lazyPut<PhoneAuthenticationRepository>(
      () => PhoneAuthenticationRepositoryImpl(phoneAuthentication),
    );
  }
}
