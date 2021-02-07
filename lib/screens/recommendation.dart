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
    for(int i=0; i<array.length; i++){
      if(array[i]["Text"]=="connectivity issues" || array[i]["Text"]=="wi-fi connectivity issues" || array[i]["Text"]=="Yaar Connectivity"){
        help = true;
        score = array[i]["Score"];
      }
    }
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
                    if(Recommend[index]['Name']== "Wifi Hub"){
                      check = true;
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
