import 'package:flutter/material.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/features/auth/presentation/pages/sign_up.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Not A Member? ', style: TextStyle(fontSize: 16)),

        TextButton(
          style: TextButton.styleFrom(
            shadowColor: AppColors.primaryColor,
            overlayColor: Colors.transparent,
            padding: EdgeInsets.zero,
            minimumSize: Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );
          },
          child: Text(
            'Register Now',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
