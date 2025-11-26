import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/features/get_started/widgets/button.dart';
import 'package:spotify/features/get_started/widgets/choose_mode_buttons.dart';
import 'package:spotify/features/get_started/widgets/logo.dart';

class ChooseModeScreenBody extends StatelessWidget {
  const ChooseModeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/choose_mode_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Logo(),
          Spacer(),
          Text(
            'Choose Mode',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.sp,
            ),
          ),
          SizedBox(height: 23.h),
          ChooseModeButtons(),
          SizedBox(height: 80.h),
          BasicAppButton(onPressed: () {}, title: 'Continue'),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
