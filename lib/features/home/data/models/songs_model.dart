import 'package:spotify/features/home/domain/entities/songs_entity.dart';

class SongsModel extends SongsEntity {
  SongsModel({
    required super.title,
    required super.artist,
    required super.duration,
    required super.createdAt,
    required super.imageUrl,
    required super.songUrl,
  });

  factory SongsModel.fromJson(Map<String, dynamic> json) {
    return SongsModel(
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      duration: json['duration'] ?? 0,
      // جرب عدة احتمالات للتاريخ
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : (json['releaseDate'] != null
                ? DateTime.parse(json['releaseDate'])
                : DateTime.now()),
      // جرب عدة احتمالات لعنوان الصورة
      imageUrl:
          json['imageUrl'] ??
          json['image_url'] ??
          json['coverUrl'] ??
          json['cover_url'] ??
          'https://via.placeholder.com/160',
      songUrl: json['songUrl'] ?? json['song_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'duration': duration,
      'createdAt': createdAt.toIso8601String(),
      'imageUrl': imageUrl,
      'songUrl': songUrl,
    };
  }
}
