import 'package:dwalldrop/authentication/provider/auth_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../backend/state/providers/upload_wallpaper_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final auth = ref.watch(authStateProvider);
  final upload = ref.watch(uploadWallpaperProvider);
  if (auth.isLoading || upload.isLoading) {
    return true;
  } else {
    return false;
  }
});
