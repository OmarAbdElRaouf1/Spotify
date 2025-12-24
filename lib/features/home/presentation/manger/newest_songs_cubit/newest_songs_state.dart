import 'package:spotify/features/home/domain/entities/songs_entity.dart';

abstract class NewestSongsState {}

class NewestSongsInitial extends NewestSongsState {}

class NewestSongsLoading extends NewestSongsState {}

class NewestSongsLoaded extends NewestSongsState {
  final List<SongsEntity> songs;
  NewestSongsLoaded(this.songs);
}

class NewestSongsError extends NewestSongsState {
  final String message;
  NewestSongsError(this.message);
}
