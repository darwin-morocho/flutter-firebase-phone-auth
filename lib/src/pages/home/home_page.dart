import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_auth/src/data/repositories/authentication_repository.dart';
import 'package:flutter_phone_auth/src/routes/routes.dart';
import 'package:meedu/get.dart';
import 'package:flutter_meedu/router.dart' as router;

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HOME PAGE"),
            SizedBox(height: 20),
            CupertinoButton(
              onPressed: () async {
                final repo = Get.i.find<AuthentiationRepository>();
                await repo.signOut();
                router.pushNamedAndRemoveUntil(Routes.LOGIN);
              },
              child: Text("Sign Out"),
            )
          ],
        ),
      ),
    );
  }
}
