import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';

class SongPlayerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SongPlayerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: SvgPicture.asset(
          'assets/vectors/back_button.svg',
          color: context.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
      ],

      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        'Now playing',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: context.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
