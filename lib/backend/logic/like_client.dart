import 'package:dwalldrop/backend/enums/like_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          return LikeResult.success;
        } else {
          // update the firestore document to mark the image as lied by the user
          likedBy.add(userId);
          await firestore
              .collection('wallpapers')
              .doc(wallpaperId)
              .update({'likedBy': likedBy});
        }
        return LikeResult.success;
      }
    } catch (e) {
      return LikeResult.failure;
    }
  }
}
