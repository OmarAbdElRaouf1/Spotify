import 'package:flutter/material.dart';

import '../../../domain/entities/songs_entity.dart';
import 'favorite_button.dart';
import 'play_list_list_view_item.dart';

class PlayListListView extends StatelessWidget {
  const PlayListListView({super.key, required this.songs});
  final List<SongsEntity> songs;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PlayListListViewItem(songs: songs, index: index),
            Row(
              children: [
                Text(songs[index].duration.toString().replaceAll('.', ':')),
                const SizedBox(width: 20),
                FavoriteButton(),
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
