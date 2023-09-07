import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/setup/text/small_text.dart';
import 'package:dwalldrop/setup/text/title_text.dart';
import 'package:flutter/material.dart';

class AccountPageListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget leading;
  const AccountPageListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: TitleText(
        text: title,
        size: 14.h(context),
      ),
      subtitle: SmallText(
        text: subtitle,
        size: 11.h(context),
      ),
    );
  }
}
