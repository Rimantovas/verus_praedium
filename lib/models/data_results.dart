import 'package:verus_praedium/globals/globals.dart';

class DataResults {
  List<Map<dynamic, dynamic>> reiksmes = [];
  double vidurkis = 0;
  double citiesMax = 0;
  double citiesMin = double.infinity;
  Rodikliai rodiklis = Rodikliai.nusikaltimai;
  String matVnt = '';

  DataResults.fromJson(
      List<dynamic> map, Miestai miestas, Rodikliai newRodiklis) {
    List<Map<dynamic, dynamic>> results = [];
    matVnt = map.first['Matavimo vienetai'];
    for (var element in map) {
      citiesMax = citiesMax < element['Reikšmė'].toDouble()
          ? element['Reikšmė'].toDouble()
          : citiesMax;
      citiesMin = citiesMin > element['Reikšmė'].toDouble()
          ? element['Reikšmė'].toDouble()
          : citiesMin;

      if (element['Administracinė teritorija'] == miestas.name) {
        // result1.add(element['Laikotarpis'].toString());
        // result2.add(element['Reikšmė'].toDouble());
        results.add({
          'year': element['Laikotarpis'].toString(),
          'value': element['Reikšmė'].toDouble(),
        });
      }
    }

    reiksmes = results;
    rodiklis = newRodiklis;
    vidurkis = getAverage(
        results.map((e) => double.parse(e['value'].toString())).toList());
  }

  double getAverage(List<double> list) {
    double average = 0;
    for (var element in list) {
      average += element;
    }
    average = average / list.length;
    return average;
  }
}
