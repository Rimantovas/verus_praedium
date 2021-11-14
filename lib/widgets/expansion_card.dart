import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:verus_praedium/globals/globals.dart';
import 'package:verus_praedium/models/city.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ExpansionCard extends StatefulWidget {
  const ExpansionCard({
    Key? key,
    required this.city,
    required this.rodiklis,
    required this.charts,
  }) : super(key: key);
  final City city;
  final Rodikliai rodiklis;
  final List<Widget> charts;
  @override
  _ExpansionCardState createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard> {
  CarouselController buttonCarouselController = CarouselController();
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
              '${widget.rodiklis.name} (${widget.city.results[widget.rodiklis]!.matVnt}):'),
          subtitle: RatingStars(
            starColor: Theme.of(context).colorScheme.secondary,
            starOffColor: const Color(0xFF261563),
            value: widget.city.getIndividualStarRating(widget.rodiklis),
            maxValue: 1,
            // maxValue: sliderInfo
            //     .where((element) => element['check'])
            //     .length
            //     .toDouble(),
            valueLabelVisibility: false,
          ),
          trailing: IconButton(
              onPressed: () => setState(() {
                    isExpanded = !isExpanded;
                  }),
              icon: Icon(!isExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_up)),
        ),
        if (isExpanded)
          Stack(
            children: [
              CarouselSlider(
                carouselController: buttonCarouselController,
                items: widget.charts
                    .map((e) => Container(
                          width: MediaQuery.of(context).size.width * .95,
                          margin: const EdgeInsets.all(8),
                          child: e,
                        ))
                    .toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ),
              Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 5),
                      child: IconButton(
                          onPressed: () {
                            buttonCarouselController.nextPage();
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 30,
                          ))))
            ],
          )
      ],
    );
  }
}
