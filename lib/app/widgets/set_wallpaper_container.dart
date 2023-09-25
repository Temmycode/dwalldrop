import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:flutter/material.dart';
import '../../setup/colors/app_colors.dart';
import '../../setup/text/title_text.dart';

class SetWallpaperContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  const SetWallpaperContainer({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        40.h(context),
      ),
      onTap: onTap,
      child: Ink(
        height: 70.h(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            40.h(context),
          ),
          color: AppColors.loginColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20.h(context),
              color: AppColors.blueColor,
            ),
            SizedBox(width: 20.w(context)),
            TitleText(
              text: text,
              size: 18.h(context),
            )
          ],
        ),
      ),
    );
  }
}
