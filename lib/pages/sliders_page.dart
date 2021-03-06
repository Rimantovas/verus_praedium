import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verus_praedium/globals/globals.dart';
import 'package:verus_praedium/models/city.dart';
import 'package:verus_praedium/pages/cities_page.dart';

class SlidersPage extends StatefulWidget {
  const SlidersPage({Key? key, required this.cities}) : super(key: key);

  final List<City> cities;

  @override
  State<SlidersPage> createState() => _SlidersPageState();
}

class _SlidersPageState extends State<SlidersPage> {
  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: const Text('Reitingų skaičiuoklė'),
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
                                child: const Text('https://osp.stat.gov.lt/')),
                            // TextButton(
                            //     onPressed: () {
                            //       _launchURL(
                            //           'https://osp.stat.gov.lt/statistiniu-rodikliu-analize#/');
                            //     },
                            //     child: const Text(
                            //         'https://osp.stat.gov.lt/statistiniu-rodikliu-analize#/')),
                            const Text(
                              'Skaičiavimo paaiškinimas:\nSlankiklio reikšmės yra intervale nuo mažiausios rodiklio reikšmės iki didžiausios rodiklio reikšmės.\n\nPaslinkus slankiklius į norimas vietas ir paspaudus "Žiūrėti rezultatus", daugiausia balų bus duodama tiem miestam kurių rodiklių reikšmės buvo arčiausiai slankiklio, ir mažiausia balų - kurios buvo toliausiai',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      );
                    },
                  );
                })
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        child: const Text('Žiūrėti rezultatus'),
        style: const ButtonStyle().copyWith(
          fixedSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width * 0.8, 50)),
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CitiesPage(
                        cities: widget.cities,
                      )));
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // SliverToBoxAdapter(
            //     child: Column(children: [
            //   Image.asset('assets/images/questionSmall.png',
            //       alignment: Alignment.topRight, width: 25, height: 25)
            // ])),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Image.asset('assets/images/data.png'),
                  const Text(
                    'Pasirinkite jums svarbius rodiklius ieškant svajonių krašto',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 40,
                    indent: 50,
                    endIndent: 50,
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: sliderInfo.firstWhereOrNull(
                                      (element) => element['check'] == false) !=
                                  null
                              ? false
                              : true,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (value) {
                            setState(() {
                              for (var element in sliderInfo) {
                                element['check'] = value;
                              }
                            });
                          }),
                      const Text('Select/Unselect all')
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        for (var element in sliderInfo) {
                          setState(() {
                            element['value'] = .5;
                          });
                        }
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ))
                ],
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: sliderInfo[index]['check'] as bool,
                    onChanged: (value) => setState(() {
                      sliderInfo[index]['check'] = value;
                    }),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            '${(sliderInfo[index]['name'] as Rodikliai).name}:',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius:
                                      sliderInfo[index]['value'] * 15 + 5)),
                          child: Slider(
                              value: sliderInfo[index]['value'].toDouble(),
                              activeColor: (sliderInfo[index]['check'] as bool)
                                  ? Theme.of(context).primaryColor
                                  : const Color(0xFF656565),
                              inactiveColor:
                                  Theme.of(context).colorScheme.secondary,
                              max: 1,
                              // divisions: 5,
                              onChanged: (value) => sliderInfo[index]['check']
                                  ? setState(() {
                                      sliderInfo[index]['value'] = value;
                                    })
                                  : null),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }, childCount: sliderInfo.length)),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
