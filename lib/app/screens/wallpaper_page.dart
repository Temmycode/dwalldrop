import 'package:cached_network_image/cached_network_image.dart';
import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/app/widgets/action_buttons.dart';
import 'package:dwalldrop/app/widgets/wallpaper_info_container.dart';
import 'package:dwalldrop/setup/text/small_text.dart';
import 'package:dwalldrop/setup/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WallpaperPage extends ConsumerStatefulWidget {
  final String wallpaper;
  final String userAvatar;
  final String wallpaperName;
  final String username;
  const WallpaperPage({
    super.key,
    required this.wallpaper,
    required this.userAvatar,
    required this.wallpaperName,
    required this.username,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends ConsumerState<WallpaperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 28.w(context)),
        child: Column(
          children: [
            SizedBox(height: 31.h(context)),
            Container(
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  height: 335.h(context),
                  width: 337.h(context),
                ),
              ),
            ),
            SizedBox(height: 33.h(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.userAvatar),
                      radius: 25.h(context),
                    ),
                    SizedBox(width: 8.w(context)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // WALLPAPER NAME
                        TitleText(
                          text: widget.wallpaperName,
                          size: 15.h(context),
                        ),

                        // WALLPAPER USER NAME
                        TitleText(
                          text: widget.username,
                          color: Colors.black,
                          size: 11.h(context),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),

            // SAVE AND SET BUTTON
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SAVE BUTTON
                ActionButton(
                  title: "Save",
                  icon: Icon(Icons.download),
                  color: Colors.blue,
                ),
                // SET THE WALLPAPER
                ActionButton(
                  title: "Save",
                  icon: Icon(Icons.download),
                  color: Colors.blue,
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
              noOfDownloads: noOfDownloads,
              size: size,
              dimensions: dimensions,
            ),
          ],
        ),
      ),
    );
  }
}
