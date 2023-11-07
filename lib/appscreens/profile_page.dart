import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

Future<String> getDisplayName() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user = await auth.currentUser!;
  if (user.displayName == null) {
    return '______________';
  } else {
    return user.displayName!;
  }
}

Future<String> getSelectedPhoto() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user = await auth.currentUser!;
  if (user.photoURL == null) {
    return '';
  } else {
    return user.photoURL!;
  }
}

class _ProfilePageState extends State<ProfilePage> {
  String nameUpdate = '';
  static const int _count = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 50.0,
          left: 30.0,
          right: 25.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SourceSans',
                fontSize: 35.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Name',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontFamily: 'SourceSans',
                    fontSize: 20.0,
                  ),
                ),
                Row(
                  children: <Widget>[
                    FutureBuilder(
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text(
                              '${snapshot.error} occurred',
                              style: TextStyle(fontFamily: 'SourceSans'),
                            );
                          } else {
                            final data = snapshot.data as String;
                            return Text(
                              data,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'SourceSans',
                                fontSize: 35.0,
                              ),
                            );
                          }
                        }
                        return Text('operation could not be completed');
                      },
                      future: getDisplayName(),
                    ),
                    IconButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("Name"),
                            content: TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                  hintText: 'Please enter your name'),
                              style: TextStyle(fontFamily: 'SourceSans'),
                              onChanged: (value) {
                                nameUpdate = value;
                              },
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                                child: Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final FirebaseAuth auth =
                                      FirebaseAuth.instance;
                                  User user = await auth.currentUser!;
                                  await user.updateDisplayName(nameUpdate);
                                  Navigator.of(ctx).pop(true);
                                  setState(() {});
                                },
                                child: Text("Ok"),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.draw,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            const Text(
              'Pick your avatar',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontFamily: 'SourceSans',
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: _count,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 40.0,
                ),
                itemBuilder: (_, i) {
                  return FutureBuilder(
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text(
                            '${snapshot.error} occurred',
                            style: TextStyle(fontFamily: 'SourceSans'),
                          );
                        } else {
                          final data = snapshot.data as String;
                          if (data == 'assets/profile/${i + 1}.png') {
                            return Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 10, color: Colors.blue),
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  // final FirebaseAuth auth = FirebaseAuth.instance;
                                  // User user = await auth.currentUser!;
                                  // await user
                                  //     .updatePhotoURL('assets/profile/${i + 1}.png');
                                  // setState(() {});
                                },
                                icon:
                                    Image.asset('assets/profile/${i + 1}.png'),
                                iconSize: 45.0,
                              ),
                            );
                          } else {
                            return IconButton(
                              onPressed: () async {
                                final FirebaseAuth auth = FirebaseAuth.instance;
                                User user = await auth.currentUser!;
                                await user.updatePhotoURL(
                                    'assets/profile/${i + 1}.png');
                                setState(() {});
                              },
                              icon: Image.asset('assets/profile/${i + 1}.png'),
                              iconSize: 45.0,
                            );
                          }
                        }
                      }
                      return Text('operation could not be completed');
                    },
                    future: getSelectedPhoto(),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.0,
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
                          ': Restoring Mindsets is mainly meant to be used in conjunction with ongoing treatment by a qualified professional. They are not a replacement for qualified mental health treatment.',
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
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
