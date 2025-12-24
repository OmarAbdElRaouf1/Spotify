import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/features/auth/presentation/pages/signup_or_signin.dart';
import 'package:spotify/features/get_started/presentation/get_started_screen.dart';
import 'package:spotify/features/home/presentation/views/home.dart';

class AppStart extends StatefulWidget {
  const AppStart({super.key});

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  @override
  void initState() {
    super.initState();
    decideStart();
  }

  void decideStart() async {
    final prefs = await SharedPreferences.getInstance();

    final isOnBoardingDone = prefs.getBool('isOnBoardingDone') ?? false;

    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isOnBoardingDone) {
      go(const GetStartedScreen());
    } else if (!isLoggedIn) {
      go(const SignupOrSignin());
    } else {
      go(const HomePage());
    }
  }

  void go(Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
