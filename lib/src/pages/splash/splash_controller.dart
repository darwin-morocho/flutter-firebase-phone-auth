import 'package:flutter_phone_auth/src/data/repositories/authentication_repository.dart';

import 'package:meedu/get.dart';
import 'package:meedu/state.dart';

class SplashController extends SimpleController {
  final AuthentiationRepository _repository = Get.i.find<AuthentiationRepository>();

  Future<bool> checkLogin() async {
    return (await _repository.accessToken) != null;
  }
}
