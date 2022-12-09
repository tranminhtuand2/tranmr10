import 'package:coffemanger/data/model/chart_thongke.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class chartproduct extends StatelessWidget {
  final List<thongkeSp> data;
  chartproduct({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<thongkeSp, String>> series = [
      charts.Series(
          id: "product",
          data: data,
          domainFn: (thongkeSp series, _) => series.name,
          measureFn: (thongkeSp series, _) => series.soluong,
          colorFn: (thongkeSp series, _) => series.barcolor)
    ];
    return charts.BarChart(
      series,
      animate: true,
    );
  }
}
