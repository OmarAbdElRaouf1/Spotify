import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleSubtitle extends StatelessWidget {
  const TitleSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Enjoy Listening to Music',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25.h),
        Text(
          'Lorem ipsum dolor sit amet,\n consectetur adipiscing elit. Sagittis enim\n purus sed phasellus. Cursus ornare id\n scelerisque aliquam.',
          style: TextStyle(color: Colors.grey, fontSize: 13.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
