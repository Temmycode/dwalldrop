import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Wallpaper {
  final String wallpaperId;
  final String wallpaperName;
  final String creatorName;
  final String imageUrl;
  final String userAvatar;
  final int noDownloaded;
  final List likedBy;
  final num? size;

  const Wallpaper({
    required this.wallpaperId,
    required this.wallpaperName,
    required this.creatorName,
    required this.imageUrl,
    required this.likedBy,
    required this.noDownloaded,
    required this.userAvatar,
    this.size,
  });

  Map<String, dynamic> toJson() => {
        'wallpaperId': wallpaperId,
        'wallpaperName': wallpaperName,
        'creatorName': creatorName,
        'imageUrl': imageUrl,
        'likedBy': likedBy,
        'noDownloaded': noDownloaded,
        'userAvatar': userAvatar,
        'size': size,
      };

  factory Wallpaper.fromJson(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return Wallpaper(
      wallpaperId: snap['wallpaperId'],
      wallpaperName: snap['wallpaperName'],
      creatorName: snap['creatorName'],
      imageUrl: snap['imageUrl'],
      likedBy: snap['likedBy'],
      noDownloaded: snap['noDownloaded'],
      userAvatar: snap['userAvatar'],
      size: snap['size'],
    );
  }

  @override
  bool operator ==(covariant Wallpaper other) =>
      (wallpaperId == other.wallpaperId &&
          wallpaperName == other.wallpaperName &&
          creatorName == other.creatorName &&
          imageUrl == other.imageUrl &&
          userAvatar == other.userAvatar &&
          size == other.size &&
          noDownloaded == other.noDownloaded &&
          likedBy == other.likedBy);

  @override
  int get hashCode => Object.hashAll(
        [
          wallpaperId,
          wallpaperName,
          creatorName,
          imageUrl,
          userAvatar,
          size,
          noDownloaded,
          likedBy,
        ],
      );

  @override
  String toString() =>
      '''Wallpaper(wallpaperId: $wallpaperId, wallpaperName: $wallpaperName,
       creatorName: $creatorName, imageUrl: $imageUrl, likedBy: $likedBy,
        noDownloaded: $noDownloaded, userAvatar: $userAvatar, size: $size)''';
}
