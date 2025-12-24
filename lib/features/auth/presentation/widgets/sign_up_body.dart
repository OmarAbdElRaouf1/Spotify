import 'package:flutter/material.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Register',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: context.isDarkMode ? Color(0XFFF2F2F2) : Color(0XFF383838),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
