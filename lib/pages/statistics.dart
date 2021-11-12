import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:verus_praedium/models/statybu_model.dart';
import 'package:verus_praedium/pages/map.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<Map<String, dynamic>> data = [];

  Future<void> getData() async {
    String temp = await DefaultAssetBundle.of(context)
        .loadString("assets/statybu_sk.json");
    List<Map<String, dynamic>> list = [];
    var map = jsonDecode(temp);
    for (var item in map) {
      if (item['Kambarių skaičius'].toString() == 'Iš viso pastatytų butų' &&
          item['Administracinė teritorija'].toString() ==
              'Vilniaus apskritis') {
        list.add({
          'Laikotarpis': item['Laikotarpis'],
          'Reikšmė': item['Reikšmė'],
        });
      }
    }
    setState(() {
      data = list;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () =>
                      Navigator.canPop(context) ? Navigator.pop(context) : null,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.map),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MapPage())),
                  ),
                ]),
            body: Chart(
              data: data,
              variables: {
                'Laikotarpis': Variable(
                  accessor: (Map map) => map['Laikotarpis'].toString(),
                  scale: OrdinalScale(tickCount: 5),
                ),
                'Reikšmė': Variable(
                  accessor: (Map map) => (map['Reikšmė'] ?? 0) as num,
                ),
              },
              elements: [
                AreaElement(
                  shape: ShapeAttr(value: BasicAreaShape(smooth: true)),
                  color:
                      ColorAttr(value: Defaults.colors10.first.withAlpha(80)),
                ),
                LineElement(
                  shape: ShapeAttr(value: BasicLineShape(smooth: true)),
                  size: SizeAttr(value: 0.5),
                ),
              ],
              axes: [
                Defaults.horizontalAxis,
                Defaults.verticalAxis,
              ],
              selections: {
                'touchMove': PointSelection(
                  on: {
                    GestureType.scaleUpdate,
                    GestureType.tapDown,
                    GestureType.longPressMoveUpdate
                  },
                  dim: 1,
                )
              },
              tooltip: TooltipGuide(
                followPointer: [false, true],
                align: Alignment.topLeft,
                offset: const Offset(-20, -20),
              ),
              crosshair: CrosshairGuide(followPointer: [false, true]),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
