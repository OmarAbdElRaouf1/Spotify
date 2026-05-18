class ProfileData {
  const ProfileData({
    this.name = 'Spotify User',
    this.email = '',
    this.avatarUrl = '',
    this.favoriteCount = 0,
  });

  final String name;
  final String email;
  final String avatarUrl;
  final int favoriteCount;
}
