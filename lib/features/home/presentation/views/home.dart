import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/core/widgets/app_bar.dart';
import 'package:spotify/features/home/presentation/views/widgets/home_artist_card.dart';
import 'package:spotify/features/home/presentation/views/widgets/home_tabs.dart';
import 'package:spotify/features/home/presentation/views/widgets/newest_songs.dart';
import 'package:spotify/features/home/presentation/views/widgets/play_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(showBackButton: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeArtistCard(),
            SizedBox(height: 10.h),
            HomeTabs(tabController: tabController),
            SizedBox(height: 20.h),
            SizedBox(
              height: 320.h,
              child: TabBarView(
                controller: tabController,
                children: [
                  NewestSongs(),

                  Center(child: Text('Popular Songs')),
                  Center(child: Text('Recommended Songs')),
                  Center(child: Text('Top Charts')),
                ],
              ),
            ),
            PlayList(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
