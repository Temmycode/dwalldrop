import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/setup/text/small_text.dart';
import 'package:dwalldrop/setup/text/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../backend/state/providers/like_provider.dart';

class WallpaperContainers extends ConsumerWidget {
  final String wallpaperId;
  final String heroKey;
  final int index;
  final String image;
  final String wallpaperName;
  final String creator;
  final bool liked;

  const WallpaperContainers({
    super.key,
    required this.wallpaperId,
    required this.heroKey,
    required this.index,
    required this.image,
    required this.wallpaperName,
    required this.creator,
    required this.liked,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h(context)),
      height: index.isOdd ? 230.h(context) : 269.612.h(context),
      width: 175.w(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.h(context)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.15),
          )
        ],
      ),
      child: Stack(
        children: [
          Hero(
            tag: heroKey,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.h(context)),
              child: CachedNetworkImage(
                height: index.isOdd ? 230.h(context) : 269.612.h(context),
                width: 177.5.w(context),
                imageUrl: image,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(
                left: 10.w(context),
                right: 10.w(context),
                top: 18.79.h(context),
              ),
              height: 68.4.h(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(
                    20.h(context),
                  ),
                ),
                color: Colors.black26,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120.w(context),
                        child: TitleText(
                          text: wallpaperName,
                        ),
                      ),
                      SizedBox(height: 3.h(context)),
                      SmallText(text: creator),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      HapticFeedback.lightImpact();
                      await ref
                          .read(likeProvider.notifier)
                          .likeWallpaper(wallpaperId: wallpaperId);
                      log(
                        ref.read(likeProvider).result.toString(),
                      );
                    },
                    child: Icon(
                      liked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                      size: 23.3.h(context),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
