import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingContainer extends ConsumerWidget {
  final int index;

  const LoadingContainer({
    super.key,
    required this.index,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h(context)),
      height: index.isOdd ? 230.h(context) : 269.612.h(context),
      width: 175.w(context),
      decoration: BoxDecoration(
        color: AppColors.loginColor,
        borderRadius: BorderRadius.circular(20.h(context)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.15),
          )
        ],
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(
          duration: 1.2.seconds,
          color: AppColors.backgroundColor.withAlpha(100),
        );
  }
}
