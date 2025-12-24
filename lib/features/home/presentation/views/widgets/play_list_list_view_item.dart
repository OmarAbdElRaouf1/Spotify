import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/features/home/domain/entities/songs_entity.dart';

import '../../../../../common/helpers/is_dark_mode.dart';

class PlayListListViewItem extends StatelessWidget {
  const PlayListListViewItem({
    super.key,
    required this.songs,
    required this.index,
  });

  final List<SongsEntity> songs;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.isDarkMode
                ? AppColors.darkGrey
                : const Color(0xffE6E6E6),
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/vectors/play.svg',
              height: 20.h,
              width: 20.w,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songs[index].title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              songs[index].artist,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
            ),
          ],
        ),
      ],
    );
  }
}
