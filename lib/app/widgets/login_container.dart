import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:dwalldrop/setup/text/small_text.dart';
import 'package:dwalldrop/setup/text/title_text.dart';
import 'package:flutter/material.dart';

import '../../setup/images/image.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
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
            text: "Save & Sync Your Favourites",
            size: 20.h(context),
            color: AppColors.yellowColor,
          ),
          // THIS IS YOUR EMAIL IF SIGNED IN
          SmallText(
            text: "Sign in below to get started",
            size: 13.h(context),
            weight: FontWeight.w500,
          ),
          SizedBox(height: 20.h(context)),
          // THIS IS THE LOGIN CONTAINER IF NOT SIGNED IN
          // ANT THE SIGNOUT CONGTAINER IF SIGNED IN
          Container(
            height: 57.h(context),
            width: 317.w(context),
            decoration: BoxDecoration(
              color: Colors.white,
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
                  text: "Sign in with Google",
                  size: 16.h(context),
                  color: Colors.black,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
