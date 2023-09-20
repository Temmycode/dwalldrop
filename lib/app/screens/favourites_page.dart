import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/app/providers/favourtite_wallpapers_provider.dart';
import 'package:dwalldrop/app/screens/wallpaper_page.dart';
import 'package:dwalldrop/app/widgets/app_bar.dart';
import 'package:dwalldrop/app/widgets/loading_widget.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:dwalldrop/setup/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../mock/wallpaper_mock_data.dart';
import '../widgets/wallpaper_containers.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // APP BAR
          const AppBarWidget(),
          // BODY
          SliverToBoxAdapter(
            child: Column(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final favouriteWallpaper =
                        ref.watch(favourtieWallpaperProvider);
                    return favouriteWallpaper.when(
                      data: (wallpaper) {
                        if (wallpaper.isEmpty) {
                          return const Center(
                            child: TitleText(text: "No favourites yet"),
                          );
                        } else {
                          return MasonryGridView.builder(
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
                          );
                        }
                      },
                      error: (error, stk) {
                        throw Exception(error.toString());
                      },
                      loading: () => const LoadingWidget(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
