import 'dart:async' show StreamController;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dwalldrop/backend/constants/database_constants.dart';
import 'package:dwalldrop/backend/models/wallpaper_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wallpaperProviders = StreamProvider.autoDispose<List<Wallpaper>>((ref) {
  final controller = StreamController<List<Wallpaper>>();

  controller.onListen = () {
    controller.sink.add([]);
  };

  final sub = FirebaseFirestore.instance
      .collection(DatabaseConstants.wallpaperCollection)
      .limit(10)
      .snapshots()
      .listen((snapshot) {
    final documents = snapshot.docs;
    final result = documents
        .map(
          (snap) => Wallpaper.fromJson(snap),
        )
        .toList();
    controller.sink.add(result);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
