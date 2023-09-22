import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/app/providers/get_one_wallpaper_provider.dart';
import 'package:dwalldrop/app/widgets/action_buttons.dart';
import 'package:dwalldrop/app/widgets/app_snack_bar.dart';
import 'package:dwalldrop/authentication/provider/is_logged_in_provider.dart';
import 'package:dwalldrop/backend/state/providers/like_provider.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:dwalldrop/setup/images/image.dart';
import 'package:dwalldrop/setup/text/small_text.dart';
import 'package:dwalldrop/setup/text/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/wallpaper_info_container.dart';

class WallpaperPage extends ConsumerStatefulWidget {
  final String heroKey;
  final String wallpaperId;
  final String wallpaper;
  const WallpaperPage({
    super.key,
    required this.heroKey,
    required this.wallpaperId,
    required this.wallpaper,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends ConsumerState<WallpaperPage> {
  @override
  Widget build(BuildContext context) {
    // final wallpaper = ref.watch(getOneWallpaperProvider(widget.wallpaperId));
    final isLoggedIn = ref.watch(isLoggedInProvider);
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 28.w(context)),
        child: Column(
          children: [
            SizedBox(height: 31.h(context)),
            // IMAGE CONTAINER
            Hero(
              tag: widget.heroKey,
              child: Container(
                height: 335.h(context),
                width: 337.h(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.h(context)),
                  color: Colors.grey,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.h(context)),
                  child: CachedNetworkImage(
                    imageUrl: widget.wallpaper,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                    height: 335.h(context),
                    width: 337.h(context),
                  ),
                ),
              ),
            ),
            SizedBox(height: 33.h(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer(builder: (context, ref, child) {
                  final wallpaper =
                      ref.watch(getOneWallpaperProvider(widget.wallpaperId));
                  return wallpaper.when(
                    data: (wallpaperInfo) {
                      return Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(wallpaperInfo.userAvatar),
                            backgroundColor: AppColors.userAccountColor,
                            radius: 20.h(context),
                          ),
                          SizedBox(width: 8.w(context)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // WALLPAPER NAME
                              TitleText(
                                text: wallpaperInfo.wallpaperName,
                                size: 15.h(context),
                              ),

                              // WALLPAPER USER NAME
                              TitleText(
                                text: wallpaperInfo.creatorName,
                                // color: Colors.white,
                                size: 11.h(context),
                              )
                            ],
                          )
                        ],
                      );
                    },
                    error: (error, stk) => Container(),
                    loading: () => const CircularProgressIndicator(),
                  );
                }),
                Row(
                  children: [
                    ImageIcon(
                      const AssetImage(AppImages.verificationIcon),
                      color: AppColors.yellowColor,
                      size: 26.h(context),
                    ),
                    SizedBox(width: 17.w(context)),
                    GestureDetector(
                      onTap: () async {
                        HapticFeedback.lightImpact();
                        // IF THE USER IS LOGGED IN LIKE, IF NOT THEN DISPLAY A SNACK BAR OF THE SITUATION
                        if (isLoggedIn) {
                          await ref
                              .read(likeProvider.notifier)
                              .likeWallpaper(wallpaperId: widget.wallpaperId);
                          log(ref.read(likeProvider).result.toString());
                        } else {
                          appSnackBar(context, "Login to like wallpapers");
                          return;
                        }
                      },
                      child: Consumer(builder: (context, ref, child) {
                        final likeState = ref.watch(likeProvider);
                        // the wallpaper from the wallpaperId
                        final wallpaper = ref
                            .watch(getOneWallpaperProvider(widget.wallpaperId));
                        // final isLiked = likeState.result;
                        // HANDLING LIKES: IF THE LIKE FUNCTION IS LOADING THEN INSTANTIATE THE LIKE
                        return likeState.isLoading
                            ? Icon(
                                CupertinoIcons.heart_fill,
                                size: 26.h(context),
                                color: Colors.white,
                              )
                            :
                            // get the information from the wallpaper backend and use it to like the wallpaper
                            wallpaper.when(
                                data: (wallpaperInfo) {
                                  final userId =
                                      FirebaseAuth.instance.currentUser?.uid;
                                  // the like is determined if the users name is contained in the likeBy list
                                  final isLiked =
                                      wallpaperInfo.likedBy.contains(userId!);
                                  return Icon(
                                    isLiked == true
                                        ? CupertinoIcons.heart_fill
                                        : isLiked == false
                                            ? CupertinoIcons.heart
                                            : CupertinoIcons.heart,
                                    size: 26.h(context),
                                    color: Colors.white,
                                  );
                                },
                                error: (error, stk) => Container(),
                                loading: () =>
                                    const CircularProgressIndicator(),
                              );
                      }),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 14.h(context)),

            // SAVE AND SET BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SAVE BUTTON
                ActionButton(
                  title: "Save",
                  icon: ImageIcon(
                    const AssetImage(AppImages.downloadIcon),
                    size: 15.h(context),
                    color: Colors.white,
                  ),
                  color: AppColors.loginColor,
                ),
                // SET THE WALLPAPER
                ActionButton(
                  title: "Set",
                  icon: Icon(
                    Icons.image_outlined,
                    size: 18.h(context),
                  ),
                  color: AppColors.loginColor,
                ),
              ],
            ),
            SizedBox(height: 25.h(context)),

            // DESCRIPTION ON THE WALLPAPER
            SizedBox(
              width: double.maxFinite,
              height: 49.h(context),
              child: const SmallText(
                text:
                    "Bunch of random words sha. Do your best and leave the rest na the saying no the other way arround abeg.",
              ),
            ),
            SizedBox(height: 18.h(context)),
            WallpaperInfoContainer(
              noOfDownloads: 20,
              size: 10,
              dimensions: "1440 x 3100",
              color: AppColors.lightGrey,
              secondaryColor: AppColors.yellowColor.withAlpha(200),
            ),
          ],
        ),
      ),
    );
  }
}
