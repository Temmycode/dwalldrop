import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final Color? color;
  const TitleText({
    super.key,
    required this.text,
    this.size = 12,
    this.weight = FontWeight.bold,
    this.overflow = TextOverflow.ellipsis,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color == Colors.white ? Colors.white : color,
        fontSize: size == 12 ? 12.h(context) : size,
        fontWeight: weight == FontWeight.bold ? FontWeight.bold : weight,
        overflow: overflow == TextOverflow.ellipsis
            ? TextOverflow.ellipsis
            : overflow,
      ),
    );
  }
}
