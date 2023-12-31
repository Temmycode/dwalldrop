import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dwalldrop/backend/constants/database_constants.dart';
import 'package:dwalldrop/backend/models/wallpaper_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dwalldrop/backend/enums/upload_result.dart';
import 'package:uuid/uuid.dart';

class UploadWallpaperClient {
  static String error = '';
  static final authInstance = FirebaseAuth.instance;
  String? username = authInstance.currentUser?.displayName!;
  String? userId = authInstance.currentUser?.uid;
  String? userAvatar = authInstance.currentUser?.photoURL;
  Future<UploadResult> uploadWallpaper(
    File wallpaperFile,
    String userId,
    String wallpaperName,
    String username,
    String imageDimensions,
    String userAvatar,
  ) async {
    try {
      // upload the file to firebase storage first of all
      final storageRef = FirebaseStorage.instance
          .ref()
          .child(DatabaseConstants.wallpaperCollection)
          .child(userId)
          .child(wallpaperName);
      await storageRef.putFile(wallpaperFile);
      final String wallpaperUrl = await storageRef.getDownloadURL();
      final FullMetadata metadata = await storageRef.getMetadata();
      final wallpaperSize = metadata.size;
      // upload the wallpaper model to firestore database
      final wallpaperId = const Uuid().v1();
      final wallpaperModel = Wallpaper(
        wallpaperName: wallpaperName,
        creatorName: username,
        imageUrl: wallpaperUrl,
        likedBy: const [],
        noDownloaded: 0,
        wallpaperId: wallpaperId,
        userAvatar: userAvatar,
        size: wallpaperSize!,
      );
      await FirebaseFirestore.instance
          .collection(DatabaseConstants.wallpaperCollection)
          .doc(wallpaperId)
          .set(wallpaperModel.toJson());

      // return success
      return UploadResult.success;
    } catch (e) {
      error = e.toString();
      return UploadResult.failure;
    }
  }
}
