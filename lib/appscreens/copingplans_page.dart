import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ncc/helpers/achievements-helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ncc/appscreens/copingcalendar_page.dart';
import 'package:ncc/helpers/coping-plans/depression.dart';
import 'package:ncc/helpers/coping-plans/anxiety.dart';
import 'package:ncc/helpers/coping-plans/ptsd.dart';
import 'package:ncc/helpers/coping-plans/ocd.dart';
import 'package:ncc/helpers/coping-plans/bpd.dart';
import 'package:url_launcher/url_launcher.dart';

class copingPlansPage extends StatefulWidget {
  const copingPlansPage({Key? key}) : super(key: key);

  @override
  State<copingPlansPage> createState() => _copingPlansPageState();
}

class _copingPlansPageState extends State<copingPlansPage> {
  late SharedPreferences prefs;
  bool switchD = false;
  bool switchA = false;
  bool switchP = false;
  bool switchB = false;
  bool switchO = false;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  @override
  void dispose() {
    prefs.setBool(
        'switchD', switchD); // save switchD value before closing the app
    prefs.setBool('switchA', switchA);
    prefs.setBool('switchP', switchP);
    prefs.setBool('switchB', switchB);
    prefs.setBool('switchO', switchO);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      switchD = prefs.getBool('switchD') ?? false;
      switchA = prefs.getBool('switchA') ?? false;
      switchP = prefs.getBool('switchP') ?? false;
      switchB = prefs.getBool('switchB') ?? false;
      switchO = prefs.getBool('switchO') ?? false;
    });
  }

  void deleteDepressionPlan() {
    MyList.meetings.removeWhere(
        (meeting) => meeting.description == 'Depression Coping Plan');
    MyList.saveMeetings();
  }

  void deleteAnxietyPlan() {
    MyList.meetings
        .removeWhere((meeting) => meeting.description == 'Anxiety Coping Plan');
    MyList.saveMeetings();
  }

  void deletePTSDPlan() {
    MyList.meetings
        .removeWhere((meeting) => meeting.description == 'PTSD Coping Plan');
    MyList.saveMeetings();
  }

  void deleteBPDPlan() {
    MyList.meetings
        .removeWhere((meeting) => meeting.description == 'BPD Coping Plan');
    MyList.saveMeetings();
  }

  void deleteOCDPlan() {
    MyList.meetings
        .removeWhere((meeting) => meeting.description == 'OCD Coping Plan');
    MyList.saveMeetings();
  }

  void handleSwitchDChanged(bool value) async {
    if (!value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text("Delete Plan from Calendar"),
            content: const Text(
              "Would you like to delete the events of the Depression Coping Plan from your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchD', true);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await deleteDepressionCalendar();
                  deleteDepressionPlan();
                  await prefs.setBool('switchD', false);
                  setState(() {
                    switchD = false;
                  });
                  Navigator.of(context).pop(); // dismiss dialog
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text("Add Plan to Calendar"),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Depression",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              " (major depressive disorder) is a common and serious medical illness that negatively affects how you feel, the way you think and how you act.\n\nDepression ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "symptoms",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              " can vary from mild to severe and can include:\n   -Feeling sad\n  -Loss of interest or pleasure in activities once enjoyed\n  -Changes in appetite\n  -Weight loss or gain unrelated to dieting\n  -Trouble sleeping or sleeping too much\n  -Loss of energy or increased fatigue\n\nFor ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "more",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: " information visit ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "this link.",
                          style: TextStyle(
                            color: const Color(0xFFCF726A),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  "https://www.psychiatry.org/patients-families/depression/what-is-depression"); // replace with your website URL
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Would you like to add the events of the Depression Coping Plan to your calendar?",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SourceSans',
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchD', false);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await updateDepressionCalendar();
                  addDepressionPlan(DateTime.now());
                  await prefs.setBool('switchD', true);
                  setState(() {
                    switchD = true;
                  });
                  Navigator.of(context).pop(); // dismiss dialog
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    }
  }

  void handleSwitchAChanged(bool value) async {
    if (!value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text("Delete Plan from Calendar"),
            content: const Text(
              "Would you like to delete the events of the Anxiety Coping Plan from your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchA', true);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await deleteAnxietyCalendar();
                  deleteAnxietyPlan();
                  await prefs.setBool('switchA', false);
                  setState(() {
                    switchA = false;
                  });
                  Navigator.of(context).pop(); // dismiss dialog
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text("Add Plan to Calendar"),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Anxiety",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              " is a normal reaction to stress and can be beneficial in some situations. It can alert us to dangers and help us prepare and pay attention. Anxiety disorders differ from normal feelings of nervousness or anxiousness and involve excessive fear or anxiety.\n\nThe different ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "types",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              " of Anxiety Disorders include:\n   -Specific Phobia\n  -Social Anxiety Disorder\n  -Panic Disorder\n  -Agoraphobia\n  -Generalized Anxiety Disorder\n  -Separation Anxiety Disorder\n\nFor ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "more",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: " information visit ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "this link.",
                          style: TextStyle(
                            color: const Color(0xFFCF726A),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  "https://www.psychiatry.org/patients-families/anxiety-disorders/what-are-anxiety-disorders"); // replace with your website URL
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Would you like to add the events of the Anxiety Coping Plan to your calendar?",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SourceSans',
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchA', false);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await updateAnxietyCalendar();
                  addAnxietyPlan(DateTime.now());
                  await prefs.setBool('switchA', true);
                  setState(() {
                    switchA = true;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    }
  }

  void handleSwitchPChanged(bool value) async {
    if (!value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text("Delete Plan from Calendar"),
            content: const Text(
              "Would you like to delete the events of the PTSD Coping Plan from your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchP', true);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await deletePTSDCalendar();
                  deletePTSDPlan();
                  await prefs.setBool('switchP', false);
                  setState(() {
                    switchP = false;
                  });
                  Navigator.of(context).pop(); // dismiss dialog
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text("Add Plan to Calendar"),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "PTSD",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              " (Posttraumatic stress disorder) is a psychiatric disorder that may occur in people who have experienced or witnessed a traumatic event, series of events or set of circumstances. An individual may experience this as emotionally or physically harmful or life-threatening and may affect mental, physical, social, and/or spiritual well-being.\n\nPTSD ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "symptoms",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              " can include:\n   -Intrusion: Intrusive thoughts\n  -Avoidance: Avoiding reminders of the traumatic event\n  -Alterations in cognition and mood: Inability to remember important aspects of the traumatic event or distorted thoughts\n  -Alterations in arousal and reactivity: Being irritable and having touble sleeping\n\nFor ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "more",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: " information visit ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "this link.",
                          style: TextStyle(
                            color: const Color(0xFFCF726A),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  "https://www.psychiatry.org/patients-families/ptsd/what-is-ptsd"); // replace with your website URL
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Would you like to add the events of the PTSD Coping Plan to your calendar?",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SourceSans',
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchP', false);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await updatePTSDCalendar();
                  addPTSDPlan(DateTime.now());
                  await prefs.setBool('switchP', true);
                  setState(() {
                    switchP = true;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    }
  }

  void handleSwitchBChanged(bool value) async {
    if (!value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text("Delete Plan from Calendar"),
            content: const Text(
              "Would you like to delete the events of the BPD Coping Plan from your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchB', true);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await deleteBPDCalendar();
                  deleteBPDPlan();
                  await prefs.setBool('switchB', false);
                  setState(() {
                    switchB = false;
                  });
                  Navigator.of(context).pop(); // dismiss dialog
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text("Add Plan to Calendar"),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "BPD",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        const TextSpan(
                          text:
                              " (Borderline personality disorder) is a psychiatric disorder that severely impacts a person’s ability to regulate their emotions. This loss of emotional control can increase impulsivity, affect how a person feels about themselves, and negatively impact their relationships with others.\n\nBPD ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "symptoms",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              " can include:\n   -Efforts to avoid real or perceived abandonment\n  -A pattern of intense and unstable relationships\n  -A distorted and unstable self-image\n  -Intense and highly variable moods\n\nFor ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "more",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: " information visit ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "this link.",
                          style: TextStyle(
                            color: const Color(0xFFCF726A),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  "https://www.nimh.nih.gov/health/topics/borderline-personality-disorder"); // replace with your website URL
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Would you like to add the events of the BPD Coping Plan to your calendar?",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SourceSans',
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchB', false);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await updateBPDCalendar();
                  addBPDPlan(DateTime.now());
                  await prefs.setBool('switchB', true);
                  setState(() {
                    switchB = true;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    }
  }

  void handleSwitchOChanged(bool value) async {
    if (!value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text("Delete Plan from Calendar"),
            content: const Text(
              "Would you like to delete the events of the OCD Coping Plan from your calendar?",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchO', true);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await deleteOCDCalendar();
                  deleteOCDPlan();
                  await prefs.setBool('switchO', false);
                  setState(() {
                    switchO = false;
                  });
                  Navigator.of(context).pop(); // dismiss dialog
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text("Add Plan to Calendar"),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "OCD",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        const TextSpan(
                          text:
                              " (Obsessive-compulsive disorder) is a disorder in which people have recurring, unwanted thoughts, ideas or sensations (obsessions) that disrupts daily life. To get rid of the thoughts, they feel driven to do something repetitively (compulsions).\n\nOCD ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "symptoms",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              " can include:\n   -Fear of contamination by people or the environment\n   -Religious, often blasphemous, thoughts or fears\n  -Fear of perpetrating aggression or being harmed\n  -Extreme worry something is not complete\n-Fear of losing or discarding something important\n\nFor ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "more",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: " information visit ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SourceSans',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: "this link.",
                          style: TextStyle(
                            color: const Color(0xFFCF726A),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  "https://www.psychiatry.org/patients-families/obsessive-compulsive-disorder/what-is-obsessive-compulsive-disorder"); // replace with your website URL
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Would you like to add the events of the OCD Coping Plan to your calendar?",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SourceSans',
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setBool('switchO', false);
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  await updateOCDCalendar();
                  addOCDPlan(DateTime.now());
                  await prefs.setBool('switchO', true);
                  setState(() {
                    switchO = true;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 65.0,
          left: 25.0,
          right: 25.0,
          bottom: 50.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                'Pick a Coping Plan',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SourceSans',
                  fontSize: 40.0,
                ),
              )),
              const SizedBox(
                height: 13,
              ),
              Container(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    text: ' ',
                    children: [
                      TextSpan(
                        text: 'Disclaimer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            ': These coping plans are mainly meant to be used in conjunction with ongoing treatment by a qualified professional. They are not a replacement for qualified mental health treatment.',
                      ),
                    ],
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'SourceSans',
                    fontSize: 13.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCF726A),
                      minimumSize: const Size(300, 60),
                      maximumSize: const Size(300, 60),
                      elevation: 7.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Depression',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SourceSans',
                        fontSize: 29.0,
                      ),
                    ),
                  ),
                  Switch.adaptive(
                    value: switchD,
                    onChanged: handleSwitchDChanged,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF78BA7D),
                      minimumSize: const Size(300, 60),
                      maximumSize: const Size(300, 60),
                      elevation: 7.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Anxiety',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SourceSans',
                        fontSize: 29.0,
                      ),
                    ),
                  ),
                  Switch.adaptive(
                    value: switchA,
                    onChanged: handleSwitchAChanged,
                  ),
                ],
              ),
              Spacer(),
              Row(children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2FA9C0),
                    minimumSize: const Size(300, 60),
                    maximumSize: const Size(300, 60),
                    elevation: 7.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'PTSD',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SourceSans',
                      fontSize: 29.0,
                    ),
                  ),
                ),
                Switch.adaptive(
                  value: switchP,
                  onChanged: handleSwitchPChanged,
                ),
              ]),
              const Spacer(),
              Row(children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF8B600),
                    minimumSize: const Size(300, 60),
                    maximumSize: const Size(300, 60),
                    elevation: 7.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'BPD',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SourceSans',
                      fontSize: 29.0,
                    ),
                  ),
                ),
                Switch.adaptive(
                  value: switchB,
                  onChanged: handleSwitchBChanged,
                ),
              ]),
              const Spacer(),
              Row(children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C5F99),
                    minimumSize: const Size(300, 60),
                    maximumSize: const Size(300, 60),
                    elevation: 7.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'OCD',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SourceSans',
                      fontSize: 29.0,
                    ),
                  ),
                ),
                Switch.adaptive(
                  value: switchO,
                  onChanged: handleSwitchOChanged,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
