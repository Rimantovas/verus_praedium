import 'package:flutter/material.dart';
import 'package:verus_praedium/globals/globals.dart';
import 'package:verus_praedium/pages/statistics.dart';
import 'package:verus_praedium/widgets/city_card.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Wrap(
          children: [
            ...images.map(
              (e) => Padding(
                padding: const EdgeInsets.all(15),
                child: CityCard(
                  city: e.keys.first,
                  imageUrl: e.values.first,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StatisticsPage())),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
