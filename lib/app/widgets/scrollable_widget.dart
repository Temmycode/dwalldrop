import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/app/widgets/set_wallpaper_scrollable.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:flutter/material.dart';

showDraggableScrollableWidget(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: AppColors.backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        15.h(context),
      ),
    ),
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.1,
        maxChildSize: 1.0,
        builder: (context, ScrollController scrollController) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
            child: const Center(
              child: SetWallpaperScrollable(),
            ),
          );
        },
      );
    },
  );
}
