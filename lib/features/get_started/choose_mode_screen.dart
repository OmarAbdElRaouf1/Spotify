import 'package:flutter/material.dart';
import 'package:spotify/features/get_started/widgets/choose_mode_screen_body.dart';

class ChooseModeScreen extends StatelessWidget {
  const ChooseModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Stack(children: [ChooseModeScreenBody()])),
    );
  }
}
