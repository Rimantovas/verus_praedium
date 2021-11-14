import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart' as graphic;
import 'package:verus_praedium/models/data_results.dart';

class BarChart extends StatelessWidget {
  const BarChart({Key? key, required this.results}) : super(key: key);
  final DataResults results;

  @override
  Widget build(BuildContext context) {
    return graphic.Chart(
      data: results.reiksmes,
      variables: {
        'Metai': graphic.Variable(accessor: (Map map) => map['year'] as String),
        'Reikšmės': graphic.Variable(
          accessor: (Map map) => map['value'] as num,
          scale: graphic.LinearScale(min: 0),
        ),
      },
      elements: [
        graphic.IntervalElement(
          // label: graphic.LabelAttr(
          //     encode: (tuple) => graphic.Label(tuple['Reikšmės'].toString())),
          elevation: graphic.ElevationAttr(value: 0, onSelection: {
            'tap': {true: (_) => 5}
          }),
          shape: graphic.ShapeAttr(
              value: graphic.RectShape(borderRadius: BorderRadius.circular(2))),
          gradient: graphic.GradientAttr(
              value: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).canvasColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [results.citiesMin / results.citiesMax, 1]),
              onSelection: {
                'tap': {
                  true: (_) => LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).canvasColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 1])
                }
              }),
          // color: graphic.ColorAttr(
          //     value: Theme.of(context).primaryColor,
          //     onSelection: {
          //       'tap': {false: (color) => color.withAlpha(100)}
          //     }),
        ),
      ],
      axes: [
        graphic.Defaults.horizontalAxis
          ..line = null
          ..grid = null,
        graphic.Defaults.verticalAxis
          ..grid = graphic.StrokeStyle(color: Colors.white)
          ..label = graphic.LabelStyle(
              const TextStyle(fontSize: 8, color: Colors.white),
              offset: const Offset(-4, 0))
      ],
      selections: {'tap': graphic.PointSelection(dim: 1)},
      tooltip: graphic.TooltipGuide(),
    );
  }
}
