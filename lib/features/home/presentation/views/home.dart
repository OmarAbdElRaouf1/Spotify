import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/core/widgets/app_bar.dart';
import 'package:spotify/features/home/presentation/views/widgets/artists_section.dart';
import 'package:spotify/features/home/presentation/views/widgets/home_artist_card.dart';
import 'package:spotify/features/home/presentation/views/widgets/newest_songs.dart';
import 'package:spotify/features/home/presentation/views/widgets/play_list.dart';
import 'package:spotify/features/profile/presentation/views/profile.dart';

class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({super.key, required this.child});
  final Widget child;

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        showBackButton: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
              icon: const Icon(Icons.person_outline_rounded),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeArtistCard(),
            SizedBox(height: 20.h),
            SizedBox(
              height: 320.h,
              child: KeepAliveWrapper(child: NewestSongsBlocBuilder()),
            ),
            ArtistsSection(),
            SizedBox(height: 24.h),
            PlayList(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
