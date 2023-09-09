import 'package:flutter/foundation.dart' show immutable;

@immutable
class WallpaperModel {
  final String wallpaperName;
  final String creatorName;
  final String imageUrl;
  final bool liked;

  const WallpaperModel({
    required this.wallpaperName,
    required this.creatorName,
    required this.imageUrl,
    required this.liked,
  });

  @override
  bool operator ==(covariant WallpaperModel other) =>
      (wallpaperName == other.wallpaperName &&
          creatorName == other.creatorName &&
          imageUrl == other.imageUrl &&
          liked == other.liked);

  @override
  int get hashCode => Object.hashAll(
        [
          wallpaperName,
          creatorName,
          imageUrl,
          liked,
        ],
      );

  @override
  String toString() =>
      'WallpaperModel(wallpaperName: $wallpaperName, creatorName: $creatorName, imageUrl: $imageUrl, liked: $liked)';
}
