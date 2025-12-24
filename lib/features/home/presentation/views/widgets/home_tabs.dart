import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerColor: Colors.transparent,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      unselectedLabelColor: Colors.grey,
      splashBorderRadius: BorderRadius.circular(30.r),
      overlayColor: WidgetStateProperty.all(
        context.isDarkMode ? AppColors.darkMode : AppColors.lightMode,
      ),
      controller: tabController,
      indicatorColor: Colors.green,
      labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
      tabs: const [
        Tab(text: 'News'),
        Tab(text: 'Videos'),
        Tab(text: 'Artists'),
        Tab(text: 'Podcasts'),
      ],
    );
  }
}
