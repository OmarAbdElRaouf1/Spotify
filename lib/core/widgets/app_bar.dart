import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.showBackButton = true,
    this.showLogo = true,
  });
  final bool? showBackButton;
  final bool? showLogo;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: showLogo == true
          ? SvgPicture.asset(
              'assets/vectors/spotify_logo.svg',
              height: 40.h,
              width: 40.w,
            )
          : null,
      elevation: 0,
      leading: Visibility(
        visible: showBackButton ?? true,
        child: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          color: Colors.transparent,
          disabledColor: Colors.transparent,
          onPressed: () {
            if (showBackButton!) {
              Navigator.pop(context);
            }
          },
          icon: Container(
            height: 32.h,
            width: 32.w,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.white.withOpacity(0.09)
                  : Colors.black.withOpacity(0.09),
              shape: BoxShape.circle,
            ),
            child: context.isDarkMode
                ? SvgPicture.asset(
                    'assets/vectors/back_button.svg',
                    height: 16.h,
                    width: 16.w,
                  )
                : SvgPicture.asset(
                    'assets/vectors/back_light.svg',
                    height: 16.h,
                    width: 16.w,
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
