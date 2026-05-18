import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/profile_data.dart';

class ProfileService {
  ProfileService({SupabaseClient? supabase})
    : _supabase = supabase ?? Supabase.instance.client;

  static const String _avatarBucket = 'avatars';

  final SupabaseClient _supabase;

  Future<ProfileData> loadProfile() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      return const ProfileData();
    }

    final userData = await _loadUserData(user.id);
    final favoriteCount = await _loadFavoriteCount(user.id);

    final name = (userData?['name'] ?? user.userMetadata?['name'] ?? '')
        .toString()
        .trim();
    final email = (userData?['email'] ?? user.email ?? '').toString().trim();
    final avatarUrl =
        (userData?['avatar_url'] ?? user.userMetadata?['avatar_url'] ?? '')
            .toString()
            .trim();

    return ProfileData(
      name: name.isEmpty ? 'Spotify User' : name,
      email: email,
      avatarUrl: avatarUrl,
      favoriteCount: favoriteCount,
    );
  }

  Future<String?> pickAndUploadAvatar() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }

    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );

    final file = pickedFile?.files.single;
    final bytes = file?.bytes;
    if (file == null || bytes == null) {
      return null;
    }

    final avatarUrl = await _uploadAvatar(
      userId: user.id,
      fileName: file.name,
      bytes: bytes,
    );

    await _saveAvatarUrl(user: user, avatarUrl: avatarUrl);
    return avatarUrl;
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<Map<String, dynamic>?> _loadUserData(String userId) async {
    try {
      return await _supabase
          .from('users')
          .select('name, email, avatar_url')
          .eq('id', userId)
          .maybeSingle();
    } catch (_) {
      return _loadUserDataWithoutAvatar(userId);
    }
  }

  Future<Map<String, dynamic>?> _loadUserDataWithoutAvatar(
    String userId,
  ) async {
    try {
      return await _supabase
          .from('users')
          .select('name, email')
          .eq('id', userId)
          .maybeSingle();
    } catch (_) {
      return null;
    }
  }

  Future<int> _loadFavoriteCount(String userId) async {
    try {
      final favorites = await _supabase
          .from('favorites')
          .select('id')
          .eq('user_id', userId);
      return favorites.length;
    } catch (_) {
      return 0;
    }
  }

  Future<String> _uploadAvatar({
    required String userId,
    required String fileName,
    required Uint8List bytes,
  }) async {
    final extension = _fileExtension(fileName);
    final filePath =
        '$userId/profile_${DateTime.now().millisecondsSinceEpoch}.$extension';

    await _supabase.storage
        .from(_avatarBucket)
        .uploadBinary(
          filePath,
          bytes,
          fileOptions: FileOptions(
            upsert: true,
            contentType: _contentType(extension),
          ),
        );

    return _supabase.storage.from(_avatarBucket).getPublicUrl(filePath).trim();
  }

  Future<void> _saveAvatarUrl({
    required User user,
    required String avatarUrl,
  }) async {
    await _supabase.auth.updateUser(
      UserAttributes(data: {...?user.userMetadata, 'avatar_url': avatarUrl}),
    );

    try {
      await _supabase
          .from('users')
          .update({'avatar_url': avatarUrl})
          .eq('id', user.id);
    } catch (_) {}
  }

  String _fileExtension(String fileName) {
    final parts = fileName.split('.');
    if (parts.length < 2) return 'jpg';
    return parts.last.toLowerCase();
  }

  String _contentType(String extension) {
    return switch (extension) {
      'png' => 'image/png',
      'webp' => 'image/webp',
      'gif' => 'image/gif',
      _ => 'image/jpeg',
    };
  }
}
