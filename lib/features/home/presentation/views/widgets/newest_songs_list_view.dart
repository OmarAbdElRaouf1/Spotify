import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/features/home/domain/entities/songs_entity.dart';
import 'package:spotify/features/home/presentation/views/widgets/newest_songs_item.dart';

class SongsListView extends StatelessWidget {
  const SongsListView({super.key, required this.songs});

  final List<SongsEntity> songs;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: songs.length,
      separatorBuilder: (_, __) => SizedBox(width: 4.w),
      itemBuilder: (context, index) {
        final song = songs[index];

        return SizedBox(
          width: 220.w,
          child: NewestSongsItem(song: song),
        );
      },
    );
  }
}
