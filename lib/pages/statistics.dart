import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:verus_praedium/globals/globals.dart';
import 'package:verus_praedium/models/city.dart';
import 'package:verus_praedium/widgets/expansion_card.dart';
import 'package:verus_praedium/widgets/visualization/visualization.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key, required this.city}) : super(key: key);
  final City city;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(city.name),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...city.results.keys
                        .map((key) => ExpansionCard(
                            city: city,
                            rodiklis: key,
                            charts:
                                Visualization.getAllCharts(city.results[key]!)))
                        .toList()
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
