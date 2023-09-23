import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/setup/text/title_text.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final bool isLoading;
  final String title;
  final Widget icon;
  final Color color;
  const ActionButton({
    super.key,
    required this.isLoading,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 52.h(context),
      width: 159.w(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.h(context)),
        color: color,
      ),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  SizedBox(width: 10.w(context)),
                  TitleText(
                    text: title,
                    size: 15.h(context),
                  ),
                ],
              ),
      ),
    );
  }
}
