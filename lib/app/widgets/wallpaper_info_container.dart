import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:flutter/material.dart';

class WallpaperInfoContainer extends StatelessWidget {
  final int noOfDownloads;
  final double size;
  final String dimensions;
  const WallpaperInfoContainer({
    super.key,
    required this.noOfDownloads,
    required this.size,
    required this.dimensions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 21.h(context),
        horizontal: 18.w(context),
      ),
      height: 146.h(context),
      width: 337.w(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.h(context)),
      ),
      child: const Column(
        children: [
          // DOWNLOADS AND DIMENSIONS
          Row(
            children: [],
          ),
          // MINIMAL AND SIZE
          Row(
            children: [],
          ),
          // ALL RIGHTS RESERVED AND REPORT
          Row(
            children: [],
          ),
        ],
      ),
    );
  }
}
