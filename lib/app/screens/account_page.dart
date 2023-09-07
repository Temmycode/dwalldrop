import 'package:dwalldrop/app/constants/account_page_constants.dart';
import 'package:dwalldrop/app/extensions/dimensions.dart';
import 'package:dwalldrop/app/widgets/account_page_list_tile.dart';
import 'package:dwalldrop/app/widgets/login_container.dart';
import 'package:dwalldrop/setup/colors/app_colors.dart';
import 'package:dwalldrop/setup/images/image.dart';
import 'package:dwalldrop/setup/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 33.h(context)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // THE APPLICATION VERSION
                  TitleText(
                    text: 'v5.1.3',
                    size: 13.h(context),
                    color: AppColors.blueColor,
                  ),
                  TitleText(
                    text: "Settings",
                    size: 18.h(context),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: ImageIcon(
                      const AssetImage(AppImages.close),
                      size: 19.h(context),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h(context)),
            const LoginContainer(),
            SizedBox(height: 17.h(context)),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: accountPageConstants
                  .map(
                    (value) => AccountPageListTile(
                      title: value[1],
                      subtitle: value[2],
                      leading: value[0],
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
