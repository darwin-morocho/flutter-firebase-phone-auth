import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_phone_auth/src/pages/splash/splash_controller.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_phone_auth/src/routes/routes.dart';

class SplashPage extends StatelessWidget {
  void _onAfterFirstLayout(BuildContext _, SplashController controller) async {
    final isLogged = await controller.checkLogin();
    if (isLogged) {
      router.pushReplacementNamed(Routes.HOME);
    } else {
      router.pushReplacementNamed(Routes.LOGIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<SplashController>(
      create: (_) => SplashController(),
      onAfterFirstLayout: _onAfterFirstLayout,
      child: Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(
            radius: 15,
          ),
        ),
      ),
    );
  }
}
