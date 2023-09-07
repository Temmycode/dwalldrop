import 'package:flutter/foundation.dart' show immutable;

@immutable
class AppImages {
  // source of the icons
  static const String iconSrc = 'assets/icons';
  // source of the images
  static const String imgSrc = 'assets/images';

  // icons
  static const String search = '$iconSrc/search.png';
  static const String user = '$iconSrc/user.png';
  static const String close = '$iconSrc/close.png';
  static const String titleIcon = '$iconSrc/titleIcon.png';
  static const String uploadIcon = '$iconSrc/upload.png';
  static const String starIcon = '$iconSrc/star.png';
  static const String cacheIcon = '$iconSrc/cache.png';

  // images
  static const String google = '$imgSrc/google.png';
}
