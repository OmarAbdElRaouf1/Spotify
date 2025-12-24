import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/core/services/get_it.dart';
import 'package:spotify/core/usecases/auth/sign_in.dart';
import 'package:spotify/core/widgets/app_bar.dart';
import 'package:spotify/core/widgets/basic_app_button.dart';
import 'package:spotify/features/auth/data/models/sign_in_user_model.dart';
import 'package:spotify/features/auth/presentation/widgets/divider.dart';
import 'package:spotify/features/auth/presentation/widgets/dont_have_account.dart';
import 'package:spotify/features/auth/presentation/widgets/password_field.dart';
import 'package:spotify/features/auth/presentation/widgets/text_field.dart';
import 'package:spotify/features/home/presentation/views/home.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(showLogo: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 50.h),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              registerText(),
              SizedBox(height: 57.h),

              TextFieldWidget(
                hint: 'Enter Username Or Email',
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your email';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.h),

              PasswordFieldWidget(
                hint: 'Password',
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your password';
                  }
                  return null;
                },
              ),

              SizedBox(height: 40.h),

              BasicAppButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await signInValidation(context);
                  }
                },
                title: 'Sign In',
              ),

              SizedBox(height: 50.h),
              DividerWidget(),
              SizedBox(height: 120.h),
              DontHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signInValidation(BuildContext context) async {
    var result = await getIt<SignInUseCase>().call(
      SignInUserModel(
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    result.fold(
      (l) {
        final snackbar = SnackBar(
          content: Text(l ?? 'Something went wrong'),
          behavior: SnackBarBehavior.floating,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
      (r) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
          (_) => false,
        );
      },
    );
  }

  Widget registerText() {
    return Text(
      'Sign In',
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}
