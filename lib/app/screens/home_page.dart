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
    final int currentIndex = ref.watch(homePageIndexController);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.backgroundColor.withOpacity(0.5),
        elevation: 0,
        indicatorColor: AppColors.navIndicatorColor,
        height: 98.h(context),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (value) =>
            ref.read(homePageIndexController.notifier).state = value,
        selectedIndex: currentIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.compass_fill),
            icon: Icon(CupertinoIcons.compass),
            label: "Explore",
          ),
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.heart_fill),
            icon: Icon(CupertinoIcons.heart),
            label: "Favourite",
          ),
        ],
      ),
    );
  }
}
