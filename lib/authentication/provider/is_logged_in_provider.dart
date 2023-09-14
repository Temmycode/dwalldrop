import 'package:dwalldrop/authentication/enums/auth_result.dart';
import 'package:dwalldrop/authentication/provider/auth_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  if (authState.isLoggedIn &&
      !authState.isLoading &&
      authState.result == AuthResult.success &&
      authState.userId != null) {
    return true;
  } else {
    return false;
  }
});
