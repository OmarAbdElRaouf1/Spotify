import 'package:bloc/bloc.dart';
import 'package:spotify/core/usecases/song/get_newest_songs.dart';

import 'package:spotify/features/home/presentation/manger/newest_songs_cubit/newest_songs_state.dart';

import '../../../../../core/services/get_it.dart';

class NewestSongsCubit extends Cubit<NewestSongsState> {
  NewestSongsCubit() : super(NewestSongsInitial());

  Future<void> fetchNewestSongs() async {
    emit(NewestSongsLoading());
    try {
      var returnedSongs = await getIt<GetNewestSongs>().call(null);

      returnedSongs.fold(
        (l) => emit(NewestSongsError(l.toString())),
        (songs) => emit(NewestSongsLoaded(songs)),
      );
    } catch (e) {
      emit(NewestSongsError(e.toString()));
    }
  }
}
