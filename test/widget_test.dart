import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/core/routing/app_gate.dart';

void main() {
  testWidgets('shows splash before opening the start page', (tester) async {
    SharedPreferences.setMockInitialValues({
      'isOnBoardingDone': true,
      'isLoggedIn': false,
    });

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return const MaterialApp(home: AppStart());
        },
      ),
    );

    expect(find.text('Spotify'), findsOneWidget);
    expect(find.text('Feel the music'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pumpAndSettle();

    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
