import 'package:spotify/features/home/domain/entities/songs_entity.dart';

abstract class PlayListState {}

class PlayListInitial extends PlayListState {}

class PlayListLoading extends PlayListState {}

class PlayListLoaded extends PlayListState {
  final List<SongsEntity> songs;
  PlayListLoaded(this.songs);
}

class PlayListError extends PlayListState {
  final String message;
  PlayListError(this.message);
}
