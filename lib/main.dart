import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

// ignore: depend_on_referenced_packages
import 'package:spotify/core/configs/theme/app_theme.dart';
import 'package:spotify/features/get_started/get_started_screen.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:spotify/features/get_started/manger/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  runApp(const SpotifyApp());
}

class SpotifyApp extends StatelessWidget {
  const SpotifyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => ThemeCubit())],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: state == ThemeMode.light
                    ? AppTheme.lightTheme
                    : AppTheme.darkTheme,
                home: const GetStartedScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
