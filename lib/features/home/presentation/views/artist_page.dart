import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/widgets/app_bar.dart';
import 'package:spotify/features/home/domain/entities/songs_entity.dart';
import 'package:spotify/features/home/presentation/views/widgets/play_list_list_view.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage({super.key, required this.artist, required this.songs});

  final String artist;
  final List<SongsEntity> songs;

  @override
  Widget build(BuildContext context) {
    final coverUrl = songs.isEmpty ? null : songs.first.imageUrl;

    return Scaffold(
      appBar: const AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Container(
                    width: 92.w,
                    height: 92.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode
                          ? const Color(0xff2C2C2C)
                          : const Color(0xffE6E6E6),
                      image: coverUrl == null || coverUrl.isEmpty
                          ? null
                          : DecorationImage(
                              image: NetworkImage(coverUrl),
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: coverUrl == null || coverUrl.isEmpty
                        ? Icon(Icons.person, size: 42.sp)
                        : null,
                  ),
                  SizedBox(width: 18.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          artist,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          '${songs.length} songs',
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: PlayListListView(songs: songs),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
