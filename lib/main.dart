import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:verus_praedium/pages/main_page.dart';
import 'package:verus_praedium/pages/sliders_page.dart';

import 'globals/globals.dart';
import 'models/city.dart';
import 'models/data_results.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<City> initialData = [];
  List<City> priceData = [];

  bool splashDone = false;

  Future<void> calculatePrices() async {
    List<City> cities = [];
    //paimam json
    String namai =
        await DefaultAssetBundle.of(context).loadString("assets/namai.json");
    String butai =
        await DefaultAssetBundle.of(context).loadString("assets/butai.json");
    for (var element in images) {
      cities.add(
        City(
          imageUrl: element['url'].toString(),
          name: element['name'].toString(),
          enumas: element['enum'],
          results: {
            Rodikliai.namuKainos: DataResults.fromJson(
                jsonDecode(namai), element['enum'], Rodikliai.namuKainos),
            Rodikliai.butuKainos: DataResults.fromJson(
                jsonDecode(butai), element['enum'], Rodikliai.butuKainos),
          },
        ),
      );
    }
    setState(() {
      priceData = cities;
    });
  }

  Future<void> calculateDate() async {
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
        await DefaultAssetBundle.of(context).loadString("assets/statybos.json");
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
            Rodikliai.pastatuSkaicius: DataResults.fromJson(jsonDecode(statyba),
                element['enum'], Rodikliai.pastatuSkaicius),
            Rodikliai.namuKainos: DataResults.fromJson(
                jsonDecode(namai), element['enum'], Rodikliai.namuKainos),
            Rodikliai.butuKainos: DataResults.fromJson(
                jsonDecode(butai), element['enum'], Rodikliai.butuKainos),
            Rodikliai.uzimtumas: DataResults.fromJson(
                jsonDecode(uzimtumas), element['enum'], Rodikliai.uzimtumas),
            Rodikliai.atlyginimas: DataResults.fromJson(jsonDecode(atlyginimai),
                element['enum'], Rodikliai.atlyginimas),
            Rodikliai.darzeliai: DataResults.fromJson(
                jsonDecode(darzeliai), element['enum'], Rodikliai.darzeliai),
            Rodikliai.mokyklos: DataResults.fromJson(
                jsonDecode(mokyklos), element['enum'], Rodikliai.mokyklos),
            Rodikliai.nusikaltimai: DataResults.fromJson(
                jsonDecode(nusikaltimai),
                element['enum'],
                Rodikliai.nusikaltimai),
          },
        ),
      );
    }

    setState(() {
      initialData = cities;
    });
    // return cities;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          splashDone = true;
        });
      }
    });
    calculateDate();
    calculatePrices();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Verus praedium',
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF502BA0),
          canvasColor: const Color(0xFF060224),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              brightness: Brightness.dark, secondary: const Color(0xFFA8A8D6)),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
          )),
      themeMode: ThemeMode.dark,
      home: initialData.isNotEmpty && splashDone
          ? MainPage(
              priceCities: priceData,
              cities: initialData,
            )
          : Material(
              child: Container(
                color: const Color(0xFF060224),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Align(
                        alignment: Alignment.center,
                        child: Image.asset('assets/images/logo.png')),
                    const Spacer(),
                    const CircularProgressIndicator(
                      color: Color(0xFF502BA0),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
