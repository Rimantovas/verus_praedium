import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:verus_praedium/globals/globals.dart';
import 'package:verus_praedium/models/city.dart';
import 'package:verus_praedium/models/data_results.dart';
import 'package:verus_praedium/pages/cities_page.dart';

class SlidersPage extends StatefulWidget {
  SlidersPage({Key? key}) : super(key: key);

  @override
  State<SlidersPage> createState() => _SlidersPageState();
}

class _SlidersPageState extends State<SlidersPage> {
  Future<List<City>> calculateDate() async {
    List<City> cities = [];
    //paimam json
    String mokyklos =
        await DefaultAssetBundle.of(context).loadString("assets/mokyklos.json");
    String atlyginimai = await DefaultAssetBundle.of(context)
        .loadString("assets/atlyginimas.json");
    String darzeliai = await DefaultAssetBundle.of(context)
        .loadString("assets/darzeliai.json");
    String namai =
        await DefaultAssetBundle.of(context).loadString("assets/namai.json");
    String statyba =
        await DefaultAssetBundle.of(context).loadString("assets/statyba.json");
    String uzimtumas = await DefaultAssetBundle.of(context)
        .loadString("assets/uzimtumas.json");
    String butai =
        await DefaultAssetBundle.of(context).loadString("assets/butai.json");
    String nusikaltimai = await DefaultAssetBundle.of(context)
        .loadString("assets/nusikaltimai.json");
    for (var element in images) {
      cities.add(
        City(
          imageUrl: element['url'].toString(),
          name: element['name'].toString(),
          enumas: element['enum'],
          results: {
            'mokyklos': DataResults.fromJson(
                jsonDecode(mokyklos), element['enum'], Rodikliai.mokyklos),
            'atlyginimai': DataResults.fromJson(jsonDecode(atlyginimai),
                element['enum'], Rodikliai.atlyginimas),
            'darzeliai': DataResults.fromJson(
                jsonDecode(darzeliai), element['enum'], Rodikliai.darzeliai),
            'namai': DataResults.fromJson(
                jsonDecode(namai), element['enum'], Rodikliai.namuKainos),
            'statyba': DataResults.fromJson(jsonDecode(statyba),
                element['enum'], Rodikliai.pastatuSkaicius),
            'uzimtumas': DataResults.fromJson(
                jsonDecode(uzimtumas), element['enum'], Rodikliai.uzimtumas),
            'butai': DataResults.fromJson(
                jsonDecode(butai), element['enum'], Rodikliai.butuKainos),
            'nusikaltimai': DataResults.fromJson(jsonDecode(nusikaltimai),
                element['enum'], Rodikliai.nusikaltimai),
          },
        ),
      );
    }
    return cities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        child: const Text('Žiūrėti rezultatus'),
        onPressed: () async {
          List<City> cities = await calculateDate();

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CitiesPage(
                        cities: cities,
                      )));
        },
      ),
      body: Material(
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: sliderInfo[index]['check'] as bool,
                    onChanged: (value) => setState(() {
                      sliderInfo[index]['check'] = value;
                    }),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            (sliderInfo[index]['name'] as Rodikliai).name,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Slider(
                            value: sliderInfo[index]['value'].toDouble(),
                            activeColor: (sliderInfo[index]['check'] as bool)
                                ? Theme.of(context).primaryColor
                                : const Color(0xFF656565),
                            inactiveColor:
                                Theme.of(context).colorScheme.secondary,
                            max: 1,
                            // divisions: 5,
                            onChanged: (value) => setState(() {
                                  sliderInfo[index]['value'] = value;
                                })),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }, childCount: sliderInfo.length)),
          ],
        ),
      ),
    );
  }
}
