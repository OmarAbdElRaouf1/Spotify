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
        } else if (state is SongPlayerError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(height: 12),
              SongPlayerSliderAndToggles(),
            ],
          );
        } else {
          return SongPlayerSliderAndToggles();
        }
      },
    );
  }
}
