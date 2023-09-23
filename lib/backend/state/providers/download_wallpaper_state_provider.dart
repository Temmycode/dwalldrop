import 'package:dwalldrop/backend/state/notifiers/download_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/download_state.dart';

final downloadWallpaperStateProvider =
    StateNotifierProvider<DownloadWallpaperStateNotifier, DownloadState>(
  (_) => DownloadWallpaperStateNotifier(),
);
