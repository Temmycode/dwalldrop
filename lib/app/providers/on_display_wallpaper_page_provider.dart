import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../mock/ondisplay_wallpaper_mock.dart';

final onDisplayWallpaperPageProvider = Provider.autoDispose((ref) {
  // use the data from the back end for the calculation
  // i am using the mock data for now
  final initalPage = ondisplayWallpaperMock.length ~/ 2;
  final controller = PageController(
    viewportFraction: 0.89,
    initialPage: initalPage,
  );
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
