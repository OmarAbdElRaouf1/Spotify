import 'package:bloc/bloc.dart';

import 'package:spotify/core/services/get_it.dart';
import 'package:spotify/core/usecases/song/get_play_list.dart';
import 'package:spotify/features/home/presentation/manger/play_list_cubit/play_list_state.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListInitial());
  Future<void> fetchPlayList() async {
    emit(PlayListLoading());
    try {
      var returnedSongs = await getIt<GetPlayList>().call(null);

      returnedSongs.fold(
        (l) => emit(PlayListError(l.toString())),
        (songs) => emit(PlayListLoaded(songs)),
      );
    } catch (e) {
      emit(PlayListError(e.toString()));
    }
  }
}
