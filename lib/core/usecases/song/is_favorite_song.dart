import 'package:spotify/core/services/get_it.dart';
import 'package:spotify/core/services/songs/songs_supabase_storage.dart';
import 'package:spotify/core/usecase/usecase.dart';

class IsFavoriteSongUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call(params) async {
    return await getIt<SongService>().isFavoriteSong(params);
  }
}
