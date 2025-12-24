import 'package:flutter/material.dart';
import 'package:spotify/core/routing/routes.dart';
import 'package:spotify/features/auth/presentation/pages/sign_in.dart';
import 'package:spotify/features/auth/presentation/pages/sign_up.dart';
import 'package:spotify/features/get_started/presentation/choose_mode_screen.dart';
import 'package:spotify/features/get_started/presentation/get_started_screen.dart';
import 'package:spotify/features/home/presentation/views/home.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.GetStartedScreen:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen());
      case Routes.chooseModeScreen:
        return MaterialPageRoute(builder: (_) => const ChooseModeScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUp());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => SignIn());
      default:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen());
    }
  }
}
