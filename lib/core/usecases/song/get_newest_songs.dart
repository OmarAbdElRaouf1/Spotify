import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/home/domain/repos/songs_repo.dart';

class GetNewestSongs implements UseCase<Either, dynamic> {
  final SongsRepo songsRepo;

  GetNewestSongs(this.songsRepo);

  @override
  Future<Either<dynamic, dynamic>> call(params) async {
    return await songsRepo.getNewestSongs();
  }
}
