import 'package:bubble/bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ncc/constants.dart';
import 'package:ncc/helpers/api-helper.dart';
import 'package:ncc/helpers/affirmations-helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ncc/helpers/quote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication.dart';
import '../helpers/color-goals.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

Future<JokesModel> fetchRandomJoke() async {
  final response = await http
      .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
  if (response.statusCode == 200) {
    final jsonJokes = jsonDecode(response.body);
    return JokesModel.fromJson(jsonJokes);
  } else {
    throw Exception('Failed');
  }
}

Future<AffirmationsModel> fetchAffirmations() async {
  final response = await http.get(Uri.parse('https://www.affirmations.dev/'));
  if (response.statusCode == 200) {
    final jsonAffirmations = jsonDecode(response.body);
    return AffirmationsModel.fromJson(jsonAffirmations);
  } else {
    throw Exception('Failed');
  }
}

Future<Quote> fetchQuote() async {
  final response = await http.get(Uri.parse('https://zenquotes.io/api/random'));

  if (response.statusCode == 200) {
    return Quote.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load Quote');
  }
}

class _homePageState extends State<homePage> {
  Map<String, bool> checkboxValues = {};
  late SharedPreferences prefs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String input = "";

  createTodos() async {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("users/$uid/MyTodos").doc(input);

    //Map
    Map<String, dynamic> todos = {
      "todoTitle": input,
      "timestamp": DateTime.now()
    };

    await documentReference.set(todos).whenComplete(() {
      print("$input created");
    });
  }

  deleteTodos(item) async {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("users/$uid/MyTodos").doc(item);

    await documentReference.delete().whenComplete(() {
      print("$item deleted");
    });
  }

  late Future<AffirmationsModel> _futureAffirmationsModel;
  late Future<Quote> quote;
  late Future<JokesModel> _futureJokesModel;

  void initState() {
    super.initState();
    initPrefs();

    _futureJokesModel = fetchRandomJoke();
    _futureAffirmationsModel = fetchAffirmations();
    quote = fetchQuote();
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      // initialize checkbox values from saved prefs
      checkboxValues = Map<String, bool>.from(
        prefs.getString("checkboxValues") != null
            ? Map<String, dynamic>.from(
                json.decode(prefs.getString("checkboxValues")!))
            : {},
      );
    });
  }

  void savePrefs() {
    // save checkbox values to prefs
    prefs.setString("checkboxValues", json.encode(checkboxValues));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Home',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SourceSans',
                  fontSize: 35.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: <Widget>[
                  Row(children: [
                    Bubble(
                        elevation: 8.0,
                        color: Color(0xFFA686C7),
                        padding: BubbleEdges.all(12),
                        style: shortHomeBubble,
                        alignment: Alignment.center,
                        child: Text(
                          'Short-term Goals',
                          style: TextStyle(
                            color: (Colors.white),
                            fontFamily: 'SourceSans',
                            fontSize: 22.0,
                          ),
                        )),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '+',
                          style: TextStyle(
                            color: (Colors.white),
                            fontFamily: 'SourceSans',
                            fontSize: 32,
                          ),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  title: Text("Add Short-term Goal"),
                                  insetPadding: EdgeInsets.zero,
                                  content: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: tdPurple, width: 5.0)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: tdPurple)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: tdPurple))),
                                    onChanged: (String value) {
                                      input = value;
                                    },
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    tdPurple)),
                                        onPressed: () {
                                          // setState((){
                                          //   todos.add(input);
                                          // });
                                          createTodos();
                                          Navigator.of(context)
                                              .pop(); // closes the dialog
                                        },
                                        child: Text("Add"))
                                  ]);
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: tdPurple,
                        minimumSize: Size(40, 45),
                        elevation: 8,
                      ),
                    ),
                  ]),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(_auth.currentUser!
                            .uid) // get the uid of the current user
                        .collection("MyTodos")
                        .orderBy("timestamp", descending: false)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (guestLogin) {
                        return const Center(
                            child: Text(
                                'Please login to access Short-term Goals'));
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Loading'));
                      }
                      final reversedList = snapshot.data!.docs.reversed
                          .toList(); // reverse the list
                      return StatefulBuilder(builder: (context, innerState) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: reversedList.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot =
                                reversedList[index];
                            final todoTitle = documentSnapshot["todoTitle"];
                            if (!checkboxValues.containsKey(todoTitle)) {
                              checkboxValues[todoTitle] =
                                  false; // initialize checkbox value to false
                            }
                            final textDecoration = checkboxValues[todoTitle]!
                                ? TextDecoration.lineThrough
                                : TextDecoration.none;
                            return Dismissible(
                              onDismissed: (direction) {
                                setState(() {
                                  deleteTodos(todoTitle);
                                  checkboxValues.remove(
                                      todoTitle); // remove checkbox value from map
                                  savePrefs(); // save checkbox values to prefs after deletion
                                });
                              },
                              key: Key(todoTitle),
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.fromLTRB(2, 10, 17, 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: CheckboxListTile(
                                  activeColor: tdPurple,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 7, 0, 7),
                                  value: checkboxValues[
                                      todoTitle], // use map to get checkbox value
                                  onChanged: (value) {
                                    setState(() {
                                      checkboxValues[todoTitle] =
                                          value!; // update checkbox value in map
                                      savePrefs();
                                    });
                                  },
                                  title: Text(
                                    todoTitle,
                                    style:
                                        TextStyle(decoration: textDecoration),
                                  ),
                                  secondary: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: tdPurple),
                                    onPressed: () {
                                      setState(() {
                                        deleteTodos(todoTitle);
                                        checkboxValues.remove(
                                            todoTitle); // remove checkbox value from map
                                        savePrefs(); // save checkbox values to prefs after deletion
                                      });
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      });
                    },
                  ),
                  const SizedBox(
                    height: 17.0,
                  ),
                  Bubble(
                    elevation: 8.0,
                    color: Color(0xFF2FA9C0),
                    padding: BubbleEdges.all(10),
                    style: blueHomeBubble,
                    alignment: Alignment.topRight,
                    child: FutureBuilder<JokesModel>(
                      future: _futureJokesModel,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Text(
                            'Daily Laughs\n'
                            '${snapshot.data?.joke}\n'
                            '${snapshot.data?.jokes}',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SourceSans',
                              fontSize: 20.0,
                            ),
                          );
                        } else {
                          return Text(
                            "${snapshot.error}",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SourceSans',
                              fontSize: 20.0,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Bubble(
                    elevation: 8.0,
                    color: Color(0xFF78BA7D),
                    padding: BubbleEdges.all(10),
                    style: greenHomeBubble,
                    child: FutureBuilder<AffirmationsModel>(
                      future: _futureAffirmationsModel,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Text(
                            'Daily Affirmation\n'
                            '${snapshot.data?.affirmation}',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SourceSans',
                              fontSize: 20.0,
                            ),
                          );
                        } else {
                          return Text(
                            "${snapshot.error}",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SourceSans',
                              fontSize: 20.0,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Bubble(
                    color: Color(0xFF2FA9C0),
                    elevation: 8.0,
                    padding: BubbleEdges.all(10),
                    style: blueHomeBubble,
                    child: const Text(
                      'Compliment a stranger!',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SourceSans',
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  const Center(
                    child: Text(
                      'Quote of the day',
                      style: TextStyle(
                        color: Color(0xFFCF726A),
                        fontFamily: 'SourceSans',
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  FutureBuilder<Quote>(
                    future: quote,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                            child: Bubble(
                          alignment: Alignment.center,
                          color: const Color(0xFFCF726A),
                          elevation: 8.0,
                          padding: const BubbleEdges.all(10),
                          style: redHomeBubble,
                          child: Center(
                            child: Text(
                              snapshot.data!.quoteText['q'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'SourceSans',
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ));
                      } else {
                        return Text("${snapshot.error}");
                      }
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Center(
                  child: Text(
                    'If you ever need help or someone to talk to call 1-800-273-TALK (8255) or text MHA to 741741',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SourceSans',
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
