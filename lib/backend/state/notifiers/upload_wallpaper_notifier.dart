import 'dart:io';
import 'package:dwalldrop/authentication/provider/is_logged_in_provider.dart';
import 'package:dwalldrop/backend/enums/upload_result.dart';
import 'package:dwalldrop/backend/logic/upload_wallpaper_client.dart';
import 'package:dwalldrop/backend/models/upload_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadWallpaperNotifier extends StateNotifier<UploadState> {
  final Ref ref;
  final UploadWallpaperClient _uploadClient = UploadWallpaperClient();
  UploadWallpaperNotifier({required this.ref})
      : super(const UploadState.unknown());

  Future<void> uploadWallpaper({
    required File wallpaperFile,
    required String wallpaperName,
    required String imageDimensions,
  }) async {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    state = state.copyIsLoading(isLoading: true);
    if (isLoggedIn) {
      final result = await UploadWallpaperClient().uploadWallpaper(
        wallpaperFile,
        _uploadClient.userId!,
        wallpaperName,
        _uploadClient.username!,
        imageDimensions,
      );
      state = UploadState(result: result, isLoading: false);
    } else {
      state = const UploadState(result: UploadResult.failure, isLoading: false);
    }
  }
}
