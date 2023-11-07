import 'package:flutter/material.dart';
import 'package:ncc/appscreens/checkin.dart';
import 'package:ncc/login/login.dart';
import 'package:ncc/login/sign_up.dart';
import 'package:ncc/start_screen.dart';
import 'package:ncc/appscreens/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ncc/authentication.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AuthenticationStateChangeNotifier(),
      builder: (context, isLoggedIn, _) {
        final initialRoute = isLoggedIn ? CheckinScreen.id : StartScreen.id;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          routes: {
            StartScreen.id: (context) => StartScreen(),
            SignupScreen.id: (context) => const SignupScreen(),
            LoginScreen.id: (context) => const LoginScreen(),
            LandingPage.id: (context) => LandingPage(),
            CheckinScreen.id: (context) => CheckinScreen(),
          },
        );
      },
    );
  }
}
