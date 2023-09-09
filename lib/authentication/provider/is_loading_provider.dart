import 'package:dwalldrop/authentication/provider/auth_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final auth = ref.watch(authStateProvider);
  if (auth.isLoading) {
    return true;
  } else {
    return false;
  }
});
