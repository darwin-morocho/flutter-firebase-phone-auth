import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phone_auth/src/dependency_injection.dart';
import 'package:flutter_phone_auth/src/pages/splash/splash_page.dart';
import 'package:flutter_phone_auth/src/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'src/pages/home/home_page.dart';
import 'src/pages/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DependencyInjection.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: router.navigatorKey,
      initialRoute: Routes.SPLASH,
      routes: {
        Routes.SPLASH: (_) => SplashPage(),
        Routes.LOGIN: (_) => LoginPage(),
        Routes.HOME: (_) => HomePage(),
      },
    );
  }
}
