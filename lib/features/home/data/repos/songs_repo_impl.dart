import 'package:dartz/dartz.dart';
import 'package:spotify/core/services/get_it.dart';
import 'package:spotify/core/services/songs/songs_supabase_storage.dart';
import 'package:spotify/features/home/domain/repos/songs_repo.dart';

class SongsRepoImpl extends SongsRepo {
  @override
  Future<Either<dynamic, dynamic>> getNewestSongs() async {
    return await getIt<SongService>().getNewestSongs();
  }

  @override
  Future<Either<dynamic, dynamic>> getPlayList() async {
    return await getIt<SongService>().getPlayList();
  }

  @override
  Future<Either<dynamic, dynamic>> addOrRemoveFromFavorites(
    String songId,
  ) async {
    return await getIt<SongService>().addOrRemoveFromFavorites(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    return await getIt<SongService>().isFavoriteSong(songId);
  }
}
