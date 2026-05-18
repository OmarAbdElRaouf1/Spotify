import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/features/profile/data/models/profile_data.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profile,
    required this.isUploading,
    required this.onChangePhoto,
  });

  final ProfileData profile;
  final bool isUploading;
  final VoidCallback onChangePhoto;

  @override
  Widget build(BuildContext context) {
    final avatarLetter = profile.name.isEmpty
        ? 'S'
        : profile.name[0].toUpperCase();

    return Column(
      children: [
        GestureDetector(
          onTap: isUploading ? null : onChangePhoto,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 112.r,
                width: 112.r,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                  image: profile.avatarUrl.isEmpty
                      ? null
                      : DecorationImage(
                          image: NetworkImage(profile.avatarUrl),
                          fit: BoxFit.cover,
                        ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withValues(alpha: 0.28),
                      blurRadius: 26.r,
                      offset: Offset(0, 12.h),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: profile.avatarUrl.isNotEmpty
                    ? null
                    : Text(
                        avatarLetter,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
              ),
              Positioned(
                right: 0,
                bottom: 4.h,
                child: Container(
                  height: 34.r,
                  width: 34.r,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.isDarkMode
                          ? AppColors.darkMode
                          : AppColors.lightMode,
                      width: 3,
                    ),
                  ),
                  child: isUploading
                      ? Padding(
                          padding: EdgeInsets.all(8.r),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 18.h),
        Text(
          profile.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 6.h),
        Text(
          profile.email,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
        ),
      ],
    );
  }
}
