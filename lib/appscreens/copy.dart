import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ncc/appscreens/copingplans_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:ncc/helpers/achievements-helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../authentication.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class copingCalendar extends StatefulWidget {
  const copingCalendar({Key? key}) : super(key: key);
  static String id = 'calendar-page';

  @override
  State<copingCalendar> createState() => _copingCalendarState();
}

class MyList {
  static List<Meeting> meetings = <Meeting>[];

  static const _kMeetingsKey = 'meetings';

  static Future<void> loadMeetings() async {
    final prefs = await SharedPreferences.getInstance();
    final meetingsData = prefs.getString(_kMeetingsKey);
    if (meetingsData != null) {
      meetings = (json.decode(meetingsData) as List<dynamic>)
          .map((e) => Meeting.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  static Future<void> saveMeetings() async {
    final prefs = await SharedPreferences.getInstance();
    final meetingsData = json.encode(meetings.map((e) => e.toJson()).toList());
    await prefs.setString(_kMeetingsKey, meetingsData);
  }
}

class _copingCalendarState extends State<copingCalendar> {
  MeetingDataSource? events;
  bool eventsFetched = false;
  int numDays = 31;

  Future<void> scheduleNotifications() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    final List<Meeting> meetings = MyList.meetings;

    for (Meeting meeting in meetings) {
      if (DateTime.now().isBefore(meeting.from)) {
        final String title = 'Visit ${meeting.eventName}!';
        final String body =
            'Remember to visit the activity for ${meeting.eventName} for your ${meeting.description}.';
        final int id = meetings.indexOf(meeting);

        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails('1', 'Upcoming Meetings', 'Reminder',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
                playSound: true,
                enableVibration: true,
                styleInformation: BigTextStyleInformation(''),
                largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
                color: Colors.blueAccent);

        final IOSNotificationDetails iOSPlatformChannelSpecifics =
            IOSNotificationDetails(presentSound: true);

        final NotificationDetails platformChannelSpecifics =
            NotificationDetails(
                android: androidPlatformChannelSpecifics,
                iOS: iOSPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.schedule(
          id,
          title,
          body,
          meeting.from,
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    MyList.loadMeetings();
    MyList.meetings = <Meeting>[];
    setEvents();
    scheduleNotifications();
  }

  Future<void> setEvents() async {
    events = await _getCalendarDataSource();
    setState(() {
      eventsFetched = true;
    });
  }

  Widget displayPage(bool fetchEvents) {
    if (fetchEvents) {
      return (Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF93D1DE),
          actions: [
            IconButton(
              onPressed: () {
                pushNewScreenWithRouteSettings(context,
                    settings: const RouteSettings(name: 'copingPlans'),
                    screen: const copingPlansPage(),
                    withNavBar: true);
              },
              icon: const Icon(
                Icons.add_box,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 500,
              child: SfCalendar(
                view: CalendarView.month,
                allowedViews: const [
                  CalendarView.day,
                  CalendarView.week,
                  CalendarView.workWeek,
                  CalendarView.month,
                  CalendarView.timelineDay,
                  CalendarView.timelineWeek,
                  CalendarView.timelineWorkWeek,
                ],
                initialSelectedDate: DateTime.now(),
                monthViewSettings: const MonthViewSettings(showAgenda: true),
                dataSource: events,
                onTap: calendarTapped,
              ),
            ),
          ],
        ),
      ));
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (guestLogin) {
      Future.delayed(Duration.zero, () => showGuestLoginAlert(context));
    }

    return VisibilityDetector(
      key: Key(copingCalendar.id),
      onVisibilityChanged: (VisibilityInfo info) {
        bool isVisible = info.visibleFraction != 0;
        if (isVisible == true) {
          eventsFetched = false;
          setEvents();
        }
      },
      child: displayPage(eventsFetched),
    );
  }

  bool eventsAddedD = false;
  bool eventsAddedA = false;
  bool eventsAddedP = false;
  bool eventsAddedB = false;
  bool eventsAddedO = false;

  Future<MeetingDataSource> _getCalendarDataSource() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final ref = FirebaseDatabase.instance.ref();
    final User? user = auth.currentUser;
    final uid = user?.uid;
    final snapshotD = await ref.child('users/$uid/depression-calendar').get();
    final startDateD = await ref.child('users/$uid/depression-sd').get();
    final snapshotA = await ref.child('users/$uid/anxiety-calendar').get();
    final startDateA = await ref.child('users/$uid/anxiety-sd').get();
    final snapshotP = await ref.child('users/$uid/ptsd-calendar').get();
    final startDateP = await ref.child('users/$uid/ptsd-sd').get();
    final snapshotB = await ref.child('users/$uid/bpd-calendar').get();
    final startDateB = await ref.child('users/$uid/bpd-sd').get();
    final snapshotO = await ref.child('users/$uid/ocd-calendar').get();
    final startDateO = await ref.child('users/$uid/ocd-sd').get();
    if (snapshotD.exists) {
      if (snapshotD.value == true) {
        if (!eventsAddedD) {
          DateTime startDate = DateTime.parse(startDateD.value as String);
          DateTime endDate = startDate.add(Duration(days: numDays - 1));
          DateTime currentDate = DateTime.now();
          eventsAddedD = true;
          if (currentDate.isAfter(endDate)) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('31-day depression coping plan completed'),
                  content: Text(
                      'Do you want to repeat the depression coping plan for the next 31 days?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Yes'),
                      onPressed: () async {
                        await updateDepressionCalendar();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      } else if (snapshotD.value == false) {
        if (eventsAddedD) {
          deleteDepressionPlan();
          eventsAddedD = false;
        }
      }
    } else {
      if (kDebugMode) {
        print("error-D");
      }
    }
    if (snapshotA.exists) {
      if (snapshotA.value == true) {
        if (!eventsAddedA) {
          DateTime startDate = DateTime.parse(startDateA.value as String);
          DateTime endDate = startDate.add(Duration(days: numDays - 1));
          DateTime currentDate = DateTime.now();
          eventsAddedA = true;
          if (currentDate.isAfter(endDate)) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('31-day anxiety coping plan completed'),
                  content: Text(
                      'Do you want to repeat the anxiety coping plan for the next 31 days?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Yes'),
                      onPressed: () async {
                        await updateAnxietyCalendar();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      } else if (snapshotA.value == false) {
        if (eventsAddedA) {
          deleteAnxietyPlan();
          eventsAddedA = false;
        }
      }
    } else {
      if (kDebugMode) {
        print("error-A");
      }
    }
    if (snapshotP.exists) {
      if (snapshotP.value == true) {
        if (!eventsAddedP) {
          DateTime startDate = DateTime.parse(startDateP.value as String);
          DateTime endDate = startDate.add(Duration(days: numDays - 1));
          DateTime currentDate = DateTime.now();
          eventsAddedP = true;
          if (currentDate.isAfter(endDate)) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('31-day PTSD coping plan completed'),
                  content: Text(
                      'Do you want to repeat the PTSD coping plan for the next 31 days?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Yes'),
                      onPressed: () async {
                        await updatePTSDCalendar();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      } else if (snapshotP.value == false) {
        if (eventsAddedP) {
          deletePTSDPlan();
          eventsAddedP = false;
        }
      }
    } else {
      if (kDebugMode) {
        print("error-P");
      }
    }
    if (snapshotB.exists) {
      if (snapshotB.value == true) {
        if (!eventsAddedB) {
          DateTime startDate = DateTime.parse(startDateB.value as String);
          DateTime endDate = startDate.add(Duration(days: numDays - 1));
          DateTime currentDate = DateTime.now();
          eventsAddedB = true;
          if (currentDate.isAfter(endDate)) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('31-day BPD coping plan completed'),
                  content: Text(
                      'Do you want to repeat the BPD coping plan for the next 31 days?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Yes'),
                      onPressed: () async {
                        await updateBPDCalendar();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      } else if (snapshotB.value == false) {
        if (eventsAddedB) {
          deleteBPDPlan();
          eventsAddedB = false;
        }
      }
    } else {
      if (kDebugMode) {
        print("error-B");
      }
    }
    if (snapshotO.exists) {
      if (snapshotO.value == true) {
        if (!eventsAddedO) {
          DateTime startDate = DateTime.parse(startDateO.value as String);
          DateTime endDate = startDate.add(Duration(days: numDays - 1));
          DateTime currentDate = DateTime.now();
          eventsAddedO = true;
          if (currentDate.isAfter(endDate)) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('31-day OCD coping plan completed'),
                  content: Text(
                      'Do you want to repeat the OCD coping plan for the next 31 days?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Yes'),
                      onPressed: () async {
                        await updateOCDCalendar();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      } else if (snapshotO.value == false) {
        if (eventsAddedO) {
          deleteOCDPlan();
          eventsAddedO = false;
        }
      }
    } else {
      if (kDebugMode) {
        print("error-O");
      }
    }
    return MeetingDataSource(MyList.meetings);
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

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.agenda ||
        calendarTapDetails.targetElement == CalendarElement.appointment) {}
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(this.source);

  List<Meeting> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  @override
  String getStartTimeZone(int index) {
    return source[index].startTimeZone;
  }

  @override
  String getEndTimeZone(int index) {
    return source[index].endTimeZone;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }
}

class Meeting {
  Meeting(
      {required this.from,
      required this.to,
      this.background = Colors.green,
      this.isAllDay = false,
      this.eventName = '',
      this.startTimeZone = '',
      this.endTimeZone = '',
      this.description = ''});

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
  final String startTimeZone;
  final String endTimeZone;
  final String description;

  Map<String, dynamic> toJson() {
    return {
      'eventName': eventName,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'background': background.value,
      'isAllDay': isAllDay,
      'startTimeZone': startTimeZone,
      'endTimeZone': endTimeZone,
      'description': description,
    };
  }

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      eventName: json['eventName'] ?? '',
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      background: Color(json['background']),
      isAllDay: json['isAllDay'] ?? false,
      startTimeZone: json['startTimeZone'] ?? '',
      endTimeZone: json['endTimeZone'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
