import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WallpaperContainers extends ConsumerWidget {
  final int index;
  const WallpaperContainers(this.index, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h(context)),
      height: index.isOdd ? 220.h(context) : 249.612.h(context),
      width: 175.w(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.h(context)),
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.25),
          )
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 68.4.h(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(
                    20.h(context),
                  ),
                ),
                color: Colors.black12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
