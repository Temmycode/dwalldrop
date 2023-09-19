import 'package:cached_network_image/cached_network_image.dart';
import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/authentication/provider/is_logged_in_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../setup/colors/app_colors.dart';
import '../../setup/images/image.dart';
import '../screens/account_page.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isLoggedIn = ref.watch(isLoggedInProvider);
        return SliverAppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 26.h(context)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // USER ACCOUNT ICON
                    GestureDetector(
                      // NAVIGATING TO THE USER ACCOUNT PAGE
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountPage(),
                        ),
                      ),
                      child: isLoggedIn
                          ?
                          // PROFILE PHOTO OF THE USER
                          CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                FirebaseAuth.instance.currentUser!.photoURL!,
                              ),
                            )
                          :
                          // USER ACCOUNT IMAGE IF NOT LOGGED IN
                          Container(
                              padding: EdgeInsets.all(3.h(context)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  32.h(context),
                                ),
                                border: Border.all(
                                  color: AppColors.userAccountColor,
                                  width: 2.5,
                                ),
                              ),
                              child: ImageIcon(
                                const AssetImage(AppImages.user),
                                color: AppColors.userAccountColor,
                              ),
                            ),
                    ),

                    // APPLICATION TITLTE
                    Image.asset(
                      AppImages.titleIcon,
                      height: 20.h(context),
                      width: 111.w(context),
                    ),
                    // SEARCH BUTTON
                    GestureDetector(
                      onTap: () {},
                      child: ImageIcon(
                        const AssetImage(AppImages.search),
                        color: Colors.white,
                        size: 20.h(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floating: true,
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: AppColors.backgroundColor,
          toolbarHeight: 95.h(context),
          scrolledUnderElevation: 0,
          stretch: true,
          centerTitle: true,
        );
      },
    );
  }
}
