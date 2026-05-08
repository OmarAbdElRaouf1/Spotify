import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:spotify/features/home/domain/entities/songs_entity.dart';
import 'package:spotify/features/song_player/presentation/manger/cubit/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  List<SongsEntity> playlist = [];
  int currentIndex = 0;
  SongsEntity? currentSong;

  StreamSubscription<Duration?>? _durationSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    _durationSubscription = audioPlayer.durationStream.listen((duration) {
      songDuration = duration ?? Duration.zero;
      updateSongPlayer();
    });

    _positionSubscription = audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    _playerStateSubscription = audioPlayer.playerStateStream.listen((
      playerState,
    ) {
      if (playerState.processingState == ProcessingState.completed) {
        playNextSong();
        return;
      }

      if (playerState.playing) {
        if (!isClosed) emit(SongPlayerPlaying());
      } else {
        if (!isClosed) emit(SongPlayerPaused());
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
    bool autoPlay = false,
  }) async {
    try {
      if (!isClosed) emit(SongPlayerLoading());

      final previousSongId = currentSong?.id;
      if (song != null) currentSong = song;
      if (songs != null) playlist = songs;
      if (index != null) currentIndex = index;

      if (song != null &&
          previousSongId == song.id &&
          audioPlayer.processingState != ProcessingState.idle) {
        if (!isClosed) emit(SongPlayerLoaded());
        return;
      }

      final cleanUrl = url.trim();

      log('URL before play: "$cleanUrl"');

      if (cleanUrl.isEmpty) {
        throw Exception('Song URL is empty');
      }

      if (!cleanUrl.startsWith('http://') && !cleanUrl.startsWith('https://')) {
        throw Exception('Invalid song URL: $cleanUrl');
      }

      await audioPlayer.stop();
      songPosition = Duration.zero;
      songDuration = Duration.zero;

      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(cleanUrl),
          tag: MediaItem(
            id: currentSong?.id ?? cleanUrl,
            title: currentSong?.title ?? 'Unknown song',
            artist: currentSong?.artist,
            artUri: currentSong?.imageUrl.isNotEmpty == true
                ? Uri.tryParse(currentSong!.imageUrl)
                : null,
          ),
        ),
      );

      if (autoPlay) {
        await audioPlayer.play();
      }

      if (!isClosed) emit(SongPlayerLoaded());
    } catch (e) {
      log('Load song error: $e');
      if (!isClosed) emit(SongPlayerError(e.toString()));
    }
  }

  Future<void> playOrPauseSong() async {
    try {
      if (audioPlayer.playing) {
        await audioPlayer.pause();
      } else {
        if (currentSong == null) {
          throw Exception('No song loaded');
        }

        if (audioPlayer.processingState == ProcessingState.idle) {
          await loadSong(currentSong!.songUrl);
        }

        await audioPlayer.play();
      }
    } catch (e) {
      log('Play/pause error: $e');
      if (!isClosed) emit(SongPlayerError(e.toString()));
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await audioPlayer.seek(position);
    } catch (e) {
      log('Seek error: $e');
      if (!isClosed) emit(SongPlayerError(e.toString()));
    }
  }

  Future<void> playNextSong() async {
    if (playlist.isEmpty) return;

    currentIndex = (currentIndex + 1) % playlist.length;
    final nextSong = playlist[currentIndex];

    await loadSong(
      nextSong.songUrl,
      song: nextSong,
      songs: playlist,
      index: currentIndex,
      autoPlay: true,
    );
  }

  Future<void> playPreviousSong() async {
    if (playlist.isEmpty) return;

    currentIndex = (currentIndex - 1 + playlist.length) % playlist.length;
    final previousSong = playlist[currentIndex];

    await loadSong(
      previousSong.songUrl,
      song: previousSong,
      songs: playlist,
      index: currentIndex,
      autoPlay: true,
    );
  }

  @override
  Future<void> close() async {
    await _durationSubscription?.cancel();
    await _positionSubscription?.cancel();
    await _playerStateSubscription?.cancel();
    await audioPlayer.dispose();
    return super.close();
  }
}
