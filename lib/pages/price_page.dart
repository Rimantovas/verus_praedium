import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verus_praedium/globals/globals.dart';
import 'package:verus_praedium/models/city.dart';
import 'package:verus_praedium/widgets/custom_button.dart';

class PricePage extends StatefulWidget {
  const PricePage({Key? key, required this.cities}) : super(key: key);
  final List<City> cities;
  @override
  _PricePageState createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  bool isNamas = true;
  bool isEuras = true;
  bool showResults = false;
  final controller = TextEditingController();

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text('Būsto skaičiuoklė'),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: const Icon(Icons.info_outline, color: Colors.white),
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text('Instrukcijos',
                              style: TextStyle(color: Colors.black)),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Duomenys buvo imti iš oficialiosios statistikos portalo:',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextButton(
                                  onPressed: () {
                                    _launchURL('https://osp.stat.gov.lt/');
                                  },
                                  child:
                                      const Text('https://osp.stat.gov.lt/')),
                              // TextButton(
                              //     onPressed: () {
                              //       _launchURL(
                              //           'https://osp.stat.gov.lt/statistiniu-rodikliu-analize#/');
                              //     },
                              //     child: const Text(
                              //         'https://osp.stat.gov.lt/statistiniu-rodikliu-analize#/')),
                              const Text(
                                'Šioje skaičiuoklėje galima pasirinkti būsto tipą (namas arba butas) ir skaičiavimą pagal eurus ar sklypo plotą.\n\nInformacijos įvedimo lauke galima rašyti tik arabiškus skaičius.\nSkaičių limitai:\nPagal eurus: 8 simboliai\nPagal sklypo plotą: 6 simboliai\n\nPaspaudus mygtuką „Žiūrėti rezultatus“, ekrano apačioje atsiras informacija apie kiekvieno miesto galimas butų kainas pagal sklypo plotą.',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  })
            ]),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text('Pasirinkite jus dominantį būsto tipą'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() {
                    isNamas = true;
                  }),
                  child: const Text('Namai'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(width * .3, 30),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      primary: isNamas
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).canvasColor),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    isNamas = false;
                  }),
                  child: const Text('Butai'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(width * .3, 30),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      primary: !isNamas
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).canvasColor),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text('Skaičiuoti pagal: '),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() {
                    isEuras = true;
                    controller.clear();
                  }),
                  child: const Text('Eurus'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(width * .3, 30),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      primary: isEuras
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).canvasColor),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    isEuras = false;
                    controller.clear();
                  }),
                  child: const Text('Sklypo plotą'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(width * .3, 30),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      primary: !isEuras
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).canvasColor),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(isEuras
                  ? 'Įrašykite norimą būsto kainą'
                  : 'Įrašykite norimą kvadratinių metrų plotą'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextFormField(
                controller: controller,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                cursorColor: const Color(0xFF502BA0),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                keyboardType: TextInputType.number,
                maxLength: isEuras ? 8 : 6,
                decoration: InputDecoration(
                  hintText: isEuras ? 'Kaina' : 'Plotas',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF502BA0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF502BA0))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF502BA0))),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 40.0),
              child: CustomButton(
                  function: () {
                    setState(() {
                      showResults = true;
                    });
                    FocusScope.of(context).unfocus();
                  },
                  text: 'Žiūrėti rezultatus'),
            ),
            Expanded(
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, scale) => ScaleTransition(
                        scale: scale,
                        child: child,
                      ),
                  child: controller.text.isNotEmpty && showResults
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            widget.cities.sort((a, b) => -a
                                .getPriceRating(isNamas
                                    ? Rodikliai.namuKainos
                                    : Rodikliai.butuKainos)
                                .compareTo(b.getPriceRating(isNamas
                                    ? Rodikliai.namuKainos
                                    : Rodikliai.butuKainos)));

                            City city = widget.cities[index];
                            return ListTile(
                              title: Text(city.name),
                              subtitle: RatingStars(
                                starColor:
                                    Theme.of(context).colorScheme.secondary,
                                starOffColor: const Color(0xFF261563),
                                value: city.getPriceRating(isNamas
                                    ? Rodikliai.namuKainos
                                    : Rodikliai.butuKainos),
                                maxValue: 1,
                                valueLabelVisibility: false,
                              ),
                              trailing: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: !isEuras
                                        ? '${(city.results[isNamas ? Rodikliai.namuKainos : Rodikliai.butuKainos]!.vidurkis * double.parse(controller.text)).toStringAsFixed(0)} €'
                                        : '${(double.parse(controller.text) / city.results[isNamas ? Rodikliai.namuKainos : Rodikliai.butuKainos]!.vidurkis).toStringAsFixed(2)} m',
                                  ),
                                  if (isEuras)
                                    const TextSpan(
                                        text: '2',
                                        style: TextStyle(fontFeatures: [
                                          FontFeature.superscripts()
                                        ]))
                                ]),
                              ),
                            );
                          },
                          itemCount: widget.cities.length,
                        )
                      : Image.asset(
                          'assets/images/present.png',
                          fit: BoxFit.cover,
                        )),
            )
          ],
        ),
      ),
    );
  }
}
