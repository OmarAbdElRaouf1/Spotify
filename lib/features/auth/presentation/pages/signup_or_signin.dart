import 'package:flutter/material.dart';
import 'package:spotify/features/auth/presentation/widgets/logo_and_text_and_buttons.dart';
import 'package:spotify/features/auth/presentation/widgets/bg_images.dart';

class SignupOrSignin extends StatelessWidget {
  const SignupOrSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BgImages(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: const Center(child: LogoAndTextAndButtons()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
