import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../appscreens/landing_page.dart';
import '../authentication.dart';
import '../start_screen.dart';

Future<void> updateAchievement(String achieveName) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
  await ref.update({
    achieveName: true,
  });
}

Future<void> updateDepressionCalendar() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
  await ref.update({
    "depression-calendar": true,
    "depression-sd": DateTime.now().toString(),
  });
}

Future<void> deleteDepressionCalendar() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
  await ref.update({
    "depression-calendar": false,
    "depression-sd": "",
  });
}

Future<void> updateAnxietyCalendar() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
  await ref.update({
    "anxiety-calendar": true,
    "anxiety-sd": DateTime.now().toString(),
  });
}

Future<void> deleteAnxietyCalendar() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
  await ref.update({
    "anxiety-calendar": false,
    "anxiety-sd": "",
  });
}

Future<void> updatePTSDCalendar() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
  await ref.update({
    "ptsd-calendar": true,
    "ptsd-sd": DateTime.now().toString(),
  });
}

Future<void> deletePTSDCalendar() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
  await ref.update({
    "ptsd-calendar": false,
    "ptsd-sd": "",
  });
}

Future<void> updateBPDCalendar() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
  await ref.update({
    "bpd-calendar": true,
    "bpd-sd": DateTime.now().toString(),
  });
}

Future<void> deleteBPDCalendar() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
  await ref.update({
    "bpd-calendar": false,
    "bpd-sd": "",
  });
}

Future<void> updateOCDCalendar() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
  await ref.update({
    "ocd-calendar": true,
    "ocd-sd": DateTime.now().toString(),
  });
}

Future<void> deleteOCDCalendar() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
  await ref.update({
    "ocd-calendar": false,
    "ocd-sd": "",
  });
}

void showGuestLoginAlert(context) {
  if (guestLogin == true) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Required"),
          content: Text("Please login to use this feature"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .maybePop(ModalRoute.withName('home_page'));
                pushNewScreenWithRouteSettings(
                  context,
                  screen: LandingPage(),
                  settings: const RouteSettings(name: LandingPage.id),
                );
              },
              child: const Text("Home Screen"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .maybePop(ModalRoute.withName('start_screen'));
                pushNewScreen(context,
                    screen: StartScreen(), withNavBar: false);
              },
              child: Text("Go to Login Screen"),
            ),
          ],
        );
      },
    );
  }
}

Future<void> getUserAchievements() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref();
  final User? user = auth.currentUser;
  final uid = user?.uid;

  final snapshot = await ref.child('users/$uid').get();
  if (snapshot.exists) {
    return;
  } else {
    DatabaseReference userRef = FirebaseDatabase.instance.ref("users/$uid");
    await userRef.set({
      "3goals": false,
      "coping-plan": false,
      "journaling": false,
      "depression-calendar": false,
      "depression-sd": "",
      "anxiety-calendar": false,
      "anxiety-sd": "",
      "ptsd-calendar": false,
      "ptsd-sd": "",
      "bpd-calendar": false,
      "bpd-sd": "",
      "ocd-calendar": false,
      "ocd-sd": "",
    });
    return;
  }
}
