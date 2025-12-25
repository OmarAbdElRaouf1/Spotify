import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/extensions.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/features/home/domain/entities/songs_entity.dart';
import 'package:spotify/features/song_player/presentation/views/song_player.dart';

class NewestSongsItem extends StatelessWidget {
  const NewestSongsItem({
    super.key,
    required this.song,
    this.playlist,
    this.index,
  });

  final SongsEntity song;
  final List<SongsEntity>? playlist;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          MaterialPageRoute(
            builder: (context) =>
                SongPlayer(song: song, playlist: playlist, initialIndex: index),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 200.w,
                height: 240.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  image: DecorationImage(
                    image: NetworkImage(song.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                bottom: -25.h,
                right: 0.w,
                child: Container(
                  width: 55.w,
                  height: 55.h,
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? const Color(0xff2C2C2C)
                        : const Color(0xFFE6E6E6),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 6.r,
                        offset: Offset(0, 3.h),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: SvgPicture.asset('assets/vectors/play.svg'),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Text(
            song.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            song.artist,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
