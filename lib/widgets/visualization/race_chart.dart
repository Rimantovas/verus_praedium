import 'package:flutter/material.dart';
import 'package:verus_praedium/models/data_results.dart';
import 'package:graphic/graphic.dart' as graphic;

class RaceChart extends StatelessWidget {
  const RaceChart({Key? key, required this.results}) : super(key: key);
  final DataResults results;

  @override
  Widget build(BuildContext context) {
    return graphic.Chart(
      padding: EdgeInsets.all(8),
      data: results.reiksmes,
      variables: {
        'Metai': graphic.Variable(accessor: (Map map) => map['year'] as String),
        'Reikšmės': graphic.Variable(
          accessor: (Map map) => map['value'] as num,
          scale: graphic.LinearScale(min: 0, marginMax: 0.1),
        ),
      },
      elements: [
        graphic.IntervalElement(
          label: graphic.LabelAttr(
              encode: (tuple) => graphic.Label(tuple['Reikšmės'].toString())),
          elevation: graphic.ElevationAttr(value: 5),
          // shape: graphic.ShapeAttr(
          //     value: graphic.RectShape(
          //   borderRadius: const BorderRadius.all(Radius.circular(10)),
          // )),
          color: graphic.ColorAttr(
              variable: 'Metai', values: graphic.Defaults.colors20),
        ),
      ],
      coord: graphic.PolarCoord(transposed: true),
      axes: [
        graphic.Defaults.radialAxis..label = null,
        graphic.Defaults.circularAxis,
      ],
      selections: {'tap': graphic.PointSelection(dim: 1)},
      tooltip: graphic.TooltipGuide(),
    );
  }
}
