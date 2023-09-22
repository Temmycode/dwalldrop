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
import 'package:uuid/uuid.dart';
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
                          final heroKey = const Uuid().v1();

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
                            itemCount: wallpaper.length,
                            itemBuilder: (context, index) {
                              final favourites = wallpaper[index];
                              return GestureDetector(
                                onTap: () {
                                  // NAVIGATE TO THE WALLPAPER SETTING PAGE
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WallpaperPage(
                                        heroKey: heroKey,
                                        wallpaperId: favourites.wallpaperId,
                                        wallpaper: favourites.imageUrl,
                                      ),
                                    ),
                                  );
                                },
                                child: WallpaperContainers(
                                  wallpaperId: favourites.wallpaperId,
                                  heroKey: heroKey,
                                  index: index,
                                  image: favourites.imageUrl,
                                  wallpaperName: favourites.wallpaperName,
                                  creator: favourites.creatorName,
                                  liked: true,
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
