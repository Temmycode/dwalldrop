import 'dart:async' show StreamController;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dwalldrop/backend/constants/database_constants.dart';
import 'package:dwalldrop/backend/models/wallpaper_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favourtieWallpaperProvider = StreamProvider.autoDispose<List<Wallpaper>>(
  (ref) {
    final controller = StreamController<List<Wallpaper>>();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    controller.onListen = () {
      controller.sink.add([]);
    };

    final sub = FirebaseFirestore.instance
        .collection(DatabaseConstants.favouriteCollection)
        .doc(userId)
        .collection(DatabaseConstants.wallpaperCollection)
        .snapshots()
        .listen(
      (snap) {
        final documents = snap.docs;
        final res = documents
            .map(
              (snapshot) => Wallpaper.fromJson(snapshot),
            )
            .toList();
        controller.sink.add(res);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
