import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeArtistCard extends StatelessWidget {
  const HomeArtistCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/home_card.png',
      width: 375.w,
      height: 184.h,
      fit: BoxFit.contain,
    );
  }
}
