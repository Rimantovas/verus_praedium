List<Map<String, dynamic>> images = [
  {
    'name': 'Kaunas',
    'enum': Miestai.kaunas,
    'url':
        'https://c4.wallpaperflare.com/wallpaper/877/260/932/the-city-cathedral-lithuania-kaunas-wallpaper-preview.jpg'
  },
  {
    'name': 'Vilnius',
    'enum': Miestai.vilnius,
    'url': 'https://wallpapercave.com/wp/wp4187171.jpg'
  },
  {
    'name': 'Klaipėda',
    'enum': Miestai.klaipeda,
    'url':
        'https://media.gettyimages.com/photos/high-angle-view-of-cityscape-against-sky-picture-id892905584?k=20&m=892905584&s=612x612&w=0&h=zIAvh3RP5J_HdCjplniGm-R-QhJYCgPSqvp7lsazQ7Y='
  },
  {
    'name': 'Šiauliai',
    'enum': Miestai.siauliai,
    'url':
        'https://image.shutterstock.com/image-photo/siauliai-city-scapes-600w-780934642.jpg'
  },
  {
    'name': 'Panevėžys',
    'enum': Miestai.panevezys,
    'url':
        'https://image.shutterstock.com/image-photo/aerial-view-panevezys-cathedral-260nw-1399228874.jpg'
  },
  {
    'name': 'Alytus',
    'enum': Miestai.alytus,
    'url':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Alytus.png/375px-Alytus.png'
  }
];

List<Map<String, dynamic>> sliderInfo = [
  {'name': Rodikliai.nusikaltimai, 'value': .5, 'check': true},
  {'name': Rodikliai.pastatuSkaicius, 'value': .5, 'check': true},
  {'name': Rodikliai.namuKainos, 'value': .5, 'check': true},
  {'name': Rodikliai.butuKainos, 'value': .5, 'check': true},
  {'name': Rodikliai.uzimtumas, 'value': .5, 'check': true},
  {'name': Rodikliai.atlyginimas, 'value': .5, 'check': true},
  {'name': Rodikliai.darzeliai, 'value': .5, 'check': true},
  {'name': Rodikliai.mokyklos, 'value': .5, 'check': true}
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
        return 'Nusikaltimų skaičius:';
      case Rodikliai.pastatuSkaicius:
        return 'Baigtų statyti pastatų skaičius:';
      case Rodikliai.namuKainos:
        return 'Namų vidutinės kainos:';
      case Rodikliai.butuKainos:
        return 'Butų vidutinės kainos:';
      case Rodikliai.uzimtumas:
        return 'Užimtumo lygis:';
      case Rodikliai.atlyginimas:
        return 'Darbo užmokestis:';
      case Rodikliai.darzeliai:
        return 'Darželiu skaičius:';
      case Rodikliai.mokyklos:
        return 'Mokyklų skaičius:';
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
