import 'package:flutter/material.dart';

extension Dimensions on num {
  double h(BuildContext context) {
    const screenHeight = 852;
    final height = MediaQuery.sizeOf(context).height;
    return height * (this / screenHeight);
  }

  double w(BuildContext context) {
    const screenWidth = 393;
    final width = MediaQuery.sizeOf(context).width;
    return width * (this / screenWidth);
  }
}
