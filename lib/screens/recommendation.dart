import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:mannkibaat/BarGraph/calue_charts.dart';
import 'package:mannkibaat/BarGraph/graph_var.dart';
import 'package:mannkibaat/screens/diarypage.dart';
import 'package:mannkibaat/widgets/Button.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'nearestplace.dart';

class RecommendationPage extends StatefulWidget {
  static const String id = 'recommendationpage';
  final response;

  RecommendationPage({Key key, @required this.response}) : super(key: key);

  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  var Activities = [
    {"Name": "Bars", "Description": "Ease your weight"},
    {"Name": "Yoga Centers", "Description": "Ease your weight"},
    {"Name": "Theatres", "Description": "Ease your weight"},
    {"Name": "Sports Club", "Description": "Ease your weight"},
    {"Name": "Gym", "Description": "Ease your weight"},
    {"Name": "Library", "Description": "Ease your weight"},
    {"Name": "Mental Health Checkup", "Description": "Ease your weight"},
    {"Name": "WifiHub", "Description": "Ease your weight"}
  ];
  var response;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    response = widget.response;
    print('$response');
  }

  var shareYourDay = TextEditingController();
  DateTime now = new DateTime.now();

  String month = '';

  @override
  Widget build(BuildContext context) {
    var array = response["Response2"]["KeyPhrases"];
    bool help = false;
    double score = 0;

    var Recommend = [];
    if (response["Response1"]["SentimentScore"]["Positive"] > 0.5) {
      Recommend = [Activities[0], Activities[2], Activities[5]];
    } else if (response["Response1"]["SentimentScore"]["Negative"] > 0.5) {
      Recommend = [Activities[1], Activities[2], Activities[3]];//3
    } else if (response["Response1"]["SentimentScore"]["Neutral"] > 0.5) {
      Recommend = [Activities[2], Activities[3], Activities[5]];
    } else if (response["Response1"]["SentimentScore"]["Mixed"] > 0.5) {
      Recommend = [Activities[0], Activities[1], Activities[4]];
    } else{
      Recommend = [Activities[2], Activities[5], Activities[3]];
    }

    final List<GraphVar> data = [
      GraphVar(
          Sentiments: "Positive",
          Value: response["Response1"]["SentimentScore"]["Positive"] * 10,
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      GraphVar(
          Sentiments: "Negative",
          Value: response["Response1"]["SentimentScore"]["Negative"] * 10,
          barColor: charts.ColorUtil.fromDartColor(Colors.red)),
      GraphVar(
          Sentiments: "Neutral",
          Value: response["Response1"]["SentimentScore"]["Neutral"] * 10,
          barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      GraphVar(
          Sentiments: "Mixed",
          Value: response["Response1"]["SentimentScore"]["Mixed"] * 10,
          barColor: charts.ColorUtil.fromDartColor(Colors.yellow)),
    ];
    for(int i=0; i<array.length; i++){
      if(array[i]["Text"]=="connectivity issues" || array[i]["Text"]=="wi-fi connectivity issues" || array[i]["Text"]=="Yaar Connectivity"){
        help = true;
        score = array[i]["Score"];
        Recommend[0] = Activities[7];
      }
    }

    Widget emotionImage(){
      if(response["Response1"]["Sentiment"] == 'POSITIVE'){
        return Image.network('https://i.pinimg.com/originals/23/83/b8/2383b8c0a126d1d6e45c69e1f1d8c835.png', height: 300, width: 300,);
      } else if (response["Response1"]["Sentiment"] == 'NEGATIVE'){
        return Image.network('https://i.pinimg.com/originals/09/fc/3b/09fc3ba997d72105b72c1463e2e2ae20.png', height: 300, width: 300,);
      } else if (response["Response1"]["Sentiment"] == 'MIXED') {
            return Image.network('https://www.clipartkey.com/mpngs/m/42-428855_confused-emoji-with-transparent-background.png', height: 300, width: 300,);
      } else {
          return Image.network('https://cdn.shopify.com/s/files/1/1061/1924/products/Neutral_Emoji_icon_9f1cc93a-f984-4b6c-896e-d24a643e4c28_large.png?v=1571606091', height: 300, width: 200,);
        }
      }

    return WillPopScope(
        onWillPop: () {
          Navigator.pushNamedAndRemoveUntil(
              context, DiaryPage.id, (route) => false);
        },
        child: Scaffold(
            body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Conditional.single(
                  context: context,
                  conditionBuilder: (BuildContext context) => help == true,
                  widgetBuilder: (BuildContext context) => Flushbar(
                    flushbarPosition: FlushbarPosition.TOP,
                    title: "Content Analysis",

                    message: "Based on your content you might want to visit Wifi Hub\n\nCONFIDENCE SCORE: ${score.toStringAsFixed(7)}",
                    duration: Duration(seconds: 3),
                    dismissDirection: 	FlushbarDismissDirection.VERTICAL,
                    isDismissible: true,
                  ),
                  fallbackBuilder: (BuildContext context) => Text('We give what you want'),
                ),


                SizedBox(
                  height: 20,
                ),
                Text(
                  "Check Your MOOD",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Flexible(
                    child: emotionImage(),),
                SizedBox(
                  height: 20,
                ),
                Button(
                  title: "Analyse",
                  color: Colors.green,
                  onPressed: () {
                    showDialog<void>(
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        return new Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: new Container(
                                height: 600,
                                width: MediaQuery.of(context).size.width,
                                child: new Column(
                                  children: <Widget>[
                                    new ValueChart(
                                      data: data,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "You May Visit",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemCount: 3,
                  itemBuilder: (context, int index) {
                    bool check;
                    if(Recommend[index]['Name']== "WifiHub"){
                      check = true;
                      // Recommend[0] = Activities[7];

                    }else check=false;
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NearestPlace(nameOfActivity: Recommend[index]['Name'],),
                            ));
                      },
                      child: Container(
                          color: check?Colors.red : Colors.yellow,
                          child: ListTile(
                            title: Text(
                              Recommend[index]['Name'],
                            ),
                            trailing: check? Text('Book Now'): Icon(Icons.location_pin, color: Colors.black, size: 30,)
                          )),
                    );
                  },
                )
              ],
            ),
          ),
        )
            // SafeArea(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //

            //     ],
            //   ),
            // ),////////
            ));
  }
}
