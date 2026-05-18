import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/core/widgets/app_bar.dart';
import 'package:spotify/features/auth/presentation/pages/signup_or_signin.dart';
import 'package:spotify/features/profile/data/models/profile_data.dart';
import 'package:spotify/features/profile/data/services/profile_service.dart';
import 'package:spotify/features/profile/presentation/widgets/profile_action.dart';
import 'package:spotify/features/profile/presentation/widgets/profile_header.dart';
import 'package:spotify/features/profile/presentation/widgets/profile_option.dart';
import 'package:spotify/features/profile/presentation/widgets/profile_stat.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileService _profileService = ProfileService();
  late Future<ProfileData> _profileFuture;
  bool _isUploadingAvatar = false;

  @override
  void initState() {
    super.initState();
    _profileFuture = _profileService.loadProfile();
  }

  void _refreshProfile() {
    setState(() {
      _profileFuture = _profileService.loadProfile();
    });
  }

  Future<void> _pickAndUploadAvatar() async {
    if (_isUploadingAvatar) return;

    setState(() => _isUploadingAvatar = true);

    try {
      final avatarUrl = await _profileService.pickAndUploadAvatar();
      if (!mounted) return;

      if (avatarUrl != null) {
        _showMessage('Profile photo updated');
        _refreshProfile();
      }
    } catch (e) {
      if (!mounted) return;
      _showMessage('Could not upload photo: $e');
    } finally {
      if (mounted) {
        setState(() => _isUploadingAvatar = false);
      }
    }
  }

  Future<void> _signOut() async {
    await _profileService.signOut();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SignupOrSignin()),
      (_) => false,
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        showLogo: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: IconButton(
              tooltip: 'Refresh',
              onPressed: _refreshProfile,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ),
        ],
      ),
      body: FutureBuilder<ProfileData>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return _ProfileContent(
            profile: snapshot.data ?? const ProfileData(),
            isUploadingAvatar: _isUploadingAvatar,
            onChangePhoto: _pickAndUploadAvatar,
            onSignOut: _signOut,
          );
        },
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({
    required this.profile,
    required this.isUploadingAvatar,
    required this.onChangePhoto,
    required this.onSignOut,
  });

  final ProfileData profile;
  final bool isUploadingAvatar;
  final VoidCallback onChangePhoto;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileHeader(
            profile: profile,
            isUploading: isUploadingAvatar,
            onChangePhoto: onChangePhoto,
          ),
          SizedBox(height: 28.h),
          Row(
            children: [
              Expanded(
                child: ProfileStat(
                  icon: Icons.favorite_rounded,
                  label: 'Favorites',
                  value: profile.favoriteCount.toString(),
                ),
              ),
              SizedBox(width: 12.w),
              const Expanded(
                child: ProfileStat(
                  icon: Icons.music_note_rounded,
                  label: 'Library',
                  value: 'Ready',
                ),
              ),
            ],
          ),
          SizedBox(height: 28.h),
          ProfileOption(
            icon: Icons.email_outlined,
            title: 'Email',
            subtitle: profile.email.isEmpty ? 'No email found' : profile.email,
          ),
          SizedBox(height: 12.h),
          const ProfileOption(
            icon: Icons.person_outline_rounded,
            title: 'Account',
            subtitle: 'Signed in and synced',
          ),
          SizedBox(height: 12.h),
          ProfileAction(
            icon: Icons.photo_camera_outlined,
            title: 'Profile Photo',
            subtitle: isUploadingAvatar
                ? 'Uploading your photo'
                : 'Choose a new picture',
            onTap: onChangePhoto,
            enabled: !isUploadingAvatar,
          ),
          SizedBox(height: 28.h),
          SizedBox(
            height: 56.h,
            child: ElevatedButton.icon(
              onPressed: onSignOut,
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
