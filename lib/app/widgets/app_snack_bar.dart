import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:dwalldrop/setup/text/title_text.dart';
import 'package:flutter/material.dart';

appSnackBar(
  BuildContext context,
  String information,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.h(context)),
      ),
      backgroundColor: AppColors.yellowColor,
      elevation: 1,
      content: Center(
        child: TitleText(text: information),
      ),
    ),
  );
}
