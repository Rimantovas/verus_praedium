import 'package:flutter/material.dart';
import 'package:verus_praedium/globals/globals.dart';
import 'package:verus_praedium/models/city.dart';
import 'package:verus_praedium/pages/map.dart';
import 'package:verus_praedium/pages/statistics.dart';
import 'package:verus_praedium/widgets/city_card.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage({Key? key, required this.cities}) : super(key: key);
  final List<City> cities;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () =>
                Navigator.canPop(context) ? Navigator.pop(context) : null,
          ),
          actions: [
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
    );
  }
}
