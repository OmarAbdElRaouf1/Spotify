import 'package:flutter/material.dart';
import 'package:spotify/core/widgets/app_bar.dart';
import 'package:spotify/features/auth/presentation/widgets/Logo_And_Text_And_buttons.dart';
import 'package:spotify/features/auth/presentation/widgets/bg_images.dart';

class SignupOrSignin extends StatelessWidget {
  const SignupOrSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBarWidget(showLogo: false, showBackButton: false),
          BgImages(),
          Align(alignment: Alignment.center, child: LogoAndTextAndButtons()),
        ],
      ),
    );
  }
}
