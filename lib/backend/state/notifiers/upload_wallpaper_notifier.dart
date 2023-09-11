import 'dart:io';
import 'package:dwalldrop/backend/logic/upload_wallpaper_client.dart';
import 'package:dwalldrop/backend/models/upload_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadWallpaperNotifier extends StateNotifier<UploadState> {
  final UploadWallpaperClient _uploadClient = UploadWallpaperClient();
  UploadWallpaperNotifier() : super(const UploadState.unknown());

  Future<void> uploadWallpaper({
    required File wallpaperFile,
    required String wallpaperName,
  }) async {
    state = state.copyIsLoading(isLoading: true);
    final result = await UploadWallpaperClient().uploadWallpaper(
      wallpaperFile,
      _uploadClient.userId,
      wallpaperName,
      _uploadClient.username,
    );
    state = UploadState(result: result, isLoading: false);
  }
}
