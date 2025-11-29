import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/features/get_started/presentation/choose_mode_screen.dart';
import 'package:spotify/core/widgets/basic_app_button.dart';
import 'package:spotify/features/get_started/presentation/widgets/logo.dart';
import 'package:spotify/features/get_started/presentation/widgets/title_and_subtitle.dart';

class GetStartedScreenBody extends StatelessWidget {
  const GetStartedScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/intro_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Logo(),
          Spacer(),
          TitleSubtitle(),
          SizedBox(height: 20.h),
          BasicAppButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ChooseModeScreen()),
                (route) => false,
              );
            },
            title: 'Get Started',
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
