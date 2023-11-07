import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class AudioClass extends StatefulWidget {
  String url = '';
  int toolNum = 1;
  AudioClass(this.url, this.toolNum, {Key? key}) : super(key: key);
  @override
  State<AudioClass> createState() => _AudioClassState();
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}

class _AudioClassState extends State<AudioClass> {
  String toolName = "";
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          position = newPosition;
        });
      }
    });
  }

  Future setAudio() async {
    await audioPlayer.play(UrlSource(widget.url));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: IconButton(
                //     onPressed: () {
                //       // Navigator.of(context).popUntil((route) {
                //       //   return route.settings.name == 'home_page';
                //       // });
                //       Navigator.of(context).pushNamedAndRemoveUntil(
                //           LandingPage.id, (Route<dynamic> route) => false);
                //       // pushNewScreen(context, screen: screen)
                //     },
                //     icon: Icon(Icons.arrow_back_ios),
                //     iconSize: 40,
                //   ),
                // ),
                const SizedBox(
                  height: 20.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/activities/${widget.toolNum + 1}.png',
                    width: double.infinity,
                    height: 300.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Text(
                  '$toolName',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'SourceSans',
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Heartfulness Institute',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Slider(
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await audioPlayer.seek(position);

                    await audioPlayer.resume();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(formatTime(position)),
                      Text(formatTime(duration)),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    iconSize: 50,
                    onPressed: () async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                      } else {
                        await audioPlayer.resume();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
