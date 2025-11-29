import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BgImages extends StatelessWidget {
  const BgImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: SvgPicture.asset('assets/vectors/top_pattern.svg'),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SvgPicture.asset('assets/vectors/bottom_pattern.svg'),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Image.asset('assets/images/auth_bg.png'),
        ),
      ],
    );
  }
}
