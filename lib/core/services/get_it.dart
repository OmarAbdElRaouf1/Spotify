import 'package:get_it/get_it.dart';
import 'package:spotify/core/services/auth/supabase_auth.dart';
import 'package:spotify/core/services/songs/songs_supabase_storage.dart';
import 'package:spotify/core/usecases/auth/sign_in.dart';
import 'package:spotify/core/usecases/auth/sign_up.dart';
import 'package:spotify/core/usecases/song/get_newest_songs.dart';
import 'package:spotify/core/usecases/song/get_play_list.dart';
import 'package:spotify/features/auth/data/repos/auth_repo_impl.dart';
import 'package:spotify/features/auth/domain/repos/auth_repo.dart';
import 'package:spotify/features/home/data/repos/songs_repo_impl.dart';
import 'package:spotify/features/home/domain/repos/songs_repo.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // 1. الخدمات (Services) - سجلها أولاً
  getIt.registerLazySingleton<FirebaseAuthService>(
    () => SupabaseAuthServiceImpl(),
  );
  getIt.registerLazySingleton<SongService>(() => SongServiceImpl());

  // 2. المستودعات (Repositories) - تعتمد على الخدمات
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
  getIt.registerLazySingleton<SongsRepo>(() => SongsRepoImpl());

  // 3. حالات الاستخدام (Use Cases) - تعتمد على المستودعات
  getIt.registerFactory(() => SignUpUseCase(getIt<AuthRepo>()));
  getIt.registerFactory(() => SignInUseCase(getIt<AuthRepo>()));
  getIt.registerFactory(() => GetNewestSongs(getIt<SongsRepo>()));
  getIt.registerFactory(() => GetPlayList(getIt<SongsRepo>()));
}
