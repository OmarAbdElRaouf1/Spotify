import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';
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
    url: 'https://aqtmpaqlwvmjvfqexorx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFxdG1wYXFsd3ZtanZmcWV4b3J4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY5Njc2NjAsImV4cCI6MjA5MjU0MzY2MH0.LhaZLqvgcoujF2Jrlv-C5Xb7iLHKu7o8euwESYro0i0',
  );

  await setupLocator();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.spotify.channel.audio',
    androidNotificationChannelName: 'Music playback',
    androidNotificationOngoing: true,
  );

  runApp(const SpotifyApp());
}
