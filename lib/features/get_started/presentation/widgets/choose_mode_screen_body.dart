import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/features/auth/presentation/pages/signup_or_signin.dart';
import 'package:spotify/core/widgets/basic_app_button.dart';
import 'package:spotify/features/get_started/presentation/widgets/choose_mode_buttons.dart';
import 'package:spotify/features/get_started/presentation/widgets/logo.dart';

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
          BasicAppButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    // Replace with the actual next screen
                    return SignupOrSignin();
                  },
                ),
              );
            },
            title: 'Continue',
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
