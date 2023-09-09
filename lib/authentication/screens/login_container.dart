import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/authentication/models/auth_state.dart';
import 'package:dwalldrop/authentication/provider/auth_state_provider.dart';
import 'package:dwalldrop/authentication/provider/is_loading_provider.dart';
import 'package:dwalldrop/authentication/provider/is_logged_in_provider.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:dwalldrop/setup/text/small_text.dart';
import 'package:dwalldrop/setup/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../setup/images/image.dart';

/// TODO : FIX THIS SCREEN, ALL THE PROVIDERS SHOULD BE SEPERATED INTO THEIR OWN RESPECTIVE CONSUMERS
class LoginContainer extends ConsumerWidget {
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // THE AUTH PROVIDER TO KEEP TRACK OF THE USER'S AUTHENTICATION STATE
    final AuthState auth = ref.watch(authStateProvider);
    // THERE SHOULD BE A IS LOGGED IN VARIABLE
    final isLoggedIn = ref.watch(isLoggedInProvider);
    // THERE SHOULD ALSO BE A IS LOADING VARIABLE
    final isLoading = ref.watch(isLoadingProvider);
    print(isLoggedIn);

    return Ink(
      height: 262.h(context),
      width: 362.w(context),
      padding: EdgeInsets.only(
        top: 19.h(context),
        bottom: 23.h(context),
      ),
      decoration: BoxDecoration(
        color: AppColors.loginColor,
        borderRadius: BorderRadius.circular(20.h(context)),
      ),
      child: Column(
        children: [
          // THE USER'S IMAGE ICON, IT IS JUST AN EMPTY USER ICON IF
          // THE USER IS NOT LOGGED IN
          Ink(
            padding: EdgeInsets.all(3.h(context)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.h(context)),
              border: Border.all(
                color: AppColors.userAccountColor,
                width: 7,
              ),
            ),
            child: ImageIcon(
              const AssetImage(AppImages.user),
              color: AppColors.userAccountColor,
              size: 60.h(context),
            ),
          ),
          SizedBox(height: 15.h(context)),
          // THIS IS YOUR NAME IF SIGNED IN
          TitleText(
            text: isLoggedIn.when(
              data: (login) => login
                  ? "Signed in things naa"
                  : "Save & Sync Your Favourites",
              error: (error, stk) => '',
              loading: () => '',
            ),
            size: 20.h(context),
            color: AppColors.yellowColor,
          ),
          // THIS IS YOUR EMAIL IF SIGNED IN
          SmallText(
            text: isLoggedIn.when(
              data: (login) => login
                  ? "You are now signed in"
                  : "Sign in below to get started",
              error: (error, stk) => '',
              loading: () => '',
            ),
            size: 13.h(context),
            weight: FontWeight.w500,
          ),
          SizedBox(height: 20.h(context)),

          // THIS IS THE LOGIN CONTAINER IF NOT SIGNED IN
          // AND THE SIGNOUT CONGTAINER IF SIGNED IN
          InkWell(
            borderRadius: BorderRadius.circular(40.h(context)),
            onTap: () async {
              // TODO
              // FUNCTION TO LOGIN THE USER OR LOGOUT THE USER IF LOGGED IN
              await ref.read(authStateProvider.notifier).signInWithGoogle();
              print(auth.userId);
            },
            child: Ink(
              height: 57.h(context),
              width: 317.w(context),
              decoration: BoxDecoration(
                color: isLoggedIn.when(
                  data: (login) =>
                      login ? Colors.grey.withOpacity(0.4) : Colors.white,
                  error: (error, stk) => Colors.black,
                  loading: () => Colors.black,
                ),
                borderRadius: BorderRadius.circular(40.h(context)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    AppImages.google,
                    height: 29.h(context),
                  ),
                  TitleText(
                    text: isLoggedIn.when(
                      data: (login) =>
                          login ? "Sign Out" : "Sign in with Google",
                      error: (error, stk) => '',
                      loading: () => '',
                    ),
                    size: isLoggedIn.when(
                      data: (login) => login ? 18.h(context) : 16.h(context),
                      error: (error, stk) => 0,
                      loading: () => 0,
                    ),
                    color: isLoggedIn.when(
                      data: (login) => login ? Colors.white : Colors.black,
                      error: (error, stk) => Colors.black,
                      loading: () => Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
