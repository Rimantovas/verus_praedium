import 'dart:convert';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:verus_praedium/globals/globals.dart';
import 'package:verus_praedium/models/city.dart';
import 'package:verus_praedium/models/data_results.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key, required this.city}) : super(key: key);
  final City city;

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Series<Map<dynamic, dynamic>, String>> _createSampleData() {
    return [
      Series<Map<dynamic, dynamic>, String>(
        id: 'Global Revenue',
        domainFn: (Map<dynamic, dynamic> sales, _) => sales['year'],
        measureFn: (Map<dynamic, dynamic> sales, _) =>
            sales['value'].toDouble() as num,
        data: widget.city.results.values
            .firstWhere((element) => element.rodiklis == Rodikliai.atlyginimas)
            .reiksmes
            .toList(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () =>
                Navigator.canPop(context) ? Navigator.pop(context) : null,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: width * .8,
              alignment: Alignment.center,
              child: BarChart(
                _createSampleData(),
                animate: true,
                primaryMeasureAxis:
                    const NumericAxisSpec(renderSpec: NoneRenderSpec()),
                domainAxis: const OrdinalAxisSpec(
                    showAxisLine: true, renderSpec: NoneRenderSpec()),
                // layoutConfig: LayoutConfig(
                //     leftMarginSpec: MarginSpec.fixedPixel(0),
                //     topMarginSpec: MarginSpec.fixedPixel(0),
                //     rightMarginSpec: MarginSpec.fixedPixel(0),
                //     bottomMarginSpec: MarginSpec.fixedPixel(0)),
              ),
            ),
          ],
        ));
  }
}
