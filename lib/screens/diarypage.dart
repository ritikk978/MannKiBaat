import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:mannkibaat/screens/recommendation.dart';
import 'package:mannkibaat/screens/registerationpage.dart';
import 'package:mannkibaat/widgets/Button.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'homepage.dart';

class DiaryPage extends StatefulWidget {
  static const String id = 'diarypage';

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {

  var shareYourDay = TextEditingController();
  DateTime now = new DateTime.now();

  var _controller = TextEditingController();

  String month = '';
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'ritik': HighlightedWord(
      onTap: () => print('Ritik(CoolBoi)'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'Samriddhi': HighlightedWord(
      onTap: () => print('Samridhi(Gadhi)'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'gitansh': HighlightedWord(
      onTap: () => print('geetansh(Gadha)'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  bool help = false;
  bool isPress = false;
  var _emotion = '';
  void check(var text) async {
    var url = 'https://kmbclyc05b.execute-api.us-east-1.amazonaws.com/dev';
    var response = await http.post(url, body: json.encode({'Text': text}));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var JSONresponse = json.decode(response.body);
    setState(() {
      _emotion = JSONresponse["Response1"]["Sentiment"];
    });
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecommendationPage(response: JSONresponse),
        ));
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();

    // check();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: AvatarGlow(
            animate: _isListening,
            glowColor: Theme.of(context).primaryColor,
            endRadius: 75.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: Column(
              children: [
                Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        if (isPress)
                          isPress = false;
                        else
                          isPress = true;
                        _listen();
                      },
                      child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    ),
                    Button(
                      title: 'Save',
                          color: Colors.red,
                      onPressed: () async {
                        check(_controller.text);
                        // Navigator.pushNamedAndRemoveUntil(context, RecommendationPage.id, (route) => false);


                    }
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextFormField(
                      controller: _controller,
                      maxLines: 13,
                      decoration: InputDecoration(
                        labelText: 'Share your day',
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(25.0))),
                      ),
                    ),
                    height: 300,
                    width: 350,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0),
                //   child: Text(
                //     'Previous Entries',
                //     textAlign: TextAlign.start,
                //     style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.blueAccent),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   children: [
                //     Container(
                //
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(5),
                //           image: DecorationImage(
                //               image: AssetImage('images/stickyNotes.png')
                //           )
                //       ),
                //       height: 90,
                //       width: 110,
                //       child: Center(
                //           child: Text(
                //             '${now.day} Feb',
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.black,
                //                 fontSize: 18),
                //           )),
                //     ),
                //     Container(
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(5),
                //           image: DecorationImage(
                //               image: AssetImage('images/stickyNotes.png')
                //           )
                //       ),
                //       height: 90,
                //       width: 110,
                //       child: Center(
                //         child: Text(
                //           '${now.day - 1} Feb',
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               color: Colors.black,
                //               fontSize: 18),
                //         ),
                //       ),
                //     ),
                //
                //     Container(
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(5),
                //           image: DecorationImage(
                //               image: AssetImage('images/stickyNotes.png')
                //           )
                //       ),
                //       height: 90,
                //       width: 110,
                //       child: Center(
                //         child: Text('${now.day - 2} Feb',
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.black,
                //                 fontSize: 18)),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                //
                //
                //
                // ////////////////////////////////////////////
                // Text(
                //   'Recommendations',
                //   textAlign: TextAlign.start,
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.blueAccent),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   children: [
                //     Container(
                //
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(5),
                //           image: DecorationImage(
                //               image: AssetImage('images/stickyNotes.png')
                //           )
                //       ),
                //       height: 90,
                //       width: 110,
                //       child: Center(
                //           child: Text(
                //             '${now.day} Feb',
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.black,
                //                 fontSize: 18),
                //           )),
                //     ),
                //     Container(
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(5),
                //           image: DecorationImage(
                //               image: AssetImage('images/stickyNotes.png')
                //           )
                //       ),
                //       height: 90,
                //       width: 110,
                //       child: Center(
                //         child: Text(
                //           '${now.day - 1} Feb',
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               color: Colors.black,
                //               fontSize: 18),
                //         ),
                //       ),
                //     ),
                //
                //     Container(
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(5),
                //           image: DecorationImage(
                //               image: AssetImage('images/stickyNotes.png')
                //           )
                //       ),
                //       height: 90,
                //       width: 110,
                //       child: Center(
                //         child: Text('${now.day - 2} Feb',
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.black,
                //                 fontSize: 18)),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    // bool help = false;
    bool must = true;
    if (!isPress) {
      print("1");
      _speech.stop();
      must = false;
      setState(() => _isListening = false);
    } else if ((!_isListening || help) && must) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          if (val == "notListening") {
            print("hi");
            // if ( )
            _speech.stop();

            Future.delayed(const Duration(milliseconds: 500), () {
              print("2");
              help = true;
              _listen();
            });
          }
          print('onStatus: $val');
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _controller.text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}