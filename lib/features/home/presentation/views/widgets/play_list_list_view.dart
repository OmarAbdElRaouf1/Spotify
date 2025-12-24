import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/features/home/domain/entities/songs_entity.dart';
import 'package:spotify/features/home/presentation/views/widgets/play_list_list_view_item.dart';

class PlayListListView extends StatelessWidget {
  const PlayListListView({super.key, required this.songs});
  final List<SongsEntity> songs;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PlayListListViewItem(songs: songs, index: index),
            Row(
              children: [
                Text(songs[index].duration.toString().replaceAll('.', ':')),
                // const SizedBox(width: 20,),
                // FavoriteButton(
                //   songEntity: songs[index],
                // )
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: songs.length,
    );
  }
}
