import 'package:cached_network_image/cached_network_image.dart';
import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnDisplayWallpaperContainer extends ConsumerWidget {
  final String image;
  const OnDisplayWallpaperContainer({
    super.key,
    required this.image,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w(context)),
      height: 193.h(context),
      width: 313.w(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.h(context)),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          height: 193.h(context),
          width: 313.w(context),
        ),
      ),
    );
  }
}
