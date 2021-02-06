import 'graph_var.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ValueChart extends StatelessWidget {
  final List<GraphVar> data;

  ValueChart({
    @required this.data
});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<GraphVar, String>> series =[
      charts.Series(
        id: "Value",
        data: data,
          domainFn: (GraphVar series, _) => series.Sentiments,
          measureFn: (GraphVar series, _) =>
          series.Value,
        colorFn: (GraphVar series, _) =>
            series.barColor
      )
    ];

    return SafeArea(
      child: Container(
        height: 400,
        padding: EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(""),
                Expanded(
                  child: charts.BarChart(series, animate: true,)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
