import 'package:dwalldrop/app/constants/pages_constants.dart';
import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/app/providers/controllers/page_index_controller.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(pageController);
    final int currentIndex = ref.watch(homePageIndexController);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        key: key,
        controller: controller,
        children: pages,
      ),
      //  pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        indicatorColor: AppColors.navIndicatorColor,
        height: 98.h(context),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (value) {
          ref.read(homePageIndexController.notifier).state = value;
          ref.read(pageController).animateToPage(
                value,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
        },
        selectedIndex: currentIndex,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(
              CupertinoIcons.compass_fill,
              color: AppColors.yellowColor,
            ),
            icon: Icon(
              CupertinoIcons.compass,
              color: Colors.grey.shade400.withOpacity(0.5),
            ),
            label: "Explore",
          ),
          NavigationDestination(
            selectedIcon: Icon(
              CupertinoIcons.heart_fill,
              color: AppColors.yellowColor,
            ),
            icon: Icon(
              CupertinoIcons.heart,
              color: Colors.grey.shade400.withOpacity(0.5),
            ),
            label: "Favourite",
          ),
        ],
      ),
    );
  }
}

final pageController = Provider<PageController>((ref) {
  final controller = PageController();
  return controller;
});
