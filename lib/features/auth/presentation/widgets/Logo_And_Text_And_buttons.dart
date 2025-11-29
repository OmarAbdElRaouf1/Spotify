import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/features/auth/presentation/pages/signin_screen.dart';
import 'package:spotify/features/auth/presentation/pages/signup_screen.dart';

class LogoAndTextAndButtons extends StatelessWidget {
  const LogoAndTextAndButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/vectors/spotify_logo.svg'),
        SizedBox(height: 55.h),
        Text(
          'Enjoy Listening To Music',
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 21.h),
        Text(
          'Spotify is a proprietary Swedish audio\n streaming and media services provider ',
          style: TextStyle(
            color: const Color(0xFFA0A0A0),
            fontSize: 17.sp,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30.h),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  // Navigator.pushNamed(context, '/signup');
                  return SignupScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1ED760),
            minimumSize: Size(327.w, 56.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SigninScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            minimumSize: Size(327.w, 56.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.r),
              side: const BorderSide(color: Colors.white),
            ),
          ),
          child: Text(
            'Sign In',
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
