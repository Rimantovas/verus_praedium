import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:verus_praedium/globals/globals.dart';
import 'package:verus_praedium/models/city.dart';
import 'package:verus_praedium/pages/map.dart';
import 'package:verus_praedium/pages/statistics.dart';
import 'package:verus_praedium/widgets/city_card.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage({Key? key, required this.cities}) : super(key: key);
  final List<City> cities;

  String sharingText() {
    String text = '';
    double maxValue =
        sliderInfo.where((element) => element['check']).length.toDouble();
    for (var item in cities) {
      text +=
          '${item.name} = ${item.getStarRating3().toStringAsFixed(2)}/${maxValue.toStringAsFixed(0)} \n';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: const Text('Miestai'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () => Share.share(sharingText()),
            ),
            IconButton(
              icon: const Icon(
                Icons.map,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapPage(
                            cities: cities,
                          ))),
            ),
          ]),
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              ...cities.map(
                (e) => Padding(
                  padding: const EdgeInsets.all(15),
                  child: CityCard(
                    city: e,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StatisticsPage(city: e))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
