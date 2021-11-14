import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:verus_praedium/models/data_results.dart';

class AreaChart extends StatelessWidget {
  AreaChart({Key? key, required this.results}) : super(key: key);
  final DataResults results;

  final _tooltipBehavior = TooltipBehavior(enable: true, header: 'Reikšmė');

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        tooltipBehavior: _tooltipBehavior,
        // Initialize category axis
        primaryXAxis:
            CategoryAxis(majorGridLines: const MajorGridLines(width: 0)),
        series: <SplineAreaSeries<Map<dynamic, dynamic>, String>>[
          SplineAreaSeries<Map<dynamic, dynamic>, String>(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).canvasColor,
              ],
              stops: const [0, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            // Bind data source
            dataSource: results.reiksmes,
            xValueMapper: (Map<dynamic, dynamic> sales, _) => sales['year'],
            yValueMapper: (Map<dynamic, dynamic> sales, _) => sales['value'],
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ]);
  }
}
