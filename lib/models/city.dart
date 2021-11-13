import 'package:verus_praedium/globals/globals.dart';
import 'package:verus_praedium/models/data_results.dart';
import 'package:collection/collection.dart';

class City {
  final String imageUrl;
  final String name;
  final Miestai enumas;
  final Map<String, DataResults> results;
  City(
      {required this.imageUrl,
      required this.name,
      required this.results,
      required this.enumas});

  double getStarRating() {
    double result = 0;
    for (var item in results.values) {
      var data = sliderInfo
          .firstWhereOrNull((element) => element['name'] == item.rodiklis);
      if (data != null) {
        result += (data['value'] ?? 0) * (item.vidurkis / item.citiesMax);
      }
    }
    print(result);
    return result;
  }

  double getStarRating2() {
    double result = 0;
    for (var item in results.values) {
      var data = sliderInfo
          .firstWhereOrNull((element) => element['name'] == item.rodiklis);
      if (data != null) {
        double valueOfSlider =
            item.citiesMin + (item.citiesMax - item.citiesMin) * data['value'];

        result += 1 -
            ((valueOfSlider - item.vidurkis).abs() /
                (item.citiesMax - item.citiesMin));
      }
    }
    print(result);
    return result;
  }

  double getStarRating3() {
    double result = 0;
    for (var item in results.values) {
      var data = sliderInfo
          .firstWhereOrNull((element) => element['name'] == item.rodiklis);
      if (data != null && data['check']) {
        double valueOfSlider =
            item.citiesMin + (item.citiesMax - item.citiesMin) * data['value'];
        double x = 0;
        if (item.citiesMax - valueOfSlider > valueOfSlider - item.citiesMin) {
          x = item.citiesMax - valueOfSlider;
        } else {
          x = valueOfSlider - item.citiesMin;
        }
        result += 1 - ((valueOfSlider - item.vidurkis).abs() / x);
      }
    }
    print(result);
    return result;
  }
}
