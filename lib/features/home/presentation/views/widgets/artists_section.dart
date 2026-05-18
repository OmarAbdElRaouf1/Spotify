import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/common/helpers/extensions.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/features/home/domain/entities/songs_entity.dart';
import 'package:spotify/features/home/presentation/manger/play_list_cubit/play_list_cubit.dart';
import 'package:spotify/features/home/presentation/manger/play_list_cubit/play_list_state.dart';
import 'package:spotify/features/home/presentation/views/artist_page.dart';
import 'package:spotify/features/home/presentation/views/widgets/paly_list_item_shimmer_loading.dart';

class ArtistsSection extends StatelessWidget {
  const ArtistsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayListCubit()..fetchPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return const PlayListItemShimmerLoading(itemCount: 4);
          }

          if (state is PlayListError) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is! PlayListLoaded) {
            return const SizedBox.shrink();
          }

          final artists = _groupSongsByArtist(state.songs);

          if (artists.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Artists',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              SizedBox(
                height: 138.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: artists.length,
                  separatorBuilder: (_, __) => SizedBox(width: 14.w),
                  itemBuilder: (context, index) {
                    final entry = artists.entries.elementAt(index);
                    return _ArtistTile(artist: entry.key, songs: entry.value);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Map<String, List<SongsEntity>> _groupSongsByArtist(List<SongsEntity> songs) {
    final artists = <String, List<SongsEntity>>{};

    for (final song in songs) {
      final artist = song.artist.trim().isEmpty
          ? 'Unknown Artist'
          : song.artist;
      artists.putIfAbsent(artist, () => []).add(song);
    }

    return artists;
  }
}

class _ArtistTile extends StatelessWidget {
  const _ArtistTile({required this.artist, required this.songs});

  final String artist;
  final List<SongsEntity> songs;

  @override
  Widget build(BuildContext context) {
    final coverUrl = songs.isEmpty ? null : songs.first.imageUrl;

    return GestureDetector(
      onTap: () {
        context.push(
          MaterialPageRoute(
            builder: (_) => ArtistPage(artist: artist, songs: songs),
          ),
        );
      },
      child: SizedBox(
        width: 104.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 88.w,
              height: 88.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.isDarkMode
                    ? const Color(0xff2C2C2C)
                    : const Color(0xffE6E6E6),
                image: coverUrl == null || coverUrl.isEmpty
                    ? null
                    : DecorationImage(
                        image: NetworkImage(coverUrl),
                        fit: BoxFit.cover,
                      ),
              ),
              child: coverUrl == null || coverUrl.isEmpty
                  ? Icon(Icons.person, size: 34.sp)
                  : null,
            ),
            SizedBox(height: 10.h),
            Text(
              artist,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
            Text(
              '${songs.length} songs',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11.sp, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
