import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dwalldrop/backend/constants/firestore_constants.dart';
import 'package:dwalldrop/backend/models/wallpaper_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wallpaperProviders = FutureProvider.autoDispose<List<WallpaperModel>>(
  (ref) async {
    List<WallpaperModel> wallpaperList = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(FirestoreConstants.wallpaperCollection)
          .get();

      for (var doc in querySnapshot.docs) {
        var wallpaperModel = WallpaperModel.fromJson(doc);
        wallpaperList.add(wallpaperModel);
      }
      return wallpaperList;
    } catch (e) {
      log(e.toString());
      return [];
    }
  },
);
