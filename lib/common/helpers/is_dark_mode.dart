import 'package:flutter/material.dart';

bool isSignIn = false;

extension IsDarkMode on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
