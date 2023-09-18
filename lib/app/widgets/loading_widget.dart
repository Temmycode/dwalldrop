import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/app/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: EdgeInsets.symmetric(horizontal: 13.w(context)),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 13,
      itemCount: 6,
      itemBuilder: (context, index) {
        return LoadingContainer(index: index);
      },
    );
  }
}
