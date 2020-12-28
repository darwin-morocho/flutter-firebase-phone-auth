import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/rx.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_phone_auth/src/pages/login/login_controller.dart';
import 'package:flutter_phone_auth/src/pages/login/login_state.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_phone_auth/src/routes/routes.dart';

class LoginPage extends ProviderPage<LoginController> {
  @override
  LoginController create(BuildContext context) => LoginController();

  @override
  void onAfterFirstLayout(BuildContext context, LoginController controller) {
    controller.subscription = controller.status.stream.listen((LoginStatus status) {
      if (status == LoginStatus.ok) {
        router.pushReplacementNamed(Routes.HOME);
      } else if (status == LoginStatus.error) {
        showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            content: Text(controller.error),
            actions: [
              CupertinoDialogAction(
                child: Text("OK"),
                onPressed: () => router.pop(),
              )
            ],
          ),
        );
      }
    });
  }

  @override
  Widget buildPage(BuildContext context, LoginController controller) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StateBuilder<LoginController, LoginState>(
                    builder: (_) => CupertinoTextField(
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      onChanged: _.onTextChanged,
                      placeholder: _.state.sent ? "Enter your sms code" : "Enter your phone",
                    ),
                  ),
                  CupertinoButton(
                    child: StateBuilder<LoginController, LoginState>(
                      builder: (_) => Text(_.state.sent ? "Verify code" : "Send me a code"),
                    ),
                    onPressed: () {
                      if (!controller.state.sent) {
                        controller.sendMeACode();
                      } else {
                        controller.verifyCode();
                      }
                    },
                  )
                ],
              ),
              RxBuilder(
                observables: [
                  controller.status,
                ],
                builder: (_) => controller.status.value == LoginStatus.fetching
                    ? Positioned.fill(
                        child: Container(
                          color: Colors.white54,
                          child: CupertinoActivityIndicator(),
                        ),
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
