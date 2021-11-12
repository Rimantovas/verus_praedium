import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  const CityCard({
    required this.imageUrl,
    required this.city,
    this.radius = 30,
    this.elevation = 1,
    this.onTap,
    this.borderWidth = 1,
    Key? key,
  }) : super(key: key);

  final String imageUrl;
  final String city;
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
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.5),
                          // borderRadius: BorderRadius.circular(radius),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            city,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
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
        const Text(
          'Score: 15',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
