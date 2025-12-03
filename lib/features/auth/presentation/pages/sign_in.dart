import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/core/widgets/app_bar.dart';
import 'package:spotify/core/widgets/basic_app_button.dart';
import 'package:spotify/features/auth/presentation/pages/sign_up.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(showLogo: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 50.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              registerText(),
              SizedBox(height: 57.h),
              _emailField(context),
              SizedBox(height: 20.h),
              _passwordField(context),
              SizedBox(height: 40.h),
              BasicAppButton(onPressed: () {}, title: 'Sign In'),
              SizedBox(height: 50.h),
              signInText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerText() {
    return Text(
      'Sign In',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: context.isDarkMode
            ? TextStyle(color: Color(0xffA7A7A7), fontWeight: FontWeight.w500)
            : TextStyle(color: Color(0xff383838), fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: context.isDarkMode
            ? TextStyle(color: Color(0xffA7A7A7), fontWeight: FontWeight.w500)
            : TextStyle(color: Color(0xff383838), fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget signInText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don\'t have an account? ', style: TextStyle(fontSize: 16)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );
          },
          child: Text(
            'Sign Up',
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
