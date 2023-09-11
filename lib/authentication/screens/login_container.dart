import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/authentication/provider/auth_state_provider.dart';
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
    // THERE SHOULD BE A IS LOGGED IN VARIABLE
    final isLoggedIn = ref.watch(isLoggedInProvider);
    // THERE SHOULD ALSO BE A IS LOADING VARIABLE

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
            text: isLoggedIn
                ? "Signed in things naa"
                : "Save & Sync Your Favourites",
            size: 20.h(context),
            color: AppColors.yellowColor,
          ),
          // THIS IS YOUR EMAIL IF SIGNED IN
          SmallText(
            text: isLoggedIn
                ? "You are now signed in"
                : "Sign in below to get started",
            size: 13.h(context),
            weight: FontWeight.w500,
          ),
          SizedBox(height: 20.h(context)),

          // THIS IS THE LOGIN CONTAINER IF NOT SIGNED IN
          // AND THE SIGNOUT CONGTAINER IF SIGNED IN
          InkWell(
            borderRadius: BorderRadius.circular(40.h(context)),
            onTap: isLoggedIn
                ? () async {
                    // FUNCTION TO LOGIN THE USER OR LOGOUT THE USER IF LOGGED IN
                    await ref.read(authStateProvider.notifier).signout();
                  }
                : () async {
                    // FUNCTION TO LOG OUT THE USER
                    await ref
                        .read(authStateProvider.notifier)
                        .signInWithGoogle();
                  },
            child: Ink(
              height: 57.h(context),
              width: 317.w(context),
              decoration: BoxDecoration(
                color: isLoggedIn ? Colors.grey.withOpacity(0.4) : Colors.white,
                borderRadius: BorderRadius.circular(40.h(context)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.google,
                    height: 29.h(context),
                  ),
                  SizedBox(width: 20.w(context)),
                  TitleText(
                    text: isLoggedIn ? "Sign Out" : "Sign in with Google",
                    size: isLoggedIn ? 18.h(context) : 16.h(context),
                    color: isLoggedIn ? Colors.white : Colors.black,
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
