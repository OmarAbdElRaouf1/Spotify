import 'package:dartz/dartz.dart';

abstract class SongsRepo {
  Future<Either> getNewestSongs();
  Future<Either> getPlayList();
}
