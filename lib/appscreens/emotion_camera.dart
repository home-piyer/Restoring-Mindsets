import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import 'package:ncc/helpers/color-goals.dart';
import 'dart:convert';
import 'dart:io';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:ncc/appscreens/landing_page.dart';
import 'dart:typed_data'; // Import the typed_data package for ByteData

class EmotionCamera extends StatefulWidget {
  final CameraDescription camera;

  const EmotionCamera({Key? key, required this.camera}) : super(key: key);

  @override
  _EmotionCameraState createState() => _EmotionCameraState();
}

class _EmotionCameraState extends State<EmotionCamera> {
  late CameraController _controller;
  bool _isProcessing = false;
  File? _processedImageFile; // New variable to hold the processed square image
  // ignore: prefer_typing_uninitialized_variables
  var classificationResult;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Define the model endpoint and authorization token
  static const String modelEndpoint =
      "https://rahulsinghpundir-facial-expression.hf.space/run/predict";
  static const String authorizationToken =
      "Bearer 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";

  Future<void> _captureAndProcessImage() async {
    if (!_controller.value.isInitialized) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    final XFile file = await _controller.takePicture();

    final img.Image image = img.decodeImage(File(file.path).readAsBytesSync())!;
    final img.Image bwImage = img.grayscale(image);

    // Calculate the cropping coordinates to match the blue box decoration
    final double boxWidthFactor = 0.65;
    final double boxHeightFactor = 0.4;
    final int boxWidth = (boxWidthFactor * bwImage.width).toInt();
    final int boxHeight = (boxHeightFactor * bwImage.height).toInt();
    final int boxX = (bwImage.width - boxWidth) ~/ 2;
    final int boxY = (bwImage.height - boxHeight) ~/ 2;

    final img.Image squareImage = img.copyCrop(
      bwImage,
      x: boxX,
      y: boxY,
      width: boxWidth,
      height: boxHeight,
    );
    // Save the processed square image as a .png file
    _processedImageFile = File(file.path.replaceAll('.jpg', '_sq.png'))
      ..writeAsBytesSync(img.encodePng(squareImage));

    if (kDebugMode) {
      print('before');
    }

// Read the processed image file into bytes
    final List<int> processedImageBytes =
        File(_processedImageFile!.path).readAsBytesSync();

// Encode the processed image bytes as base64
    final String processedImageBase64 = base64Encode(processedImageBytes);

// // Load the image from your assets
//     final ByteData data = await rootBundle.load('assets/image.png');
//     final List<int> processedImageBytes = data.buffer.asUint8List();

//     // Encode the processed image bytes as base64
//     final String processedImageBase64 = base64Encode(processedImageBytes);

    final response = await http.post(
      Uri.parse(modelEndpoint), // Use the defined model endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationToken, // Set the authorization header
      },
      body: jsonEncode(<String, List<String>>{
        'data': [processedImageBase64]
      }),
    );
    if (response.statusCode == 200) {
      // If the server returned a 200 OK response, decode the result
      classificationResult = jsonDecode(response.body)["data"][0];
      if (kDebugMode) {
        print(classificationResult);
      }
    } else {
      final r = response.statusCode;
      // If the server did not return a 200 OK response, throw an exception.
      if (kDebugMode) {
        print('error$r');
      }
    }

    if (kDebugMode) {
      print('after');
    }

    setState(() {
      _isProcessing = false;
    });

    _navigateToLandingPage();
  }

  void _navigateToLandingPage() {
    if (classificationResult.startsWith("data:image/png;base64,")) {
      // Remove the prefix
      classificationResult =
          classificationResult.substring("data:image/png;base64,".length);
    }

    // Convert the modified result string (base64-encoded image) to bytes
    List<int> imageBytes = base64.decode(classificationResult);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            title: const Center(child: Text('Manage Your Emotions!')),
            content: IntrinsicHeight(
              child: Column(
                children: [
                  // Display the image
                  Image.memory(Uint8List.fromList(imageBytes)),
                  const SizedBox(
                    height: 10.0,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Based on your emotion, try activities such as Guided Meditation, Guided Relaxation, or Breathing with Purpose in the ',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                        TextSpan(
                          text: 'Activities',
                          style: const TextStyle(
                            color: Color(0xFFCF726A),
                            fontSize: 18.0,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              Navigator.of(context).pop();
                              await pushNewScreenWithRouteSettings(
                                context,
                                settings:
                                    const RouteSettings(name: LandingPage.id),
                                screen: const LandingPage(
                                  initialIndex: 1,
                                ),
                              );
                            },
                        ),
                        TextSpan(
                          text:
                              ' section of Restoring Mindsets to calm your nerves and slow down your heart rate. Go out for a breath of fresh air, take a break, and focus on your self-care!',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Image.asset('assets/images/backButton.png'),
                onPressed: () {
                  Navigator.of(context).pop();
                  pushNewScreenWithRouteSettings(
                    context,
                    settings: const RouteSettings(name: LandingPage.id),
                    screen: const LandingPage(
                      initialIndex: 0,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    final bool isImageProcessed = _processedImageFile != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Emotion Detection!"),
        backgroundColor: tdGrey,
      ),
      body: Stack(
        children: <Widget>[
          if (isImageProcessed) // Display the processed square image
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.file(
                      _processedImageFile!,
                    ), // Display the captured image
                  ],
                ),
              ),
            ) // Display the processed square image
          else
            Positioned.fill(
              child: CameraPreview(
                  _controller), // Camera preview takes up the whole screen
            ),
          if (!isImageProcessed)
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: tdGrey,
                    width: 2.0,
                  ),
                ),
                child: const FractionallySizedBox(
                  widthFactor: 0.65, // Set the size of the square overlay
                  heightFactor: 0.4,
                ),
              ),
            ),
          Positioned(
            bottom: 16, // Adjust the position of the button as needed
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 64, // Set the size of the circular button
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // Background color of the button
                ),
                child: FloatingActionButton(
                  onPressed: _isProcessing ? null : _captureAndProcessImage,
                  backgroundColor: Colors.transparent,
                  child: _isProcessing
                      ? CircularProgressIndicator(
                          color: tdBlack) // Loading icon while processing
                      : Icon(
                          Icons.arrow_forward,
                          color: tdBlack, // Arrow color
                        ), // Arrow icon for capture
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: null, // Hide the button when an image is displayed
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
