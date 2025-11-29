import 'package:flutter/material.dart';
import 'package:spotify/core/routing/routes.dart';
import 'package:spotify/features/auth/presentation/pages/signin_screen.dart';
import 'package:spotify/features/auth/presentation/pages/signup_screen.dart';
import 'package:spotify/features/get_started/presentation/choose_mode_screen.dart';
import 'package:spotify/features/get_started/presentation/get_started_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.GetStartedScreen:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen());
      case Routes.chooseModeScreen:
        return MaterialPageRoute(builder: (_) => const ChooseModeScreen());

      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      default:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen());
    }
  }
}
