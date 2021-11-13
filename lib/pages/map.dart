import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:verus_praedium/globals/globals.dart';
import 'package:verus_praedium/models/city.dart';
import 'package:verus_praedium/models/model.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key, required this.cities}) : super(key: key);
  final List<City> cities;
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late List<Model> _data;
  late MapShapeSource _mapSource;
  int checkCount = 0;

  @override
  void initState() {
    super.initState();
    checkCount = sliderInfo.where((element) => element['check']).length;

    _data = <Model>[
      Model(
          'Kauno apskritis',
          Color(0xFF502BA0).withOpacity(widget.cities
                  .firstWhere((element) => element.enumas == Miestai.kaunas)
                  .getStarRating3() /
              checkCount),
          'Kauno apskritis'),
      Model(
          'Vilniaus apskritis',
          Color(0xFF502BA0).withOpacity(widget.cities
                  .firstWhere((element) => element.enumas == Miestai.vilnius)
                  .getStarRating3() /
              checkCount),
          'Vilniaus apskritis'),
      Model(
          'Klaipėdos apskritis',
          Color(0xFF502BA0).withOpacity(widget.cities
                  .firstWhere((element) => element.enumas == Miestai.klaipeda)
                  .getStarRating3() /
              checkCount),
          'Klaipėdos apskritis'),
      Model(
          'Panevėžio apskritis',
          Color(0xFF502BA0).withOpacity(widget.cities
                  .firstWhere((element) => element.enumas == Miestai.panevezys)
                  .getStarRating3() /
              checkCount),
          'Panevėžio apskritis'),
      Model(
          'Alytaus apskritis',
          Color(0xFF502BA0).withOpacity(widget.cities
                  .firstWhere((element) => element.enumas == Miestai.alytus)
                  .getStarRating3() /
              checkCount),
          'Alytaus apskritis'),
      Model(
          'Šiaulių apskritis',
          Color(0xFF502BA0).withOpacity(widget.cities
                  .firstWhere((element) => element.enumas == Miestai.siauliai)
                  .getStarRating3() /
              checkCount),
          'Šiaulių apskritis'),
    ];
    _mapSource = MapShapeSource.asset(
      'assets/lithuania.json',
      shapeDataField: 'name',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].state,
      dataLabelMapper: (int index) => _data[index].stateCode,
      shapeColorValueMapper: (int index) => _data[index].color,
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: SfMaps(
            layers: <MapShapeLayer>[
              MapShapeLayer(
                source: _mapSource,
                color: const Color(0xFF454545),
                showDataLabels: true,
                // legend: const MapLegend(MapElement.shape),
                tooltipSettings: MapTooltipSettings(
                    color: Colors.grey[700],
                    strokeColor: Colors.white,
                    strokeWidth: 2),
                strokeColor: Theme.of(context).colorScheme.secondary,
                strokeWidth: 0.5,
                shapeTooltipBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _data[index].stateCode,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
                dataLabelSettings: const MapDataLabelSettings(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
