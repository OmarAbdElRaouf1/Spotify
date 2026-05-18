import 'package:dartz/dartz.dart';
import 'package:spotify/core/services/get_it.dart';
import 'package:spotify/core/services/songs/songs_supabase_storage.dart';
import 'package:spotify/core/usecase/usecase.dart';

class AddOrRemoveFavoriteSongsUseCase implements UseCase<Either, String> {
  @override
  Future<Either<dynamic, dynamic>> call(params) async {
    return await getIt<SongService>().addOrRemoveFromFavorites(params);
  }
}
