import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final Color? color;
  const SmallText({
    super.key,
    required this.text,
    this.size = 10,
    this.weight = FontWeight.normal,
    this.overflow = TextOverflow.fade,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color == Colors.white ? Colors.white : color,
        fontSize: size == 10 ? 10.h(context) : size,
        fontWeight: weight == FontWeight.normal ? FontWeight.normal : weight,
        overflow: overflow == TextOverflow.fade ? TextOverflow.fade : overflow,
      ),
    );
  }
}
