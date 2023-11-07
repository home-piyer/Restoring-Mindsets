import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

const kLoginFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xFFFEF4FF),
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const loginButtonColors = Color(0xFFE2CAF1);
const signUpButtonColors = Color(0xFFFFE999);

const kSignupFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xFFFFF8DF),
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kGoalsFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xFFA686C7),
  hintText: 'Short-term Goals',
  hintStyle: TextStyle(color: Colors.white),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kLessonTextDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xFFCF726A),
  hintText: 'Short-term Goals',
  hintStyle: TextStyle(color: Colors.white),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

BubbleStyle blueHomeBubble = const BubbleStyle(
  nip: BubbleNip.rightBottom,
  margin: BubbleEdges.only(top: 10.0, right: 50.0),
  alignment: Alignment.topRight,
);

BubbleStyle greenHomeBubble = const BubbleStyle(
  nip: BubbleNip.leftBottom,
  color: Colors.grey,
  margin: BubbleEdges.only(top: 8.0, right: 50.0),
  alignment: Alignment.topLeft,
);

BubbleStyle shortHomeBubble = const BubbleStyle(
  nip: BubbleNip.leftBottom,
  color: Colors.grey,
  alignment: Alignment.topLeft,
);

BubbleStyle redHomeBubble = const BubbleStyle(
  nip: BubbleNip.no,
  color: Colors.grey,
  margin: BubbleEdges.only(top: 8.0, right: 50.0),
  alignment: Alignment.topLeft,
);
