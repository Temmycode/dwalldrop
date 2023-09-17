import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/setup/images/image.dart';
import 'package:dwalldrop/setup/text/small_text.dart';
import 'package:flutter/material.dart';

class WallpaperInfoContainer extends StatelessWidget {
  final int noOfDownloads;
  final double size;
  final String dimensions;
  final Color color;
  final Color secondaryColor;
  const WallpaperInfoContainer({
    super.key,
    required this.noOfDownloads,
    required this.size,
    required this.dimensions,
    required this.color,
    required this.secondaryColor,
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
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // DOWNLOADS AND DIMENSIONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 140.w(context),
                child: Row(
                  children: [
                    ImageIcon(
                      const AssetImage(AppImages.downloadCircleIcon),
                      color: secondaryColor,
                    ),
                    SizedBox(width: 18.w(context)),
                    SmallText(
                      text: "Downloads: $noOfDownloads",
                      weight: FontWeight.bold,
                      // size: 13.h(context),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 140.w(context),
                child: Row(
                  children: [
                    ImageIcon(
                      const AssetImage(AppImages.downloadCircleIcon),
                      color: secondaryColor,
                    ),
                    SizedBox(width: 18.w(context)),
                    SmallText(
                      text: dimensions,
                      weight: FontWeight.bold,
                      // size: 13.h(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // MINIMAL AND SIZE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 140.w(context),
                child: Row(
                  children: [
                    ImageIcon(
                      const AssetImage(AppImages.shapesIcon),
                      color: secondaryColor,
                    ),
                    SizedBox(width: 18.w(context)),
                    const SmallText(
                      text: "Minimal",
                      weight: FontWeight.bold,
                      // size: 13.h(context),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 140.w(context),
                child: Row(
                  children: [
                    ImageIcon(
                      const AssetImage(AppImages.folderIcon),
                      color: secondaryColor,
                    ),
                    SizedBox(width: 18.w(context)),
                    SmallText(
                      text: "${size}MB",
                      weight: FontWeight.bold,
                      // size: 13.h(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ALL RIGHTS RESERVED AND REPORT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 140.w(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.error,
                      color: secondaryColor,
                    ),
                    SizedBox(width: 18.w(context)),
                    Text(
                      "All Rights Reserved",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        fontSize: 10.h(context),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 140.w(context),
                child: Row(
                  children: [
                    ImageIcon(
                      const AssetImage(AppImages.cautionIcon),
                      color: secondaryColor,
                    ),
                    SizedBox(width: 18.w(context)),
                    Text(
                      "Report",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        fontSize: 10.h(context),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
