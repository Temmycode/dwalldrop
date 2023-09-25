import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/app/widgets/set_wallpaper_container.dart';
import 'package:dwalldrop/backend/state/providers/wallpaper_location_provider.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:dwalldrop/setup/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../backend/state/providers/download_wallpaper_state_provider.dart';

class SetWallpaperScrollable extends ConsumerWidget {
  const SetWallpaperScrollable({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final wallpaperLocation = ref.watch(wallpaperLocationProvider);
    return Ink(
      height: 320.h(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // set wallpaper
          TitleText(
            text: "Set Your Wallpaper",
            size: 18.h(context),
            color: AppColors.yellowColor,
          ),

          // WALLPAPER OPTIONS

          // home screen
          SetWallpaperContainer(
            onTap: () async {
              ref.read(wallpaperLocationProvider.notifier).state = 1;
              // this function sets the phones wallpaper
              await ref
                  .read(downloadWallpaperStateProvider.notifier)
                  .setWallpaper(
                    location: wallpaperLocation!,
                  );
            },
            text: "Home Screen",
            icon: Icons.home,
          ),

          // lock screen
          SetWallpaperContainer(
            onTap: () async {
              ref.read(wallpaperLocationProvider.notifier).state = 2;

              // this function sets the phones wallpaper
              await ref
                  .read(downloadWallpaperStateProvider.notifier)
                  .setWallpaper(
                    location: wallpaperLocation!,
                  );
            },
            text: "Lock Screen",
            icon: Icons.lock,
          ),

          // home & lock screen
          SetWallpaperContainer(
            onTap: () async {
              ref.read(wallpaperLocationProvider.notifier).state = 3;

              // this function sets the phones wallpaper
              await ref
                  .read(downloadWallpaperStateProvider.notifier)
                  .setWallpaper(
                    location: wallpaperLocation!,
                  );
            },
            text: "Home & Lock Screen",
            icon: Icons.phone_android_outlined,
          ),
        ],
      ),
    );
  }
}
