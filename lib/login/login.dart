import 'package:flutter/material.dart';
import 'package:ncc/constants.dart';
import 'package:ncc/appscreens/checkin.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io' show Platform;
import 'package:ncc/helpers/achievements-helper.dart';

import '../authentication.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  String success = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Image.asset('assets/images/LoginIcon.png')),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Login',
                      style: (TextStyle(fontSize: 35)),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kLoginFieldDecoration.copyWith(
                        hintText: 'Enter your email'),
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kLoginFieldDecoration.copyWith(
                        hintText: 'Enter your password'),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: loginButtonColors,
                      minimumSize: const Size(150, 45),
                      maximumSize: const Size(150, 45),
                      elevation: 7.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () async {
                      AuthenticationHelper()
                          .signIn(email: email, password: password)
                          .then((error) async {
                        if (error == null) {
                          await getUserAchievements();
                          guestLogin = false;
                          Navigator.pushNamed(context, CheckinScreen.id);
                        } else {
                          setState(() {
                            success =
                                'There was an error with your login attempt.';
                          });
                        }
                      });
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: loginButtonColors,
                      minimumSize: const Size(225, 45),
                      maximumSize: const Size(225, 45),
                      elevation: 7.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.only(
                        left: 7.0,
                        right: 10.0,
                      ),
                    ),
                    icon: Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        fit: BoxFit.cover),
                    onPressed: () async {
                      try {
                        await AuthenticationHelper().signInwithGoogle();
                        await getUserAchievements();
                        guestLogin = false;
                        Navigator.pushNamed(context, CheckinScreen.id);
                      } catch (e) {
                        setState(() {
                          success =
                              'There was an error with your login attempt.';
                        });
                      }
                    },
                    label: const Text(
                      'Sign in With Google',
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (Platform.isIOS)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: loginButtonColors,
                        minimumSize: const Size(200, 45),
                        maximumSize: const Size(200, 45),
                        elevation: 7.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                      ),
                      icon: Image.network(
                        'https://www.freepnglogos.com/uploads/apple-logo-png/apple-logo-png-dallas-shootings-don-add-are-speech-zones-used-4.png',
                        height: 35,
                      ),
                      onPressed: () async {
                        await SignInWithApple.getAppleIDCredential(
                          scopes: [
                            AppleIDAuthorizationScopes.email,
                            AppleIDAuthorizationScopes.fullName,
                          ],
                        );
                        await getUserAchievements();
                        guestLogin = false;
                        Navigator.pushNamed(context, CheckinScreen.id);
                      },
                      label: const Text(
                        'Sign in With Apple',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    success,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
