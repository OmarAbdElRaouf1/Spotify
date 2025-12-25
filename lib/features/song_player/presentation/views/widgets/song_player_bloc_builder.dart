import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/features/song_player/presentation/manger/cubit/song_player_cubit.dart';
import 'package:spotify/features/song_player/presentation/manger/cubit/song_player_state.dart';
import 'package:spotify/features/song_player/presentation/views/widgets/song_player_slider_and_toggles.dart';

class SongPlayerBlocBuilder extends StatelessWidget {
  const SongPlayerBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SongPlayerLoaded) {
          return SongPlayerSliderAndToggles();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
