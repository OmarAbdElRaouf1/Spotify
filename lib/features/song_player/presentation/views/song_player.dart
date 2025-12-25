import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/features/home/domain/entities/songs_entity.dart';
import 'package:spotify/features/song_player/presentation/manger/cubit/song_player_cubit.dart';
import 'package:spotify/features/song_player/presentation/views/widgets/app_bar.dart';
import 'package:spotify/features/song_player/presentation/views/widgets/song_cover.dart';
import 'package:spotify/features/song_player/presentation/views/widgets/song_player_bloc_builder.dart';

class SongPlayer extends StatelessWidget {
  const SongPlayer({
    super.key,
    required this.song,
    this.playlist,
    this.initialIndex,
  });

  final SongsEntity song;
  final List<SongsEntity>? playlist;
  final int? initialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SongPlayerAppBar(),
      body: BlocProvider(
        create: (context) => SongPlayerCubit()
          ..loadSong(
            song.songUrl,
            song: song,
            songs: playlist,
            index: initialIndex ?? 0,
          ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              BlocBuilder<SongPlayerCubit, dynamic>(
                builder: (context, state) {
                  final cubit = context.read<SongPlayerCubit>();
                  final currentSong = cubit.currentSong ?? song;
                  return SongCoverAndDetails(song: currentSong);
                },
              ),
              SizedBox(height: 30.h),
              SongPlayerBlocBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
