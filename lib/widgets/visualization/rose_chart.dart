import 'package:flutter/material.dart';
import 'package:verus_praedium/models/data_results.dart';
import 'package:graphic/graphic.dart' as graphic;

class RoseChart extends StatelessWidget {
  const RoseChart({Key? key, required this.results}) : super(key: key);
  final DataResults results;

  @override
  Widget build(BuildContext context) {
    return graphic.Chart(
      data: results.reiksmes,
      variables: {
        'Metai': graphic.Variable(accessor: (Map map) => map['year'] as String),
        'Reikšmės': graphic.Variable(
          accessor: (Map map) => map['value'] as num,
          scale: graphic.LinearScale(min: 0, marginMax: 0.4),
        ),
      },
      elements: [
        graphic.IntervalElement(
          label: graphic.LabelAttr(
              encode: (tuple) => graphic.Label(
                  tuple['Reikšmės'].toString(),
                  graphic.LabelStyle(
                      const TextStyle(
                        fontSize: 10,
                      ),
                      offset: const Offset(0, 0)))),
          elevation: graphic.ElevationAttr(value: 5),
          shape: graphic.ShapeAttr(
              value: graphic.RectShape(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          )),
          // gradient: graphic.GradientAttr(
          //     value: LinearGradient(
          //         colors: [
          //           Theme.of(context).primaryColor,
          //           Theme.of(context).canvasColor,
          //         ],
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         stops: [results.citiesMin / results.citiesMax, 1]),
          //     onSelection: {
          //       'tap': {
          //         true: (_) => LinearGradient(
          //             colors: [
          //               Theme.of(context).colorScheme.secondary,
          //               Theme.of(context).canvasColor,
          //             ],
          //             begin: Alignment.topCenter,
          //             end: Alignment.bottomCenter,
          //             stops: const [0, 1])
          //       }
          //     }),
          color: graphic.ColorAttr(
              variable: 'Metai', values: graphic.Defaults.colors20),

          // color: graphic.ColorAttr(
          //     value: Theme.of(context).primaryColor,
          //     onSelection: {
          //       'tap': {false: (color) => color.withAlpha(100)}
          //     }),
        ),
      ],
      coord: graphic.PolarCoord(startRadius: 0.05),
      // axes: [
      //   graphic.Defaults.horizontalAxis
      //     ..line = null
      //     ..label = null
      //     ..grid = null,
      //   graphic.Defaults.verticalAxis
      //     ..grid = graphic.StrokeStyle(color: Colors.white)
      //     ..label = graphic.LabelStyle(
      //         const TextStyle(
      //           fontSize: 8,
      //         ),
      //         offset: const Offset(-4, 0))
      // ],
      selections: {'tap': graphic.PointSelection(dim: 1)},
      tooltip: graphic.TooltipGuide(),
    );
  }
}
