import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CuteImagesClass extends StatefulWidget {
  @override
  State<CuteImagesClass> createState() => _CuteImagesClassState();
}

class _CuteImagesClassState extends State<CuteImagesClass> {
  var _catApiUrl = 'https://api.thecatapi.com/v1/images/search?limit=75';
  var _dogApiUrl = 'https://api.thedogapi.com/v1/images/search?limit=75';
  List<String> _imageUrls = [];

  Future<void> makeRequests() async {
    final catResponse = await http.get(Uri.parse(_catApiUrl));
    final dogResponse = await http.get(Uri.parse(_dogApiUrl));

    final catData = json.decode(catResponse.body) as List<dynamic>;
    final dogData = json.decode(dogResponse.body) as List<dynamic>;

    final catUrls = catData.map((e) => e['url'].toString()).toList();
    final dogUrls = dogData.map((e) => e['url'].toString()).toList();

    setState(() {
      _imageUrls = List.from(catUrls)..addAll(dogUrls);
      _imageUrls.shuffle();
    });
  }

  @override
  void initState() {
    super.initState();
    makeRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Cute Animals',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SourceSans',
                fontSize: 35.0,
              ),
            ),
            Expanded(
              child: _imageUrls.isNotEmpty
                  ? GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _imageUrls.length,
                      itemBuilder: (ctx, index) => Image.network(
                        _imageUrls[index],
                        fit: BoxFit.cover,
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ])),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.refresh),
        backgroundColor: Color(0xFF6AA16E),
        onPressed: () {
          makeRequests();
        },
      ),
    );
  }
}
