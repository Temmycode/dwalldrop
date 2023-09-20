import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Wallpaper {
  final String wallpaperId;
  final String wallpaperName;
  final String creatorName;
  final String imageUrl;
  final String userAvatar;
  final int wallpaperSize;
  final int noDownloaded;
  final List likedBy;

  const Wallpaper({
    required this.wallpaperId,
    required this.wallpaperName,
    required this.creatorName,
    required this.imageUrl,
    required this.likedBy,
    required this.wallpaperSize,
    required this.noDownloaded,
    required this.userAvatar,
  });

  Map<String, dynamic> toJson() => {
        'wallpaperId': wallpaperId,
        'wallpaperName': wallpaperName,
        'creatorName': creatorName,
        'imageUrl': imageUrl,
        'likedBy': likedBy,
        'wallpaperSize': wallpaperSize,
        'noDownloaded': noDownloaded,
        'userAvatar': userAvatar,
      };

  factory Wallpaper.fromJson(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return Wallpaper(
      wallpaperId: snap['wallpaperId'],
      wallpaperName: snap['wallpaperName'],
      creatorName: snap['creatorName'],
      imageUrl: snap['imageUrl'],
      likedBy: snap['likedBy'],
      wallpaperSize: snap['wallpaperSize'],
      noDownloaded: snap['noDownloaded'],
      userAvatar: snap['userAvatar'],
    );
  }

  @override
  bool operator ==(covariant Wallpaper other) =>
      (wallpaperId == other.wallpaperId &&
          wallpaperName == other.wallpaperName &&
          creatorName == other.creatorName &&
          imageUrl == other.imageUrl &&
          wallpaperSize == other.wallpaperSize &&
          userAvatar == other.userAvatar);

  @override
  int get hashCode => Object.hashAll(
        [
          wallpaperId,
          wallpaperName,
          creatorName,
          imageUrl,
          wallpaperSize,
          userAvatar,
        ],
      );

  @override
  String toString() =>
      '''Wallpaper(wallpaperId: $wallpaperId, wallpaperName: $wallpaperName,
       creatorName: $creatorName, imageUrl: $imageUrl, likedBy: $likedBy,
        wallpaperSize: $wallpaperSize, noDownloaded: $noDownloaded, userAvatar: $userAvatar)''';
}
