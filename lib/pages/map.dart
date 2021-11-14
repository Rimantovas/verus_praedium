import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
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
      ...widget.cities
          .map((e) => Model(
              e.enumas.name,
              const Color(0xFF602BA0)
                  .withOpacity(e.getStarRating3() / checkCount),
              e.enumas.name,
              'e.enumas.name\n${(e.getStarRating3() / checkCount * 100).toStringAsFixed(2)} atiktis'))
          .toList()
      // Model(
      //     'Kauno apskritis',
      //    const Color(0xFF502BA0).withOpacity(widget.cities
      //             .firstWhere((element) => element.enumas == Miestai.kaunas)
      //             .getStarRating3() /
      //         checkCount),
      //     'Kauno apskritis'),
      // Model(
      //     'Vilniaus apskritis',
      //    const Color(0xFF502BA0).withOpacity(widget.cities
      //             .firstWhere((element) => element.enumas == Miestai.vilnius)
      //             .getStarRating3() /
      //         checkCount),
      //     'Vilniaus apskritis'),
      // Model(
      //     'Klaipėdos apskritis',
      //    const Color(0xFF502BA0).withOpacity(widget.cities
      //             .firstWhere((element) => element.enumas == Miestai.klaipeda)
      //             .getStarRating3() /
      //         checkCount),
      //     'Klaipėdos apskritis'),
      // Model(
      //     'Panevėžio apskritis',
      //    const Color(0xFF502BA0).withOpacity(widget.cities
      //             .firstWhere((element) => element.enumas == Miestai.panevezys)
      //             .getStarRating3() /
      //         checkCount),
      //     'Panevėžio apskritis'),
      // Model(
      //     'Alytaus apskritis',
      //    const Color(0xFF502BA0).withOpacity(widget.cities
      //             .firstWhere((element) => element.enumas == Miestai.alytus)
      //             .getStarRating3() /
      //         checkCount),
      //     'Alytaus apskritis'),
      // Model(
      //     'Šiaulių apskritis',
      //    const Color(0xFF502BA0).withOpacity(widget.cities
      //             .firstWhere((element) => element.enumas == Miestai.siauliai)
      //             .getStarRating3() /
      //         checkCount),
      //     'Šiaulių apskritis'),
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
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () => Navigator.pop(context),
        // ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Text(
          //   'Jūsų pasirinktų parametrų atvaizdamas Lietuvos žemėlapyje',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(fontSize: 25),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
            child: SfMaps(
              layers: <MapShapeLayer>[
                MapShapeLayer(
                  source: _mapSource,
                  zoomPanBehavior:
                      MapZoomPanBehavior(enableDoubleTapZooming: true),
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
                        _data[index].tooltip,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                  dataLabelSettings: const MapDataLabelSettings(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  )),
                ),
              ],
            ),
          ),
          Expanded(
            child: DraggableScrollableSheet(
                initialChildSize: 1,
                maxChildSize: 1,
                builder: (context, scrollController) {
                  return Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          gradient: LinearGradient(
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).canvasColor,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: widget.cities.length,
                          itemBuilder: (context, index) {
                            City e = widget.cities[index];
                            return ListTile(
                              title: Text(e.name),
                              trailing: Icon(
                                Icons.circle_sharp,
                                color: const Color(0xFF602BA0).withOpacity(
                                    e.getStarRating3() / checkCount),
                              ),
                              subtitle: RatingStars(
                                starColor:
                                    Theme.of(context).colorScheme.secondary,
                                starOffColor: Theme.of(context).canvasColor,
                                value: e.getStarRating3(),
                                maxValue: sliderInfo
                                    .where((element) => element['check'])
                                    .length
                                    .toDouble(),
                                valueLabelVisibility: false,
                              ),
                            );
                          }));
                }),
          ),
          // Expanded(
          //     child: SingleChildScrollView(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: const BorderRadius.only(
          //           topLeft: Radius.circular(30),
          //           topRight: Radius.circular(30)),
          //       color: Theme.of(context).primaryColor,
          //     ),
          //     child: Column(
          //       children: [
          //         ...widget.cities.map((e) => ListTile(
          //               title: Text(e.name),
          //               subtitle: RatingStars(
          //                 value: e.getStarRating3(),
          //                 maxValue: sliderInfo
          //                     .where((element) => element['check'])
          //                     .length
          //                     .toDouble(),
          //                 valueLabelVisibility: false,
          //               ),
          //             ))
          //       ],
          //     ),
          //   ),
          // ))
        ],
      ),
    );
  }
}
