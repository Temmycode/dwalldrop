import 'package:dwalldrop/authentication/logic/auth_client.dart';
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
        userId: auth.userId!,
        isLoading: false,
        isLoggedIn: loggedIn,
        result: AuthResult.success,
      );
    });

    // I COMMENTED THIS OUT TO CHECK THE POSSIBILITY OF THAT CODE ABOVE WORKING
    // if (auth.isLoggedIn) {
    //   state = AuthState(
    //     userId: auth.userId!,
    //     isLoading: false,
    //     isLoggedIn: true,
    //     result: AuthResult.success,
    //   );
    // }
  }

  // LOG IN WITH GOOGLE FUNCTION
  Future<void> signInWithGoogle() async {
    state = state.copyIsLoading(isLoading: true);
    final result = await auth.signInWithGoogle();
    if (auth.userId != null && auth.isLoggedIn == true) {
      // CACHE THE USERNAME
      SharedPrefrenceService.cacheUsername(username: auth.username!);
      // CACHE THE EMAIL
      SharedPrefrenceService.cacheUserEmail(email: auth.email!);
      // LOG IN USER WITH SHARED PREFERENCE
      SharedPrefrenceService.setIsLoggedIn(isLoggedIn: true);
      state = AuthState(
        userId: auth.userId!,
        result: result,
        isLoading: false,
        isLoggedIn: true,
      );
    } else {
      // SET THE LOGIN TO FALSE
      SharedPrefrenceService.setIsLoggedIn(isLoggedIn: false);
      state = AuthState(
        userId: null,
        result: result,
        isLoading: false,
        isLoggedIn: false,
      );
    }
  }
}
