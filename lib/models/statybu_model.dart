class Statybos {
  List<int> laikotarpis = [];
  List<int> reiksme = [];

  Statybos.fromJson(List<dynamic> map) {
    List<int> result1 = [];
    List<int> result2 = [];

    for (var element in map) {
      result1.add(element['Laikotarpis']);
      result2.add(element['Reikšmė']);
    }

    laikotarpis = result1;
    reiksme = result2;
  }
}
