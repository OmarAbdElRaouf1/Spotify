class SongsEntity {
  final String title;
  final String artist;
  final num duration;
  final DateTime createdAt;
  final String imageUrl; // يمكن إضافة خصائص أخرى حسب الحاجة

  SongsEntity({
    required this.title,
    required this.artist,
    required this.duration,
    required this.createdAt,
    required this.imageUrl,
  });
}
