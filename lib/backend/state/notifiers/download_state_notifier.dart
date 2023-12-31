import 'package:dwalldrop/backend/logic/dowload_wallpaper_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/download_state.dart';

class DownloadWallpaperStateNotifier extends StateNotifier<DownloadState> {
  final downloadClient = const DownloadWallpaperClient();
  DownloadWallpaperStateNotifier() : super(const DownloadState.unkown());

  Future<void> downloadWallpaper({
    required String wallpaperName,
    required String wallpaperUrl,
  }) async {
    state = state.copyIsLoading(isLoading: true);
    final download = await downloadClient.downloadWallpaper(
      wallpaperUrl: wallpaperUrl,
      wallpaperName: wallpaperName,
    );
    state = DownloadState(
      result: download,
      isLoading: false,
    );
  }

  Future<void> setWallpaper({required int location}) async {
    state = state.copyIsLoading(isLoading: true);
    final downloadResult = await downloadClient.setWallpaper(
      location: location,
    );
    state = DownloadState(
      result: downloadResult,
      isLoading: false,
    );
  }
}
