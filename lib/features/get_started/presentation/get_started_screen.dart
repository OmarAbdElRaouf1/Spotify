import 'package:flutter/material.dart';
import 'package:spotify/features/get_started/presentation/widgets/get_started_screen_body.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Stack(children: [GetStartedScreenBody()])),
    );
  }
}
