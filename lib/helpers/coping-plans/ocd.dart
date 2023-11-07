import 'package:flutter/material.dart';

import '../../appscreens/copingcalendar_page.dart';

void addOCDPlan(startDate) {
  MyList.meetings.add(Meeting(
    from: startDate,
    to: startDate.add(const Duration(hours: 1)),
    eventName: 'Journal, PEMS',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 1)),
    to: startDate.add(const Duration(days: 1, hours: 1)),
    eventName: 'Affirmations',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 2)),
    to: startDate.add(const Duration(days: 2, hours: 1)),
    eventName: 'Relaxation, Journal',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 3)),
    to: startDate.add(const Duration(days: 3, hours: 1)),
    eventName: 'Rejuvation',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 4)),
    to: startDate.add(const Duration(days: 4, hours: 1)),
    eventName: 'Journal, PEMS',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 5)),
    to: startDate.add(const Duration(days: 5, hours: 1)),
    eventName: 'Affirmations',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 6)),
    to: startDate.add(const Duration(days: 6, hours: 1)),
    eventName: 'Meditation, Journal',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 7)),
    to: startDate.add(const Duration(days: 7, hours: 1)),
    eventName: 'Rejuvenation',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 8)),
    to: startDate.add(const Duration(days: 8, hours: 1)),
    eventName: 'Relaxation',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 9)),
    to: startDate.add(const Duration(days: 9, hours: 1)),
    eventName: 'Breathing with Purpose',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 10)),
    to: startDate.add(const Duration(days: 10, hours: 1)),
    eventName: 'Cute Animals',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 11)),
    to: startDate.add(const Duration(days: 11, hours: 1)),
    eventName: 'Journal',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 12)),
    to: startDate.add(const Duration(days: 12, hours: 1)),
    eventName: 'Relaxation, PEMS',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 13)),
    to: startDate.add(const Duration(days: 13, hours: 1)),
    eventName: 'Meditation, Journal',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 14)),
    to: startDate.add(const Duration(days: 14, hours: 1)),
    eventName: 'Affirmations, PEMS',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 15)),
    to: startDate.add(const Duration(days: 15, hours: 1)),
    eventName: 'Rejuvenation, Journal',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 16)),
    to: startDate.add(const Duration(days: 16, hours: 1)),
    eventName: 'Breathing with Purpose',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 17)),
    to: startDate.add(const Duration(days: 17, hours: 1)),
    eventName: 'Relaxation, Journal',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 18)),
    to: startDate.add(const Duration(days: 18, hours: 1)),
    eventName: 'Rejuvenation',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 19)),
    to: startDate.add(const Duration(days: 19, hours: 1)),
    eventName: 'Cute Animals, Journal',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 20)),
    to: startDate.add(const Duration(days: 20, hours: 1)),
    eventName: 'Affimrations, PEMS',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 21)),
    to: startDate.add(const Duration(days: 21, hours: 1)),
    eventName: 'Journal, PEMS',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 22)),
    to: startDate.add(const Duration(days: 22, hours: 1)),
    eventName: 'Meditation, Cute Animals',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 23)),
    to: startDate.add(const Duration(days: 23, hours: 1)),
    eventName: 'Breathing with Purpose',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 24)),
    to: startDate.add(const Duration(days: 24, hours: 1)),
    eventName: 'Journal, Affirmations',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 25)),
    to: startDate.add(const Duration(days: 25, hours: 1)),
    eventName: 'PEMS',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 26)),
    to: startDate.add(const Duration(days: 26, hours: 1)),
    eventName: 'Relaxation',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 27)),
    to: startDate.add(const Duration(days: 27, hours: 1)),
    eventName: 'Journal',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 28)),
    to: startDate.add(const Duration(days: 28, hours: 1)),
    eventName: 'Affirmations, PEMS',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 29)),
    to: startDate.add(const Duration(days: 29, hours: 1)),
    eventName: 'Meditation, Cute Animals',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.meetings.add(Meeting(
    from: startDate.add(Duration(days: 30)),
    to: startDate.add(const Duration(days: 30, hours: 1)),
    eventName: 'Breathing with Purpose, Journal',
    background: const Color(0xFF7C5F99),
    isAllDay: true,
    description: "OCD Coping Plan",
  ));
  MyList.saveMeetings();
}
