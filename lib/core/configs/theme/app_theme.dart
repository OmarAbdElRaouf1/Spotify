import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.lightMode,
    fontFamily: 'Satoshi',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        // backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
    ),
  );
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Satoshi',
    // primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.darkMode,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        // backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
    ),
  );
}
