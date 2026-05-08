import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/common/helpers/helper_functions.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/features/song_player/presentation/manger/cubit/song_player_cubit.dart';

class SongPlayerSliderAndToggles extends StatelessWidget {
  const SongPlayerSliderAndToggles({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SongPlayerCubit>();
    final maxValue = cubit.songDuration.inMilliseconds > 0
        ? cubit.songDuration.inMilliseconds.toDouble()
        : 1.0;
    final currentValue = cubit.songPosition.inMilliseconds
        .toDouble()
        .clamp(0.0, maxValue)
        .toDouble();

    return Column(
      children: [
        Slider(
          thumbColor: AppColors.primaryColor,
          activeColor: AppColors.primaryColor,
          value: currentValue,
          max: maxValue,
          min: 0.0,
          onChanged: (value) {
            cubit.seek(Duration(milliseconds: value.toInt()));
          },
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(formatDuration(cubit.songPosition)),
              Spacer(),
              Text(formatDuration(cubit.songDuration)),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  final cubit = context.read<SongPlayerCubit>();
                  log(
                    'Previous button pressed. Playlist length: ${cubit.playlist.length}',
                  );
                  if (cubit.playlist.isNotEmpty) {
                    cubit.playPreviousSong();
                  }
                },
                icon: Icon(Icons.skip_previous_rounded, size: 32.sp),
              ),
              Container(
                height: 70.h,
                width: 70.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withValues(alpha: 0.4),
                      blurRadius: 20.r,
                      spreadRadius: 5.r,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    size: 40.sp,
                    cubit.audioPlayer.playing
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    cubit.playOrPauseSong();
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  final cubit = context.read<SongPlayerCubit>();
                  log(
                    'Next button pressed. Playlist length: ${cubit.playlist.length}',
                  );
                  if (cubit.playlist.isNotEmpty) {
                    cubit.playNextSong();
                  }
                },
                icon: Icon(Icons.skip_next_rounded, size: 32.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
