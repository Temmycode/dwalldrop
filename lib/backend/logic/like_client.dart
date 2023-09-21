import 'dart:developer';
import 'package:dwalldrop/backend/constants/database_constants.dart';
import 'package:dwalldrop/backend/enums/like_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dwalldrop/backend/models/wallpaper_models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LikeClient {
  Future<LikeResult> likeWallpaper(String wallpaperId) async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      if (userId == null) {
        return LikeResult.failure;
      } else {
        // check if the wallpaper is already liked by the user
        final DocumentSnapshot wallpaperDoc =
            await firestore.collection("wallpapers").doc(wallpaperId).get();
        final List<String> likedBy = List<String>.from(wallpaperDoc['likedBy']);

        if (likedBy.contains(userId)) {
          // the user has already the liked the image
          // then unlike it
          likedBy.remove(userId);
          await firestore
              .collection(DatabaseConstants.wallpaperCollection)
              .doc(wallpaperId)
              .update({'likeBy': likedBy});
          return LikeResult.unliked;
        } else {
          // update the firestore document to mark the image as lied by the user
          likedBy.add(userId);
          await firestore
              .collection(DatabaseConstants.wallpaperCollection)
              .doc(wallpaperId)
              .update({'likedBy': likedBy}).whenComplete(() {
            // CREATE A WALLPAPER INSTANCE THAT YOU CAN ADD TO THE FAVOURTIES COLLECTION
            final updatedWallpaper = Wallpaper(
                wallpaperId: wallpaperId,
                wallpaperName: wallpaperDoc['wallpaperName'],
                creatorName: wallpaperDoc['creatorName'],
                imageUrl: wallpaperDoc['imageUrl'],
                likedBy: likedBy,
                wallpaperSize: wallpaperDoc['wallpaperSize'],
                noDownloaded: wallpaperDoc['noDownloaded'],
                userAvatar: wallpaperDoc['userAvatar']);

            // UPLOAD THE UPDATED WALLPAPER TO THE FAVOURTIES COLLECTION
            FirebaseFirestore.instance
                .collection(DatabaseConstants.favouriteCollection)
                .doc(userId)
                .collection(DatabaseConstants.wallpaperCollection)
                .doc()
                .set(updatedWallpaper.toJson());
          });
          return LikeResult.liked;
        }
      }
    } catch (e) {
      log(e.toString());
      return LikeResult.failure;
    }
  }
}
