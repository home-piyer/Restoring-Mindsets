import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:visibility_detector/visibility_detector.dart';

class achievePage extends StatefulWidget {
  const achievePage({Key? key}) : super(key: key);
  static String id = 'achievePage';

  @override
  State<achievePage> createState() => _achievePageState();
}

class _achievePageState extends State<achievePage> {
  static const int _count = 3;
  bool fetchedAchievements = false;

  List<String> achievementList = ["3goals", "coping-plan", "journaling"];
  List<bool> achieved = [];

  void getUserAchievementsList() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final ref = FirebaseDatabase.instance.ref();
    final User? user = auth.currentUser;
    final uid = user?.uid;

    achieved.clear();
    for (final achievement in achievementList) {
      final snapshot = await ref.child('users/$uid/$achievement').get();
      if (snapshot.exists) {
        // print(snapshot.value);
        if (snapshot.value == true) {
          achieved.add(true);
        } else {
          achieved.add(false);
        }
      } else {
        print("error");
      }
    }

    setState(() {
      fetchedAchievements = true;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchedAchievements = false;
      getUserAchievementsList();
    });
  }

  Widget displayAchievements(bool fetchComplete) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: _count,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (_, i) {
          return IconButton(
            onPressed: () {},
            icon: (fetchComplete
                ? (achieved[i]
                    ? Image.asset('assets/achievements/${i + 1}.png')
                    : Image.asset('assets/achievements/${i + 1}gray.png'))
                : Image.asset('assets/achievements/${i + 1}gray.png')),
            iconSize: 100.0,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(achievePage.id),
      onVisibilityChanged: (VisibilityInfo info) {
        bool isVisible = info.visibleFraction != 0;
        if (isVisible == true) {
          fetchedAchievements = false;
          getUserAchievementsList();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 50.0,
          left: 15.0,
          right: 15.0,
        ),
        child: Column(
          children: [
            const Text(
              'Achievements',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SourceSans',
                fontSize: 35.0,
              ),
            ),
            displayAchievements(fetchedAchievements),
          ],
        ),
      ),
    );
  }
}
