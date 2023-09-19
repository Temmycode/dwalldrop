import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/app/screens/wallpaper_page.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../mock/wallpaper_mock_data.dart';
import '../widgets/wallpaper_containers.dart';

class FavouritesPage extends ConsumerWidget {
  const FavouritesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MasonryGridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 13.w(context),
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              crossAxisSpacing: 13,
              itemCount: wallpaperMockData.length,
              itemBuilder: (context, index) {
                final wallpaper = wallpaperMockData[index];

                return GestureDetector(
                  onTap: () {
                    // NAVIGATE TO THE WALLPAPER SETTING PAGE
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WallpaperPage(
                          wallpaper: wallpaper[0],
                          userAvatar:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9ZGIm8lYWI9-2TH7LQDLEcbVGaLyays2e9Q&usqp=CAU',
                          wallpaperName: wallpaper[1],
                          username: wallpaper[2],
                        ),
                      ),
                    );
                  },
                  child: WallpaperContainers(
                    index: index,
                    image: wallpaper[0],
                    wallpaperName: wallpaper[1],
                    creator: wallpaper[2],
                    liked: wallpaper[3],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
