import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/services/get_it.dart';
import 'package:spotify/core/usecases/auth/sign_up.dart';
import 'package:spotify/core/widgets/app_bar.dart';
import 'package:spotify/core/widgets/basic_app_button.dart';
import 'package:spotify/features/auth/data/models/create_user_model.dart';
import 'package:spotify/features/auth/presentation/pages/sign_in.dart';
import 'package:spotify/features/auth/presentation/widgets/have_an_account.dart';
import 'package:spotify/features/auth/presentation/widgets/password_field.dart';
import 'package:spotify/features/auth/presentation/widgets/text_field.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(showLogo: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 50.h),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _registerText(context),
                SizedBox(height: 57.h),
                TextFieldWidget(
                  hint: 'Full Name',
                  controller: fullNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your Full Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                TextFieldWidget(
                  hint: 'Enter Email',
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your Email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                PasswordFieldWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your Password';
                    }
                    return null;
                  },
                  hint: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                SizedBox(height: 40.h),
                BasicAppButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await signIpValidation(context);
                    }
                  },
                  title: 'Create Account',
                ),
                SizedBox(height: 20.h),
                HaveAnAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIpValidation(BuildContext context) async {
    var result = await getIt<SignUpUseCase>().call(
      CreateUserModel(
        fullName: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    result.fold(
      (l) {
        var snackbar = SnackBar(
          content: Text(l ?? 'Something went wrong'),
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
      (r) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => SignIn()),
          (_) => false,
        );
      },
    );
  }

  Widget _registerText(BuildContext context) {
    return Text(
      'Register',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: context.isDarkMode ? Color(0XFFF2F2F2) : Color(0XFF383838),
      ),
      textAlign: TextAlign.center,
    );
  }
}
