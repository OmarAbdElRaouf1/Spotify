import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/features/auth/presentation/pages/signup_or_signin.dart';
import 'package:spotify/features/get_started/presentation/get_started_screen.dart';
import 'package:spotify/features/home/presentation/views/home.dart';

class AppStart extends StatefulWidget {
  const AppStart({super.key});

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart>
    with SingleTickerProviderStateMixin {
  static const Duration _minimumSplashDuration = Duration(milliseconds: 1800);

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _openStartPage();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    _scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1,
    ).animate(curvedAnimation);
  }

  Future<void> _openStartPage() async {
    final page = await _resolveStartPage();
    await Future<void>.delayed(_minimumSplashDuration);

    if (!mounted) return;
    _go(page);
  }

  Future<Widget> _resolveStartPage() async {
    final prefs = await SharedPreferences.getInstance();
    final isOnBoardingDone = prefs.getBool('isOnBoardingDone') ?? false;
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isOnBoardingDone) {
      return const GetStartedScreen();
    }
    if (!isLoggedIn) {
      return const SignupOrSignin();
    }
    return const HomePage();
  }

  void _go(Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: const Duration(milliseconds: 420),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    final backgroundColor = isDarkMode
        ? AppColors.darkMode
        : AppColors.lightMode;
    final subtitleColor = isDarkMode ? Colors.white70 : AppColors.grey;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 34.h),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 150.r,
                      width: 150.r,
                      decoration: BoxDecoration(
                        color: isDarkMode ? AppColors.darkGrey : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.2,
                            ),
                            blurRadius: 34.r,
                            offset: Offset(0, 18.h),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/vectors/spotify_logo.svg',
                        height: 84.r,
                        width: 84.r,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      'Spotify',
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w900,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Feel the music',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: subtitleColor,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    SizedBox(
                      width: 160.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: LinearProgressIndicator(
                          minHeight: 5.h,
                          backgroundColor: isDarkMode
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.black.withValues(alpha: 0.08),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
