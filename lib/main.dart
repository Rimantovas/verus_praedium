import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:verus_praedium/pages/cities_page.dart';
import 'package:verus_praedium/pages/statistics.dart';
import 'package:verus_praedium/pages/test.dart';
import 'package:verus_praedium/pages/test2.dart';
import 'package:verus_praedium/pages/test3.dart';
import 'package:verus_praedium/pages/test4.dart';
import 'package:verus_praedium/pages/test5.dart';

import 'models/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Verus praedium',
      theme: ThemeData(
        primaryColor: const Color(0xFF502BA0),
        canvasColor: const Color(0xFF060224),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFF060224)),
      ),
      home: CitiesPage(),
    );
  }
}
