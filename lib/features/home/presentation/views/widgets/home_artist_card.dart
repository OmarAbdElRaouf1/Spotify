import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeArtistCard extends StatelessWidget {
  const HomeArtistCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/vectors/home_top_card.svg'),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 60, bottom: 10).r,
                child: Image.asset('assets/images/home_artist.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
