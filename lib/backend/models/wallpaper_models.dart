import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class WallpaperModel {
  final String wallpaperName;
  final String creatorName;
  final String imageUrl;
  final bool likedBy;

  const WallpaperModel({
    required this.wallpaperName,
    required this.creatorName,
    required this.imageUrl,
    required this.likedBy,
  });

  Map<String, dynamic> toJson(Map<String, dynamic> json) => {
        'wallpaperName': wallpaperName,
        'creatorName': creatorName,
        'imageUrl': imageUrl,
        'likedBy': likedBy,
      };

  factory WallpaperModel.fromJson(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return WallpaperModel(
      wallpaperName: snap['wallpaperName'],
      creatorName: snap['creatorName'],
      imageUrl: snap['imageUrl'],
      likedBy: snap['likedBy'],
    );
  }

  @override
  bool operator ==(covariant WallpaperModel other) =>
      (wallpaperName == other.wallpaperName &&
          creatorName == other.creatorName &&
          imageUrl == other.imageUrl);

  @override
  int get hashCode => Object.hashAll(
        [
          wallpaperName,
          creatorName,
          imageUrl,
        ],
      );

  @override
  String toString() =>
      'WallpaperModel(wallpaperName: $wallpaperName, creatorName: $creatorName, imageUrl: $imageUrl, liked: $likedBy)';
}
