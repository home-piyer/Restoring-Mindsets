import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ncc/appscreens/profile_page.dart';
import 'package:ncc/authentication.dart';
import 'package:ncc/start_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ncc/helpers/achievements-helper.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

Future<String> getDisplayName() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user = await auth.currentUser!;
  if (user.displayName == null) {
    return 'Your Name';
  } else {
    return user.displayName!;
  }
}

Future<String> getSelectedPhoto() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user = await auth.currentUser!;
  if (user.photoURL == null) {
    return 'assets/images/avatar.png';
  } else {
    return user.photoURL!;
  }
}

class settingsPage extends StatefulWidget {
  static String routeName = 'profilepage';
  const settingsPage({Key? key}) : super(key: key);

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  _launchURL() async {
    Uri _url = Uri.parse('https://www.heartfulnessinstitute.org/education');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  _launchURL1() async {
    Uri _url = Uri.parse('https://www.codefornonprofit.org/privacy-policy');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  _launchURL2() async {
    Uri _url =
        Uri.parse('https://www.codefornonprofit.org/terms-and-conditions');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (guestLogin) {
      Future.delayed(Duration.zero, () => showGuestLoginAlert(context));
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Center(
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SourceSans',
                  fontSize: 35.0,
                ),
              ),
            ),
            FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (guestLogin == true) {
                    return Center(
                      child: Text(
                        'User has not logged in',
                        style: TextStyle(fontFamily: 'SourceSans'),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: TextStyle(fontFamily: 'SourceSans'),
                      ),
                    );
                  } else {
                    final data = snapshot.data as String;
                    return Image.asset(
                      data,
                      height: 150.0,
                    );
                  }
                }
                return Text('operation could not be completed');
              },
              future: getSelectedPhoto(),
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Image.asset(
            //     'assets/images/avatar.png',
            //     height: 150.0,
            //   ),
            // ),
            FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (guestLogin == true) {
                    return Center(
                      child: Text(
                        'User has not logged in',
                        style: TextStyle(fontFamily: 'SourceSans'),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: const TextStyle(fontFamily: 'SourceSans'),
                      ),
                    );
                  } else {
                    final data = snapshot.data as String;
                    return Center(
                      child: Text(
                        data,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'SourceSans',
                          fontSize: 25.0,
                        ),
                      ),
                    );
                  }
                }
                return Text('operation could not be completed');
              },
              future: getDisplayName(),
            ),
            // const Center(
            //   child: Text(
            //     'Your Name',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontFamily: 'SourceSans',
            //       fontSize: 20.0,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 5,
            ),
            SettingTile(
              titleText: 'Profile',
              textSize: 27.0,
              tileColor: Color(0xFFA686C7),
              onTap: () {
                pushNewScreenWithRouteSettings(context,
                    settings: RouteSettings(name: settingsPage.routeName),
                    screen: ProfilePage(),
                    withNavBar: true);
              },
            ),
            const SizedBox(
              height: 5,
            ),
            SettingTile(
              titleText: 'Delete my Account',
              textSize: 25.0,
              tileColor: Color(0xFF2FA9C0),
              onTap: () {
                AuthenticationHelper().deleteUser();
                Navigator.of(context)
                    .maybePop(ModalRoute.withName('start_screen'));
                pushNewScreen(context,
                    screen: StartScreen(), withNavBar: false);
              },
            ),
            const SizedBox(
              height: 5,
            ),
            SettingTile(
              titleText: 'Log Out',
              textSize: 27.0,
              tileColor: Color(0xFFCF726A),
              onTap: () {
                AuthenticationHelper().signOut().then((error) {
                  if (error == null) {
                    Navigator.of(context)
                        .maybePop(ModalRoute.withName('start_screen'));
                    pushNewScreen(context,
                        screen: StartScreen(), withNavBar: false);
                  } else {}
                });
              },
            ),
            const SizedBox(
              height: 5,
            ),
            // SettingTile(
            //   titleText: 'Coping Plan',
            //   textSize: 30.0,
            //   tileColor: Color(0xFF2FA9C0),
            //   onTap: () {},
            // ),
            SettingTile(
              titleText: 'Additional Resources',
              textSize: 23.5,
              tileColor: Color(0xFFF8B600),
              onTap: () async {
                const url = 'https://www.novicc.org/';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  throw "Could not launch $url";
                }
              },
            ),
            const SizedBox(
              height: 2.0,
            ),
            const Center(
              child: Text(
                'Acknowledgement',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SourceSans',
                  fontSize: 15.0,
                ),
              ),
            ),
            Center(
                child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Heartfulness Institute',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 96, 68, 124),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = _launchURL,
                  ),
                ],
              ),
            )),
            Center(
                child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Privacy Policy',
                    style: const TextStyle(
                      color: Color(0xFF2090A5),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = _launchURL1,
                  ),
                ],
              ),
            )),
            Center(
                child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Terms and Conditions',
                    style: const TextStyle(
                      color: Color(0xFF2090A5),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = _launchURL2,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SettingTile extends StatelessWidget {
  String titleText;
  double textSize;
  VoidCallback onTap;
  Color tileColor;

  SettingTile(
      {required this.titleText,
      required this.textSize,
      required this.tileColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      tileColor: tileColor,
      title: Text(
        titleText,
        style: TextStyle(fontSize: textSize, color: Colors.white),
      ),
      visualDensity: VisualDensity(vertical: 4),
      dense: false,
      trailing: Image.asset('assets/images/smallBackButton.png'),
      onTap: onTap,
    );
  }
}
