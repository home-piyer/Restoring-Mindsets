import 'package:flutter/material.dart';
import 'package:ncc/appscreens/checkin.dart';
import 'package:ncc/login/login.dart';
import 'package:ncc/login/sign_up.dart';
import 'authentication.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class StartScreen extends StatefulWidget {
  static const String id = 'start_screen';
  const StartScreen({Key? key}) : super(key: key);
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  //TextEditingController nameController = TextEditingController();
  //TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 100,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/images/noviCC_logo.png',
                    height: 100,
                    width: 200,
                  )),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(30),
                child: const Text(
                  'Welcome to Restoring Mindsets',
                  style: (TextStyle(fontSize: 30, fontFamily: 'Italianno')),
                ),
              ),
              Container(
                  height: 250,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/images/pigina.png',
                    height: 250,
                    width: 250,
                  )),
              Container(
                  height: 70,
                  padding: const EdgeInsets.fromLTRB(50, 29, 50, 0),
                  child: ElevatedButton(
                      child: const Text('Get Started!',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SourceSans',
                            fontSize: 22,
                          )),
                      onPressed: () {
                        Navigator.pushNamed(context, SignupScreen.id);
                      },
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(9.0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.green.shade300),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))))),
              TextButton(
                onPressed: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: LoginScreen(),
                    settings: RouteSettings(name: LoginScreen.id),
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.green,
                    decoration: TextDecoration.underline,
                    fontFamily: 'SourceSans',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  guestLogin = true;
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: CheckinScreen(),
                    settings: RouteSettings(name: CheckinScreen.id),
                  );
                },
                child: const Text(
                  'Continue as Guest',
                  style: TextStyle(
                    color: Colors.lightGreen,
                    decoration: TextDecoration.underline,
                    fontFamily: 'SourceSans',
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
