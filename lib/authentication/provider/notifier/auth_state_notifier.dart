import 'package:dwalldrop/authentication/logic/auth_client.dart';
import 'package:dwalldrop/authentication/logic/user_upload_client.dart';
import 'package:dwalldrop/authentication/models/auth_state.dart';
import 'package:dwalldrop/backend/services/shared_prefernce_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../enums/auth_result.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthClient auth = AuthClient();
  final sharedPreferenceLogInState = SharedPrefrenceService.getIsLoggedIn();
  AuthStateNotifier() : super(const AuthState.unknown()) {
    // USING SHARED PREFERENCE INSTANCE OF THE LOGIN TO LOGIN THE USER AT FIRST INSTANCE
    sharedPreferenceLogInState.then((loggedIn) {
      state = AuthState(
        userId: auth.userId,
        isLoading: false,
        isLoggedIn: loggedIn,
        result: AuthResult.success,
      );
    });
  }

  // LOG IN WITH GOOGLE FUNCTION
  Future<void> signInWithGoogle() async {
    state = state.copyIsLoading(isLoading: true);
    final result = await auth.signInWithGoogle();
    if (auth.userId != null && auth.isLoggedIn == true) {
      // CACHE THE USERNAME
      await SharedPrefrenceService.cacheUsername(username: auth.username!);
      // CACHE THE EMAIL
      await SharedPrefrenceService.cacheUserEmail(email: auth.email!);
      // LOG IN USER WITH SHARED PREFERENCE
      await SharedPrefrenceService.setIsLoggedIn(isLoggedIn: true);
      state = AuthState(
        userId: auth.userId!,
        result: result,
        isLoading: false,
        isLoggedIn: true,
      );
      // UPLOAD THE USE TO THE FIRESTORE DATABASE
      await UseruploadClient.uploadUserToDatabase(
        auth.userId!,
        auth.email!,
        auth.username!,
      );
    } else {
      // SET THE LOGIN TO FALSE
      await SharedPrefrenceService.setIsLoggedIn(isLoggedIn: false);
      state = AuthState(
        userId: auth.userId,
        result: result,
        isLoading: false,
        isLoggedIn: false,
      );
    }
  }

  Future<void> signout() async {
    state = state.copyIsLoading(isLoading: true);
    final result = await auth.signout();

    state = AuthState(
      userId: null,
      result: result,
      isLoading: false,
      isLoggedIn: false,
    );
    if (result == AuthResult.success) {
      // CLEAR THE SHARED PREFERENCE

      await SharedPrefrenceService.clearCacheInstance();
    }
  }
}
