import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/app/widgets/ondisplay_wallpaper_containers.dart';
import 'package:dwalldrop/app/widgets/wallpaper_containers.dart';
import 'package:dwalldrop/mock/ondisplay_wallpaper_mock.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:dwalldrop/setup/images/image.dart';
import 'package:dwalldrop/setup/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    final ondisplayController = ref.watch(onDisplayWallpaperPageProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 26.h(context)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // USER ACCOUNT ICON
                    Container(
                      padding: EdgeInsets.all(3.h(context)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.h(context)),
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

                    // APPLICATION TITLTE
                    TitleText(
                      text: "DWallDrop",
                      size: 20.h(context),
                      color: Colors.white,
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

              SizedBox(height: 33.h(context)),

              // PAGE VIEW OF THE DISPLAYED WALLPAPERS
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w(context)),
                height: 193.h(context),
                width: double.maxFinite,
                child: PageView.builder(
                  controller: ondisplayController,
                  itemCount: ondisplayWallpaperMock.length,
                  itemBuilder: (context, index) {
                    final data = ondisplayWallpaperMock[index];
                    return OnDisplayWallpaperContainer(image: data);
                  },
                ),
              ),
              SizedBox(height: 12.h(context)),
              MasonryGridView.count(
                padding: EdgeInsets.symmetric(horizontal: 13.w(context)),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 13,
                itemBuilder: (context, index) {
                  return WallpaperContainers(index);
                },
                itemCount: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

final onDisplayWallpaperPageProvider = Provider((ref) {
  // use the data from the back end for the calculation
  // i am using the mock data for now
  final initalPage = ondisplayWallpaperMock.length ~/ 2;
  final controller = PageController(
    viewportFraction: 0.83,
    initialPage: initalPage,
  );
  return controller;
});
