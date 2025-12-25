import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/features/home/domain/entities/songs_entity.dart';
import 'package:spotify/features/song_player/presentation/manger/cubit/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  List<SongsEntity> playlist = [];
  int currentIndex = 0;
  SongsEntity? currentSong;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerStateSubscription;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    _durationSubscription = audioPlayer.durationStream.listen((duration) {
      songDuration = duration ?? Duration.zero;
      updateSongPlayer();
    });

    _positionSubscription = audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    // Listen for when song completes
    _playerStateSubscription = audioPlayer.playerStateStream.listen((
      playerState,
    ) {
      if (playerState.processingState == ProcessingState.completed) {
        playNextSong();
      }
    });
  }

  void updateSongPlayer() {
    if (!isClosed) {
      emit(SongPlayerLoaded());
    }
  }

  Future<void> loadSong(
    String url, {
    SongsEntity? song,
    List<SongsEntity>? songs,
    int? index,
  }) async {
    try {
      if (!isClosed) emit(SongPlayerLoading());

      if (song != null) currentSong = song;
      if (songs != null) playlist = songs;
      if (index != null) currentIndex = index;

      await audioPlayer.setUrl(url);
      if (!isClosed) emit(SongPlayerLoaded());
    } catch (e) {
      if (!isClosed) emit(SongPlayerError(e.toString()));
    }
  }

  Future<void> playOrPauseSong() async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }
    if (!isClosed) emit(SongPlayerLoaded());
  }

  Future<void> seek(Duration position) async {
    await audioPlayer.seek(position);
  }

  Future<void> playNextSong() async {
    if (playlist.isEmpty) return;

    currentSong = playlist[currentIndex = (currentIndex + 1) % playlist.length];

    try {
      await audioPlayer.setUrl(currentSong!.songUrl);
      await audioPlayer.play();
      updateSongPlayer();
    } catch (e) {
      if (!isClosed) emit(SongPlayerError(e.toString()));
    }
  }

  Future<void> playPreviousSong() async {
    if (playlist.isEmpty) return;

    currentIndex = (currentIndex - 1 + playlist.length) % playlist.length;
    currentSong = playlist[currentIndex];

    try {
      await audioPlayer.setUrl(currentSong!.songUrl);
      await audioPlayer.play();
      updateSongPlayer();
    } catch (e) {
      if (!isClosed) emit(SongPlayerError(e.toString()));
    }
  }
}
