import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/features/home/domain/entities/songs_entity.dart';
import 'package:spotify/features/song_player/presentation/manger/cubit/song_player_cubit.dart';
import 'package:spotify/features/song_player/presentation/views/widgets/app_bar.dart';
import 'package:spotify/features/song_player/presentation/views/widgets/song_cover.dart';
import 'package:spotify/features/song_player/presentation/views/widgets/song_player_bloc_builder.dart';

class SongPlayer extends StatefulWidget {
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
  State<SongPlayer> createState() => _SongPlayerState();
}

class _SongPlayerState extends State<SongPlayer> {
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;
    _loaded = true;
    context.read<SongPlayerCubit>().loadSong(
      widget.song.songUrl,
      song: widget.song,
      songs: widget.playlist,
      index: widget.initialIndex ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SongPlayerAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            BlocBuilder<SongPlayerCubit, dynamic>(
              builder: (context, state) {
                final cubit = context.read<SongPlayerCubit>();
                final currentSong = cubit.currentSong ?? widget.song;
                return SongCoverAndDetails(song: currentSong);
              },
            ),
            SizedBox(height: 30.h),
            SongPlayerBlocBuilder(),
          ],
        ),
      ),
    );
  }
}
