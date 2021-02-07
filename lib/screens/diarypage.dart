import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:mannkibaat/screens/recommendation.dart';
import 'package:mannkibaat/screens/registerationpage.dart';
import 'package:mannkibaat/widgets/Button.dart';
import 'package:mannkibaat/widgets/ProgressDialog.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'homepage.dart';
import 'listingPage.dart';

class DiaryPage extends StatefulWidget {
  static const String id = 'diarypage';

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          Button(
            title: 'No',
            color: Color(0xFF167F67),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          Button(
            title: 'Yes',
            color: Color(0xFF167F67),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    ) ??
        false;
  }

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
    var response = await http.post(url, body: json.encode({'Text': text + "."}));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var JSONresponse = json.decode(response.body);
    setState(() {
      _emotion = JSONresponse["Response1"]["Sentiment"];
    });
    _speech.stop();
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
    var dateEntry = [
      "I faced wi-fi connectivity issues again today. The best part of the day was when she gave me a compliment after my presentation. I think what I felt 2 days ago was real...it might just happen, omg!!",
      "Oof! Watta boring day, thinks didn't go well and on top of that my boss was in a bad mood. Its hard to keep the spirits up:'(",
      "I had a really exciting conversion today...I think I found her:)",
      "Yaar Connectivity issues again...I think I did a mistake by shifting to this town. I might reconsider my decision...",
      "Now time to start work from my dear home...I don't know whether I am happy or sad but I want to try this out 0(",
      "Guess where I am? I am in the middle of country side farms but not on leave. Let see if we can 'Get a Life' here or not :/",
    ];

    void display(var date, int i){
      setState(() {
        _controller.text = "Dear Diary,\n$date th Feb, 2021\n\n${dateEntry[i]}";
      });
    }
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(

        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(
              child: Text(
                'Smart Diary',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(
                      context, ListingPage.id, (route) => false);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                              alignment: Alignment.center,
          child: Text('Listing', style: TextStyle(color: Colors.black))),
                        ),

                        Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blue,

                                          blurRadius: 1,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(Icons.location_pin, color: Colors.black, size: 30,),
                                    )))),
                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
          resizeToAvoidBottomInset: false,
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton:
          body: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15, 10.0, 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/background.jpeg'),
                        fit: BoxFit.fill
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 23.0),
                      child: TextField(
                        controller: _controller,
                        maxLines: 13,
                        decoration: InputDecoration(
                          // labelText: 'Dear Diary',

                          hintText: 'Speak your mind or type it out...you can also try the Previous Entries. Then just tap on "Get me Something" and we will get it for you:)',
                          border: OutlineInputBorder(

                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0))),
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,


                        ),

                      ),
                    ),
                    height: 300,
                    width: 350,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  height: 60,
                  width: 50,
                  child: AvatarGlow(

                  animate: _isListening,
                  glowColor: Colors.red,
                  endRadius: 180.0,
                  duration: const Duration(milliseconds: 2000),
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  repeat: true,
                  child:
                          InkWell(
                            onTap: (){
                                if (isPress)
                                  isPress = false;
                                else
                                  isPress = true;
                                _listen();

                            },
                            child: Icon(_isListening ? Icons.mic : Icons.mic_none, size: 45,),

                          ),



                ),),
                SizedBox(height: 5,),

                RaisedButton(
                  child: Text('Get me something', style: TextStyle(color: Colors.white),),
                  color: Colors.red,
                    onPressed: () async {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => ProgressDialog(status: "Something interesting's cooking",));
                      check(_controller.text);
                    }
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Previous Entries',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          display(now.day, 0);
                        },
                        child: Container(

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: AssetImage('images/stickyNotes.png')
                              )
                          ),
                          height: 90,
                          width: 110,
                          child: Center(
                              child: Text(
                                '${now.day} Feb',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18),
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          display(now.day-1, 1);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: AssetImage('images/stickyNotes.png')
                              )
                          ),
                          height: 90,
                          width: 110,
                          child: Center(
                            child: Text(
                              '${now.day - 1} Feb',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          display(now.day-2, 2);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: AssetImage('images/stickyNotes.png')
                              )
                          ),
                          height: 90,
                          width: 110,
                          child: Center(
                            child: Text('${now.day - 2} Feb',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        display(now.day-3, 3);
                      },
                      child: Container(

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: AssetImage('images/stickyNotes.png')
                            )
                        ),
                        height: 90,
                        width: 110,
                        child: Center(
                            child: Text(
                              '${now.day-3} Feb',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18),
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        display(now.day-4, 4);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: AssetImage('images/stickyNotes.png')
                            )
                        ),
                        height: 90,
                        width: 110,
                        child: Center(
                          child: Text(
                            '${now.day - 4} Feb',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        display(now.day-5, 5);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: AssetImage('images/stickyNotes.png')
                            )
                        ),
                        height: 90,
                        width: 110,
                        child: Center(
                          child: Text('${now.day - 5} Feb',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18)),
                        ),
                      ),
                    ),
                  ],
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          if(val== "notListening"){
            _isListening = false;
            _speech.stop();
          }
          print('onStatus: $val');},
        onError: (val) {
          print('Hello 1');

          print("Hello2");
          print('onError: $val');
        },
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
  // void _listen() async {
  //   // bool help = false;
  //   bool must = true;
  //   if (!isPress) {
  //     print("1");
  //     _speech.stop();
  //     must = false;
  //     setState(() => _isListening = false);
  //   } else if ((!_isListening || help) && must) {
  //     bool available = await _speech.initialize(
  //       onStatus: (val) {
  //         if (val == "notListening") {
  //           // if ( )
  //           _speech.stop();
  //
  //           Future.delayed(const Duration(milliseconds: 500), () {
  //             print("2");
  //             help = true;
  //             _listen();
  //           });
  //         }
  //         print('onStatus: $val');
  //       },
  //       onError: (val) => print('onError: $val'),
  //     );
  //     if (available) {
  //       setState(() => _isListening = true);
  //       _speech.listen(
  //         onResult: (val) => setState(() {
  //           _controller.text = val.recognizedWords;
  //           if (val.hasConfidenceRating && val.confidence > 0) {
  //             _confidence = val.confidence;
  //           }
  //         }),
  //       );
  //     }
  //   } else {
  //     setState(() => _isListening = false);
  //     _speech.stop();
  //   }
  // }
}