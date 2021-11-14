List<Map<String, dynamic>> images = [
  {
    'name': 'Kaunas',
    'enum': Miestai.kaunas,
    'url': 'assets/city_images/kaunas.jpeg'
  },
  {
    'name': 'Vilnius',
    'enum': Miestai.vilnius,
    'url': 'assets/city_images/vilnius.webp'
  },
  {
    'name': 'Klaipėda',
    'enum': Miestai.klaipeda,
    'url': 'assets/city_images/klaipeda.jpeg'
  },
  {
    'name': 'Šiauliai',
    'enum': Miestai.siauliai,
    'url': 'assets/city_images/siauliai.jpeg'
  },
  {
    'name': 'Panevėžys',
    'enum': Miestai.panevezys,
    'url': 'assets/city_images/panevezys.jpeg'
  },
  {
    'name': 'Alytus',
    'enum': Miestai.alytus,
    'url': 'assets/city_images/alytus.jpeg'
  }
];

List<Map<String, dynamic>> sliderInfo = [
  {'name': Rodikliai.pastatuSkaicius, 'value': .5, 'check': true},
  {'name': Rodikliai.namuKainos, 'value': .5, 'check': true},
  {'name': Rodikliai.butuKainos, 'value': .5, 'check': true},
  {'name': Rodikliai.uzimtumas, 'value': .5, 'check': true},
  {'name': Rodikliai.atlyginimas, 'value': .5, 'check': true},
  {'name': Rodikliai.darzeliai, 'value': .5, 'check': true},
  {'name': Rodikliai.mokyklos, 'value': .5, 'check': true},
  {'name': Rodikliai.nusikaltimai, 'value': .5, 'check': true},
];

enum Rodikliai {
  nusikaltimai,
  pastatuSkaicius,
  namuKainos,
  butuKainos,
  uzimtumas,
  atlyginimas,
  darzeliai,
  mokyklos,
}

extension RodikliuPavadinimai on Rodikliai {
  String get name {
    switch (this) {
      case Rodikliai.nusikaltimai:
        return 'Nusikaltimų skaičius';
      case Rodikliai.pastatuSkaicius:
        return 'Baigtų statyti pastatų skaičius';
      case Rodikliai.namuKainos:
        return 'Namų vidutinės kainos';
      case Rodikliai.butuKainos:
        return 'Butų vidutinės kainos';
      case Rodikliai.uzimtumas:
        return 'Gyventojų užimtumo lygis';
      case Rodikliai.atlyginimas:
        return 'Darbo užmokestis';
      case Rodikliai.darzeliai:
        return 'Darželiu skaičius';
      case Rodikliai.mokyklos:
        return 'Mokyklų skaičius';
      default:
        return '';
    }
  }
}

enum Miestai {
  kaunas,
  vilnius,
  alytus,
  panevezys,
  klaipeda,
  siauliai,
}

extension MiestuPavadinimai on Miestai {
  String get name {
    switch (this) {
      case Miestai.kaunas:
        return 'Kauno apskritis';
      case Miestai.vilnius:
        return 'Vilniaus apskritis';
      case Miestai.alytus:
        return 'Alytaus apskritis';
      case Miestai.panevezys:
        return 'Panevėžio apskritis';
      case Miestai.klaipeda:
        return 'Klaipėdos apskritis';
      case Miestai.siauliai:
        return 'Šiaulių apskritis';
      default:
        return '';
    }
  }
}
