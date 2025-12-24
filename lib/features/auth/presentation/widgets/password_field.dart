import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PasswordFieldWidget extends StatefulWidget {
  const PasswordFieldWidget({
    super.key,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.validator,
  });
  final String hint;
  final TextEditingController controller;
  final bool? obscureText;
  final String? Function(String?)? validator;

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      obscureText: obscureText,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hint,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: obscureText
              ? SvgPicture.asset('assets/vectors/hide.svg')
              : const Icon(Icons.remove_red_eye, color: Colors.grey),
        ),
      ).applyDefaults(theme.inputDecorationTheme),
    );
  }
}
