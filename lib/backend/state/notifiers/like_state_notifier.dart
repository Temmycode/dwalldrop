import 'package:dwalldrop/backend/logic/like_client.dart';
import 'package:dwalldrop/backend/models/like_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeStateNotifier extends StateNotifier<LikeState> {
  LikeClient likeClient = LikeClient();
  LikeStateNotifier() : super(const LikeState.unkown());

  Future<void> likeWallpaper({required String wallpaperId}) async {
    state = state.copyIsLoading(isLoading: true);
    final result = await likeClient.likeWallpaper(wallpaperId);
    state = LikeState(result: result, isLoading: false);
  }
}
