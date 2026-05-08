import 'package:dartz/dartz.dart';
import 'package:spotify/features/home/data/models/songs_model.dart';
import 'package:spotify/features/home/domain/entities/songs_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SongService {
  Future<Either<dynamic, List<SongsEntity>>> getNewestSongs();
  Future<Either<dynamic, List<SongsEntity>>> getPlayList();

  Future<Either<dynamic, bool>> addOrRemoveFromFavorites(String songId);
  Future<bool> isFavoriteSong(String songId);
}

class SongServiceImpl implements SongService {
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  Future<Either<dynamic, List<SongsEntity>>> getNewestSongs() async {
    try {
      final response = await supabase
          .from('songs')
          .select()
          .order('releasedate', ascending: false);

      final songs = response
          .map<SongsEntity>((songData) => SongsModel.fromJson(songData))
          .toList();

      return Right(songs);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<dynamic, List<SongsEntity>>> getPlayList() async {
    try {
      final response = await supabase.from('songs').select();

      final songs = response
          .map<SongsEntity>((songData) => SongsModel.fromJson(songData))
          .toList();

      return Right(songs);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<dynamic, bool>> addOrRemoveFromFavorites(String songId) async {
    try {
      final user = supabase.auth.currentUser;
      late bool isFavorite;

      if (user == null) {
        return const Left('User not logged in');
      }

      final userId = user.id;

      final existingFavorite = await supabase
          .from('favorites')
          .select('id')
          .eq('user_id', userId)
          .eq('song_id', songId)
          .maybeSingle();

      if (existingFavorite != null) {
        await supabase
            .from('favorites')
            .delete()
            .eq('user_id', userId)
            .eq('song_id', songId);
        isFavorite = false;

        return const Right(false); // removed from favorites
      } else {
        await supabase.from('favorites').insert({
          'user_id': userId,
          'song_id': songId,
        });
        isFavorite = true;
      }

      return Right(isFavorite); // added to favorites
    } on PostgrestException catch (e) {
      return Left(e.message);
    } on AuthException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final user = supabase.auth.currentUser;

      final userId = user!.id;

      final existingFavorite = await supabase
          .from('favorites')
          .select('id')
          .eq('user_id', userId)
          .eq('song_id', songId)
          .maybeSingle();

      if (existingFavorite != null) {
        return true; // is a favorite
      } else {
        return false; // not a favorite
      }
    } catch (e) {
      return false;
    }
  }
}
