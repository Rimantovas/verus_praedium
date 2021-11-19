import 'package:flutter/material.dart';
import 'package:verus_praedium/models/city.dart';
import 'package:verus_praedium/pages/price_page.dart';
import 'package:verus_praedium/pages/sliders_page.dart';
import 'package:verus_praedium/widgets/custom_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({required this.cities, Key? key, required this.priceCities})
      : super(key: key);
  final List<City> cities;
  final List<City> priceCities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Verus Praedium'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset('assets/images/logo.png')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                  function: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SlidersPage(cities: cities))),
                  text: 'Reitingų skaičiuoklė'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                  function: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PricePage(cities: priceCities))),
                  text: 'Būsto skaičiuoklė'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            )
          ],
        ),
      ),
    );
  }
}
