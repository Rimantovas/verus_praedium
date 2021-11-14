import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:verus_praedium/pages/sliders_page.dart';
import 'package:verus_praedium/pages/test.dart';
import 'package:verus_praedium/pages/test2.dart';
import 'package:verus_praedium/pages/test3.dart';
import 'package:verus_praedium/pages/test4.dart';
import 'package:verus_praedium/pages/test5.dart';

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

  bool splashDone = false;

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
            Rodikliai.mokyklos: DataResults.fromJson(
                jsonDecode(mokyklos), element['enum'], Rodikliai.mokyklos),
            Rodikliai.atlyginimas: DataResults.fromJson(jsonDecode(atlyginimai),
                element['enum'], Rodikliai.atlyginimas),
            Rodikliai.darzeliai: DataResults.fromJson(
                jsonDecode(darzeliai), element['enum'], Rodikliai.darzeliai),
            Rodikliai.namuKainos: DataResults.fromJson(
                jsonDecode(namai), element['enum'], Rodikliai.namuKainos),
            Rodikliai.pastatuSkaicius: DataResults.fromJson(jsonDecode(statyba),
                element['enum'], Rodikliai.pastatuSkaicius),
            Rodikliai.uzimtumas: DataResults.fromJson(
                jsonDecode(uzimtumas), element['enum'], Rodikliai.uzimtumas),
            Rodikliai.butuKainos: DataResults.fromJson(
                jsonDecode(butai), element['enum'], Rodikliai.butuKainos),
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
            foregroundColor: Colors.white,
          )),
      themeMode: ThemeMode.dark,
      home: initialData.isNotEmpty && splashDone
          ? SlidersPage(
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
