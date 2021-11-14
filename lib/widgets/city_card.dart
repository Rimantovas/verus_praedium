import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:verus_praedium/globals/globals.dart';
import 'package:verus_praedium/models/city.dart';

class CityCard extends StatelessWidget {
  const CityCard({
    required this.city,
    this.radius = 30,
    this.elevation = 1,
    this.onTap,
    this.borderWidth = 1,
    Key? key,
  }) : super(key: key);

  final City city;
  final double radius;
  final double elevation;
  final double borderWidth;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: AspectRatio(
            aspectRatio: 1,
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(
                  color: Colors.grey,
                  width: borderWidth,
                ),
              ),
              color: Colors.transparent,
              elevation: elevation,
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned(
                    top: -1,
                    left: -1,
                    right: -1,
                    bottom: -1,
                    child: Image.asset(
                      city.imageUrl,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(.5),
                              Colors.black.withOpacity(0),
                            ],
                            stops: const [
                              0.8,
                              1
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                        // borderRadius: BorderRadius.circular(radius),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: RatingStars(
                        starOffColor: const Color(0xFF261563),
                        value: city.getStarRating3(),
                        maxValue: sliderInfo
                                    .where((element) => element['check'])
                                    .length
                                    .toDouble() >
                                0
                            ? sliderInfo
                                .where((element) => element['check'])
                                .length
                                .toDouble()
                            : 8,
                        valueLabelVisibility: false,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(.5),
                                Colors.black.withOpacity(0),
                              ],
                              stops: const [
                                0.5,
                                1
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          // borderRadius: BorderRadius.circular(radius),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            city.name,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      )),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onTap,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
