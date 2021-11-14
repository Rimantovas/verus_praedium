import 'package:flutter/material.dart';
import 'package:verus_praedium/models/data_results.dart';
import 'package:graphic/graphic.dart' as graphic;

class FunnelChart extends StatelessWidget {
  const FunnelChart({Key? key, required this.results}) : super(key: key);
  final DataResults results;

  @override
  Widget build(BuildContext context) {
    return graphic.Chart(
      data: results.reiksmes,
      variables: {
        'Metai': graphic.Variable(accessor: (Map map) => map['year'] as String),
        'Reikšmės': graphic.Variable(
          accessor: (Map map) => map['value'] as num,
          scale: graphic.LinearScale(
              min: -results.vidurkis, max: results.vidurkis),
        ),
      },
      transforms: [
        graphic.Sort(
          compare: (a, b) =>
              ((b['Reikšmės'] as num) - (a['Reikšmės'] as num)).toInt(),
        )
      ],
      elements: [
        graphic.IntervalElement(
          label: graphic.LabelAttr(
              encode: (tuple) => graphic.Label(
                    tuple['Reikšmės'].toString(),
                    graphic.LabelStyle(
                        TextStyle(fontSize: 12, color: Colors.black)),
                  )),
          elevation: graphic.ElevationAttr(value: 5),
          shape: graphic.ShapeAttr(value: graphic.FunnelShape()),
          modifiers: [graphic.SymmetricModifier()],
          color: graphic.ColorAttr(
              variable: 'Metai', values: graphic.Defaults.colors20),
        ),
      ],
      coord: graphic.RectCoord(transposed: true, verticalRange: [1, 0]),
      selections: {'tap': graphic.PointSelection(dim: 1)},
      tooltip: graphic.TooltipGuide(),
    );
  }
}
