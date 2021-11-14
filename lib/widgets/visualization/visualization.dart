import 'package:flutter/material.dart';
import 'package:verus_praedium/widgets/visualization/area_chart.dart';
import 'package:verus_praedium/widgets/visualization/bar_chart.dart';
import 'package:verus_praedium/widgets/visualization/cartesian_chart.dart';
import 'package:verus_praedium/widgets/visualization/funnel_chart.dart';
import 'package:verus_praedium/widgets/visualization/rose_chart.dart';

import 'package:verus_praedium/models/data_results.dart';

class Visualization {
  static List<Widget> getAllCharts(DataResults results) {
    return [
      BarChart(results: results),
      CartesianChart(results: results),
      AreaChart(
        results: results,
      ),
      //RoseChart(results: results),
      FunnelChart(results: results),
    ];
  }
}
