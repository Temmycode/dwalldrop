import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:dwalldrop/setup/images/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List accountPageConstants = [
  [
    ImageIcon(
      const AssetImage(AppImages.uploadIcon),
      color: AppColors.yellowColor,
    ),
    'My Uploads',
    'View your approved Community wallpapers',
  ],
  [
    ImageIcon(
      const AssetImage(AppImages.cacheIcon),
      color: AppColors.blueColor,
    ),
    'Clear Cache',
    'Clear locally cached images.',
  ],
  [
    Icon(
      CupertinoIcons.arrow_2_circlepath,
      color: AppColors.yellowColor,
    ),
    'Sync Favourites',
    'Sync your favourites across all your devices',
  ],
  [
    Icon(
      Icons.privacy_tip,
      color: AppColors.blueColor,
    ),
    'Sync Favourites',
    'Sync your favourites across all your devices',
  ],
  [
    Icon(
      CupertinoIcons.info_circle_fill,
      color: AppColors.yellowColor,
    ),
    'About',
    'Licenses and Credit',
  ],
];
