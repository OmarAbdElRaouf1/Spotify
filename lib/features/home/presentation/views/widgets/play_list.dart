import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/features/home/presentation/manger/play_list_cubit/play_list_cubit.dart';
import 'package:spotify/features/home/presentation/manger/play_list_cubit/play_list_state.dart';
import 'package:spotify/features/home/presentation/views/widgets/play_list_and_see_more.dart';
import 'package:spotify/features/home/presentation/views/widgets/play_list_list_view.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayListCubit()..fetchPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PlayListLoaded) {
            final songs = state.songs;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  PlayListAndSeeMore(),
                  PlayListListView(songs: songs),
                ],
              ),
            );
          } else if (state is PlayListError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
