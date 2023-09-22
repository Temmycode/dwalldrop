import 'dart:async' show StreamController;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dwalldrop/backend/constants/database_constants.dart';
import 'package:dwalldrop/backend/models/wallpaper_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getOneWallpaperProvider = StreamProvider.autoDispose
    .family<Wallpaper, String>((ref, String wallpaperId) {
  final controller = StreamController<Wallpaper>();

  final sub = FirebaseFirestore.instance
      .collection(DatabaseConstants.wallpaperCollection)
      .where("wallpaperId", isEqualTo: wallpaperId)
      .snapshots()
      .listen((snapshot) {
    final document = snapshot.docs.first;
    final result = Wallpaper.fromJson(document);
    controller.sink.add(result);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
