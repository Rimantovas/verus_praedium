import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:verus_praedium/models/data_results.dart';

class CartesianChart extends StatelessWidget {
  CartesianChart({Key? key, required this.results}) : super(key: key);
  final DataResults results;

  final _tooltipBehavior = TooltipBehavior(enable: true, header: 'Reikšmė');

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        tooltipBehavior: _tooltipBehavior,
        // Initialize category axis
        primaryXAxis: CategoryAxis(),
        series: <LineSeries<Map<dynamic, dynamic>, String>>[
          LineSeries<Map<dynamic, dynamic>, String>(
            // Bind data source
            dataSource: results.reiksmes,
            xValueMapper: (Map<dynamic, dynamic> sales, _) => sales['year'],
            yValueMapper: (Map<dynamic, dynamic> sales, _) => sales['value'],
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ]);
  }
}
