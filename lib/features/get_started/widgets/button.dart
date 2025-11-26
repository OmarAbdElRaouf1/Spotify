import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  const BasicAppButton({
    required this.onPressed,
    required this.title,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          minimumSize: Size.fromHeight(height ?? 80.sp),
        ),
        child: Text(title),
      ),
    );
  }
}
