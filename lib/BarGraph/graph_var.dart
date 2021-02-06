import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';

class GraphVar{
  final String Sentiments;
  final double Value;
  final charts.Color barColor;

  GraphVar(
  {
    @required this.Sentiments,
    @required this.Value,
    @required this.barColor});

}