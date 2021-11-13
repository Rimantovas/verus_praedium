import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:verus_praedium/pages/sliders_page.dart';
import 'package:verus_praedium/pages/test2.dart';
import 'package:verus_praedium/pages/test3.dart';

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
      home: SlidersPage(),
    );
  }
}
