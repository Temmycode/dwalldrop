import 'dart:developer' show log;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dwalldrop/backend/constants/database_constants.dart';
import 'package:dwalldrop/backend/models/wallpaper_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wallpaperProviders = FutureProvider.autoDispose<List<Wallpaper>>(
  (ref) async {
    List<Wallpaper> wallpaperList = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(DatabaseConstants.wallpaperCollection)
          .get();

      for (var doc in querySnapshot.docs) {
        var wallpaperModel = Wallpaper.fromJson(doc);
        wallpaperList.add(wallpaperModel);
      }
      return wallpaperList;
    } catch (e) {
      log(e.toString());
      return [];
    }
  },
);

// final wallpaperProviders =
//     StreamProvider.autoDispose<List<WallpaperModel>>((ref) {
//   final controller = StreamController<List<WallpaperModel>>();

//   controller.onListen = () {
//     controller.sink.add([]);
//   };

//   final sub = FirebaseFirestore.instance
//       .collection(FirestoreConstants.wallpaperCollection)
//       .limit(10)
//       .snapshots()
//       .listen((snapshot) {
//     final documents = snapshot.docs;
//     final result = documents
//         .map(
//           (snap) => WallpaperModel.fromJson(snap),
//         )
//         .toList();
//     controller.sink.add(result);
//   });

//   ref.onDispose(() {
//     sub.cancel();
//     controller.close();
//   });

//   return controller.stream;
// });
