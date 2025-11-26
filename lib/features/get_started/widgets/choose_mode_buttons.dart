import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/features/get_started/manger/theme_cubit.dart';

class ChooseModeButtons extends StatelessWidget {
  const ChooseModeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: () {
                context.read<ThemeCubit>().updateTheme(ThemeMode.light);
              },
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    height: 80.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff30393c).withOpacity(0.5),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/vectors/sun.svg',
                        width: 40.w,
                        height: 40.h,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Light Mode',
              style: TextStyle(
                color: AppColors.lightMode,
                fontWeight: FontWeight.w500,
                fontSize: 17.sp,
              ),
            ),
          ],
        ),
        SizedBox(width: 40.w),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
              },
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    height: 80.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff30393c).withOpacity(0.5),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/vectors/moon.svg',
                        width: 40.w,
                        height: 40.h,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Dark Mode',
              style: TextStyle(
                color: AppColors.lightMode,
                fontWeight: FontWeight.w500,
                fontSize: 17.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
