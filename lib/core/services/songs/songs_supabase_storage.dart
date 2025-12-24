import 'package:dartz/dartz.dart';
import 'package:spotify/features/home/data/models/songs_model.dart';
import 'package:spotify/features/home/domain/entities/songs_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SongService {
  Future<Either<dynamic, List<SongsEntity>>> getNewestSongs();
  Future<Either<dynamic, List<SongsEntity>>> getPlayList();
}

class SongServiceImpl implements SongService {
  final supabase = Supabase.instance.client;

  @override
  Future<Either<dynamic, List<SongsEntity>>> getNewestSongs() async {
    try {
      final response = await supabase
          .from('songs')
          .select()
          .order('releaseDate', ascending: false);

      print('✅ Response from Supabase: $response');
      print('✅ Response type: ${response.runtimeType}');

      if ((response.isEmpty)) {
        print('⚠️ No songs found in database');
        return const Right([]);
      }

      List<SongsEntity> songs = (response as List).map((songData) {
        print('🎵 Processing song: $songData');
        return SongsModel.fromJson(songData); // SongsModel extends SongsEntity
      }).toList();

      print('✅ Total songs loaded: ${songs.length}');
      return Right(songs);
    } catch (e) {
      print('❌ Error loading songs: $e');
      return Left(e);
    }
  }

  @override
  Future<Either<dynamic, List<SongsEntity>>> getPlayList() async {
    try {
      final response = await supabase.from('songs').select();

      print('✅ Response from Supabase: $response');
      print('✅ Response type: ${response.runtimeType}');

      if ((response.isEmpty)) {
        print('⚠️ No songs found in database');
        return const Right([]);
      }

      List<SongsEntity> songs = (response as List).map((songData) {
        print('🎵 Processing song: $songData');
        return SongsModel.fromJson(songData); // SongsModel extends SongsEntity
      }).toList();

      print('✅ Total songs loaded: ${songs.length}');
      return Right(songs);
    } catch (e) {
      print('❌ Error loading songs: $e');
      return Left(e);
    }
  }
}
