import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:ncc/appscreens/landing_page.dart';
import 'package:ncc/appscreens/emotion_camera.dart';

class CheckinScreen extends StatefulWidget {
  static const String id = 'checkin_screen';

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  void _navigateToLandingPage() {
    bool isRestless = _checks[0];
    bool isRelaxed = _checks[1];
    bool isStressed = _checks[2];
    bool isIndifferent = _checks[3];
    bool isSad = _checks[4];
    bool isEnthusiatic = _checks[5];
    bool isAnxious = _checks[6];
    bool isHappy = _checks[7];
    bool isHeavy = _checks[8];
    bool isLight = _checks[9];
    bool isImbalanced = _checks[10];
    bool isBalanced = _checks[11];

    // Show a dialog popup if the user is stressed or sad
    if (isSad) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  title: const Center(child: Text('Manage Your Emotions!')),
                  content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Looks like you are not feeling your best today. That\'s okay!\n\nTry Journaling, Rejuvination, or Affirmations in the ',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        TextSpan(
                            text: 'Activities',
                            style: const TextStyle(
                                color: Color(0xFFCF726A),
                                fontSize: 18.0,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Navigator.of(context).pop();
                                await pushNewScreenWithRouteSettings(
                                  context,
                                  settings:
                                      const RouteSettings(name: LandingPage.id),
                                  screen: const LandingPage(
                                    initialIndex: 1,
                                  ),
                                );
                              }),
                        const TextSpan(
                          text:
                              ' section of Restoring Mindsets to brighten you spiritis.',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                IconButton(
                  icon: Image.asset('assets/images/backButton.png'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: const RouteSettings(name: LandingPage.id),
                      screen: const LandingPage(
                        initialIndex: 0,
                      ),
                    );
                  },
                ),
              ]));
        },
      );
    } else if (isRestless || isStressed || isAnxious) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  title: const Center(child: Text('Manage Your Emotions!')),
                  content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Breathe in. Breathe out. Go out for breath of fresh air.\n\nTry Guided Meditation, Guided Relaxation, or Breathing with Purpose in the ',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        TextSpan(
                            text: 'Activities',
                            style: const TextStyle(
                                color: Color(0xFFCF726A),
                                fontSize: 18.0,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Navigator.of(context).pop();
                                await pushNewScreenWithRouteSettings(
                                  context,
                                  settings:
                                      const RouteSettings(name: LandingPage.id),
                                  screen: const LandingPage(
                                    initialIndex: 1,
                                  ),
                                );
                              }),
                        const TextSpan(
                          text:
                              ' section of Restoring Mindsets to calm your nerves and slow down your heart rate.',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                IconButton(
                  icon: Image.asset('assets/images/backButton.png'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: const RouteSettings(name: LandingPage.id),
                      screen: const LandingPage(
                        initialIndex: 0,
                      ),
                    );
                  },
                ),
              ]));
        },
      );
    } else if (isHeavy || isImbalanced) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  title: const Center(child: Text('Manage Your Emotions!')),
                  content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Understanding what you are feeling and why is the first step to addressing them.\n\nTry Guided PEMS or Guided Rejuvation in the ',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        TextSpan(
                            text: 'Activities',
                            style: const TextStyle(
                                color: Color(0xFFCF726A),
                                fontSize: 18.0,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Navigator.of(context).pop();
                                await pushNewScreenWithRouteSettings(
                                  context,
                                  settings:
                                      const RouteSettings(name: LandingPage.id),
                                  screen: const LandingPage(
                                    initialIndex: 1,
                                  ),
                                );
                              }),
                        const TextSpan(
                          text:
                              ' section of Restoring Mindsets to recenter yourself.',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                IconButton(
                  icon: Image.asset('assets/images/backButton.png'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: const RouteSettings(name: LandingPage.id),
                      screen: const LandingPage(
                        initialIndex: 0,
                      ),
                    );
                  },
                ),
              ]));
        },
      );
    } else if (isRelaxed || isHappy || isEnthusiatic || isLight || isBalanced) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  title: const Center(child: Text('Manage Your Emotions!')),
                  content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Glad to see you are having a great day!\n\nJournal about it in the ',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        TextSpan(
                            text: 'Activities',
                            style: const TextStyle(
                                color: Color(0xFFCF726A),
                                fontSize: 18.0,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Navigator.of(context).pop();
                                await pushNewScreenWithRouteSettings(
                                  context,
                                  settings:
                                      const RouteSettings(name: LandingPage.id),
                                  screen: const LandingPage(
                                    initialIndex: 1,
                                  ),
                                );
                              }),
                        const TextSpan(
                          text:
                              ' section of Restoring Mindsets to remember and revist it in the future.',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                IconButton(
                  icon: Image.asset('assets/images/backButton.png'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: const RouteSettings(name: LandingPage.id),
                      screen: const LandingPage(
                        initialIndex: 0,
                      ),
                    );
                  },
                ),
              ]));
        },
      );
    } else if (isIndifferent) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  title: const Center(child: Text('Manage Your Emotions!')),
                  content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Glad to see you are doing okay.\n\nTry Guided Affirmations or Guided PEMS in the ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                        TextSpan(
                            text: 'Activities',
                            style: const TextStyle(
                                color: Color(0xFFCF726A),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Navigator.of(context).pop();
                                await pushNewScreenWithRouteSettings(
                                  context,
                                  settings:
                                      const RouteSettings(name: LandingPage.id),
                                  screen: const LandingPage(
                                    initialIndex: 1,
                                  ),
                                );
                              }),
                        const TextSpan(
                          text:
                              ' section of Restoring Mindsets to reassure your wellness.',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                IconButton(
                  icon: Image.asset('assets/images/backButton.png'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: const RouteSettings(name: LandingPage.id),
                      screen: const LandingPage(
                        initialIndex: 0,
                      ),
                    );
                  },
                ),
              ]));
        },
      );
    } else {
      // Navigate to the landing page
      pushNewScreenWithRouteSettings(
        context,
        settings: const RouteSettings(name: LandingPage.id),
        screen: const LandingPage(
          initialIndex: 0,
        ),
      );
    }
  }

  static const int _count = 12;
  List<String> emotionBank = [
    'Restless',
    'Relaxed',
    'Stressed',
    'Indifferent',
    'Sad',
    'Enthusiastic',
    'Anxious',
    'Happy',
    'Heavy',
    'Light',
    'Imbalanced',
    'Balanced',
  ];
  final List<bool> _checks = List.generate(_count, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
            top: 60.0, left: 5.0, right: 5.0, bottom: 30.0),
        child: Column(
          children: <Widget>[
            const Text(
              'What are you feeling today?',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SourceSans',
                fontSize: 25.0,
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            const Text(
              'Select all that apply or take a selfie and we\'ll detect how you\'re feeling',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SourceSans',
                fontSize: 15.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              width: 10.0,
            ),
            IconButton(
              onPressed: () async {
                // Navigate to the EmotionCamera page with the front camera
                final cameras = await availableCameras();
                final frontCamera = cameras.firstWhere(
                  (camera) => camera.lensDirection == CameraLensDirection.front,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmotionCamera(
                      camera: frontCamera,
                    ),
                  ),
                );
              },
              icon: Image.asset('assets/checkin/camera.png'),
              iconSize: 20.0,
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: _count,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (_, i) {
                  return Column(
                    children: <Widget>[
                      Theme(
                        child: Checkbox(
                          activeColor: Colors.black,
                          value: _checks[i],
                          onChanged: (newValue) =>
                              setState(() => _checks[i] = newValue!),
                        ),
                        data: ThemeData(
                          primarySwatch: Colors.grey,
                          unselectedWidgetColor: Colors.black,
                        ),
                      ),
                      Text(
                        emotionBank[i],
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'SourceSans',
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                          child: Image.asset('assets/checkin/${i + 1}.png')),
                    ],
                  );
                },
              ),
            ),
            IconButton(
              onPressed: _navigateToLandingPage,
              icon: Image.asset('assets/images/backButton.png'),
            ),
          ],
        ),
      ),
    );
  }
}

// onPressed: () async {
// AuthenticationHelper().signOut().then((error) {
// if (error == null) {
// Navigator.pop(context);
// } else {}
// });
// },