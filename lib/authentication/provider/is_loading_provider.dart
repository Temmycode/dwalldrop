import 'package:dwalldrop/authentication/provider/auth_state_provider.dart';
import 'package:dwalldrop/backend/state/providers/upload_wallpaper_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final auth = ref.watch(authStateProvider);
  // final upload = ref.watch(uploadWallpaperProvider);
  if (auth.isLoading) {
    return true;
  } else {
    return false;
  }
});
