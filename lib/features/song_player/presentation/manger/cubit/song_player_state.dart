abstract class SongPlayerState {}

final class SongPlayerLoading extends SongPlayerState {}

final class SongPlayerLoaded extends SongPlayerState {}

final class SongPlayerPlaying extends SongPlayerState {}

final class SongPlayerPaused extends SongPlayerState {}

final class SongPlayerError extends SongPlayerState {
  final String message;
  SongPlayerError(this.message);
}
