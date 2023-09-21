import 'package:dwalldrop/backend/models/like_state.dart';
import 'package:dwalldrop/backend/state/notifiers/like_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final likeProvider = StateNotifierProvider<LikeStateNotifier, LikeState>(
  (_) => LikeStateNotifier(),
);
