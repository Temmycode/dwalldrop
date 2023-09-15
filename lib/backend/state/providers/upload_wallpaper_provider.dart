import 'package:dwalldrop/backend/models/upload_state.dart';
import 'package:dwalldrop/backend/state/notifiers/upload_wallpaper_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uploadWallpaperProvider =
    StateNotifierProvider<UploadWallpaperNotifier, UploadState>(
  (ref) => UploadWallpaperNotifier(
    ref: ref,
  ),
);
