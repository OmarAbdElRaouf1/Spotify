import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:spotify/core/services/get_it.dart';
import 'package:spotify/spotify_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ================= Hydrated Bloc =================
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  await Supabase.initialize(
    url: 'https://uxlbztqtawcmoyjfbkub.supabase.co',
    anonKey: 'sb_publishable_JnjDqo1IQ_7Tmr_vvuidpA_9X2DXQnt',
  );

  await setupLocator();

  runApp(const SpotifyApp());
}
