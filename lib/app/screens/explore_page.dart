import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/app/providers/is_upload_hidden_provider.dart';
import 'package:dwalldrop/app/screens/account_page.dart';
import 'package:dwalldrop/app/screens/upload_wallpaper_page.dart';
import 'package:dwalldrop/app/widgets/ondisplay_wallpaper_containers.dart';
import 'package:dwalldrop/app/widgets/wallpaper_containers.dart';
import 'package:dwalldrop/mock/ondisplay_wallpaper_mock.dart';
import 'package:dwalldrop/mock/wallpaper_mock_data.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:dwalldrop/setup/images/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../providers/on_display_wallpaper_page_provider.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // scroll controller with a listener
    _scrollController.addListener(() {
      // IF THE SCROLL POSITION IS AT THE TOP THE UPLOAD BUTTON WILL SHOW
      if (_scrollController.position.pixels == 0) {
        ref.read(isUploadHiddenProvider.notifier).state = false;
      }
      // IF THE SCROLL POSITION IS GOING DOWN THEN THE UPLOAD BUTTON WILL NOT SHOW
      else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        ref.read(isUploadHiddenProvider.notifier).state = true;
      }
      // IF THE SCROLL POSITION IS GOING UP THEN THE UPLOAD BUTTON WILL SHOW
      else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        ref.read(isUploadHiddenProvider.notifier).state = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ondisplayController = ref.watch(onDisplayWallpaperPageProvider);
    final isUploadHidden = ref.watch(isUploadHiddenProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                // APP BAR
                SliverAppBar(
                  title: Column(
                    children: [
                      SizedBox(height: 26.h(context)),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 13.w(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // USER ACCOUNT ICON
                            GestureDetector(
                              // NAVIGATING TO THE USER ACCOUNT PAGE
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AccountPage(),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(3.h(context)),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(32.h(context)),
                                  border: Border.all(
                                    color: AppColors.userAccountColor,
                                    width: 2.5,
                                  ),
                                ),
                                child: ImageIcon(
                                  const AssetImage(AppImages.user),
                                  color: AppColors.userAccountColor,
                                ),
                              ),
                            ),

                            // APPLICATION TITLTE
                            Image.asset(
                              AppImages.titleIcon,
                              height: 20.h(context),
                              width: 111.w(context),
                            ),
                            // SEARCH BUTTON
                            GestureDetector(
                              onTap: () {},
                              child: ImageIcon(
                                const AssetImage(AppImages.search),
                                color: Colors.white,
                                size: 20.h(context),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  floating: true,
                  elevation: 0,
                  titleSpacing: 0,
                  backgroundColor: AppColors.backgroundColor,
                  toolbarHeight: 68.h(context),
                  scrolledUnderElevation: 0,
                  centerTitle: true,
                ),

                // PAGE VIEW OF WALLPAPERS
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 33.h(context)),

                      // PAGE VIEW OF THE DISPLAYED WALLPAPERS
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w(context)),
                        height: 193.h(context),
                        width: double.maxFinite,
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: ondisplayController,
                              itemCount: ondisplayWallpaperMock.length,
                              itemBuilder: (context, index) {
                                final data = ondisplayWallpaperMock[index];
                                return OnDisplayWallpaperContainer(image: data);
                              },
                            ),
                            Positioned(
                              right: 0,
                              left: 0,
                              bottom: 6.h(context),
                              child: Center(
                                child: SmoothPageIndicator(
                                  controller: ondisplayController,
                                  count: ondisplayWallpaperMock.length,
                                  effect: WormEffect(
                                    dotWidth: 8.w(context),
                                    dotHeight: 8.h(context),
                                    spacing: 9.w(context),
                                    activeDotColor: Colors.white,
                                    dotColor:
                                        Colors.grey.shade300.withOpacity(0.3),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h(context)),

                      // GRID VIEW OF THE WALLPAPERS
                      MasonryGridView.count(
                        padding:
                            EdgeInsets.symmetric(horizontal: 13.w(context)),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 13,
                        itemBuilder: (context, index) {
                          final wallpapers = wallpaperMockData[index];
                          return WallpaperContainers(
                            index: index,
                            image: wallpapers[0],
                            wallpaperName: wallpapers[1],
                            creator: wallpapers[2],
                            liked: wallpapers[3],
                          );
                        },
                        itemCount: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 50.h(context),
              child: Center(
                child: AnimatedOpacity(
                  duration: 250.ms,
                  opacity: isUploadHidden ? 0 : 1,
                  child: CupertinoButton(
                    onPressed: isUploadHidden
                        ? () {}
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const UploadWallpaperPage(),
                              ),
                            );
                          },
                    child: Container(
                      height: 60.h(context),
                      width: 60.h(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.h(context)),
                        color: AppColors.yellowColor,
                      ),
                      child: const Icon(
                        CupertinoIcons.square_arrow_up,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
