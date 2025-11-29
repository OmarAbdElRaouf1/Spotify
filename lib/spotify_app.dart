import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/routing/app_router.dart';
import 'package:spotify/features/get_started/manger/theme_cubit.dart';
import 'package:spotify/core/configs/theme/app_theme.dart';

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
                onGenerateRoute: AppRouter.onGenerateRoute,
                debugShowCheckedModeBanner: false,
                theme: state == ThemeMode.light
                    ? AppTheme.lightTheme
                    : AppTheme.darkTheme,
              );
            },
          ),
        );
      },
    );
  }
}
