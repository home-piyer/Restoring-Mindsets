// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:mojo_perception/mojo_perception.dart';
// import 'package:syncfusion_flutter_core/theme.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';
//
// class EmotionPage extends StatefulWidget {
//   EmotionPage({Key? key}) : super(key: key);
//   static String id = 'emotion-detect';
//   static String auth_token =
//       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2NzM4MzMyMDAsInN1YiI6IjMyLTEtMjAyMy0wMS0xNiAwMTozOTo1OS43NTM2MTkrMDA6MDAiLCJleHAiOjE2NzUwNDI4MDB9.anVd6hL4yaGA4alKvJLYjC4Ag7k03LZBIe1lscg1CQ4';
//
//   MojoPerceptionAPI mojoPerceptionApi =
//       MojoPerceptionAPI(auth_token, 'stream.mojo.ai', '443', 'layai');
//
//   CameraApp() {
//     mojoPerceptionApi.setOptions({
//       "emotions": ["amusement"],
//       "subscribeRealtimeOutput": true
//     });
//   }
//
//   @override
//   State<EmotionPage> createState() => _EmotionPageState();
// }
//
// class _EmotionPageState extends State<EmotionPage> {
//   bool isStopped = false;
//
//   void stopCallback() {
//     setState(() {
//       isStopped = true;
//     });
//   }
//
//   void errorCallback(error) {
//     print("🔴 $error");
//   }
//
//   @override
//   void dispose() {
//     widget.mojoPerceptionApi.stopFacialExpressionRecognitionAPI();
//   }
//
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       widget.mojoPerceptionApi.onStopCallback = stopCallback;
//       widget.mojoPerceptionApi.onErrorCallback = errorCallback;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(
//             top: 60.0, left: 5.0, right: 5.0, bottom: 30.0),
//         child: isStopped
//             ? const Center(child: Text("Session ended"))
//             : FutureBuilder<CameraController?>(
//                 future: widget.mojoPerceptionApi.startCameraAndConnectAPI(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<CameraController?> snapshot) {
//                   if (snapshot.hasData) {
//                     return Center(
//                       child: Stack(
//                         children: [
//                           CameraPreview(
//                               widget.mojoPerceptionApi.cameraController!),
//                           FaceWidget(widget.mojoPerceptionApi),
//                           AmusementWidget(widget.mojoPerceptionApi)
//                         ],
//                       ),
//                     );
//                   } else {
//                     return Container();
//                   }
//                 }),
//       ),
//     );
//   }
// }
//
// class FaceWidget extends StatefulWidget {
//   MojoPerceptionAPI mojoPerceptionApi;
//   FaceWidget(this.mojoPerceptionApi);
//   @override
//   _FaceWidgetState createState() => _FaceWidgetState();
// }
//
// class _FaceWidgetState extends State<FaceWidget> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback(
//         (_) => widget.mojoPerceptionApi.faceDetectedCallback = myCallback);
//   }
//
//   Rect? face;
//   void myCallback(newface) {
//     setState(() {
//       face = newface;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     double _ratio = screenSize.width /
//         widget.mojoPerceptionApi.cameraController!.value.previewSize!.height;
//     return face != null
//         ? CustomPaint(painter: FaceDetectionPainter(face!, _ratio))
//         : Container();
//   }
// }
//
// class FaceDetectionPainter extends CustomPainter {
//   final Rect bbox;
//   final double ratio;
//
//   FaceDetectionPainter(
//     this.bbox,
//     this.ratio,
//   );
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (bbox != Rect.zero) {
//       var paint = Paint()
//         ..color = Colors.blue
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 3;
//
//       Offset topleft = bbox.topLeft * ratio;
//       Offset bottomright = bbox.bottomRight * ratio;
//       canvas.drawRect(Rect.fromPoints(topleft, bottomright), paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
//
// class AmusementWidget extends StatefulWidget {
//   MojoPerceptionAPI mojoPerceptionApi;
//   AmusementWidget(this.mojoPerceptionApi);
//   @override
//   _AmusementWidgetState createState() => _AmusementWidgetState();
// }
//
// class _AmusementWidgetState extends State<AmusementWidget> {
//   double amusementValue = 0;
//   Color amusementColor = Colors.red;
//   String amusementIcon = "😒";
//
//   void amusementCallback(double data) {
//     setState(() {
//       amusementValue = data;
//       if (amusementValue > 0.75) {
//         amusementColor = Colors.green;
//         amusementIcon = "😂";
//       } else if (amusementValue < 0.25) {
//         amusementColor = Colors.red;
//         amusementIcon = "😄";
//       } else {
//         amusementColor = Colors.orange;
//         amusementIcon = "😒";
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback(
//         (_) => widget.mojoPerceptionApi.amusementCallback = amusementCallback);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 400,
//       child: Row(
//         children: [
//           SfSliderTheme(
//             data: SfSliderThemeData(
//                 thumbColor: Colors.white,
//                 thumbRadius: 15,
//                 thumbStrokeWidth: 2,
//                 thumbStrokeColor: amusementColor),
//             child: SfSlider.vertical(
//               activeColor: amusementColor,
//               inactiveColor: Colors.grey,
//               min: 0.0,
//               max: 1,
//               value: amusementValue,
//               interval: 5,
//               enableTooltip: true,
//               minorTicksPerInterval: 2,
//               thumbIcon: Center(
//                   child: Text(
//                 amusementIcon,
//                 style: const TextStyle(fontSize: 20),
//               )),
//               onChanged: (dynamic value) {},
//             ),
//           ),
//           Text(
//             amusementValue.toStringAsFixed(2),
//             style: TextStyle(fontSize: 30, color: amusementColor),
//           )
//         ],
//       ),
//     );
//   }
// }
