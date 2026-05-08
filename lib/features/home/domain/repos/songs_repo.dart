import 'package:dartz/dartz.dart';

abstract class SongsRepo {
  Future<Either> getNewestSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFromFavorites(String songId);
  Future<bool> isFavoriteSong(String songId);
}
