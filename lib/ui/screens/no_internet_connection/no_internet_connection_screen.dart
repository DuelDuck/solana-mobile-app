import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/utils/constants.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  const NoInternetConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        centerTitle: true,
        title: Row(
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 0, 4),
              child: Image.asset(ProjectSource.logoCircle, width: 37),
            ),
            CustomText.title(
              text: "app_name".tr(),
              color: ProjectColors.yellow,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          spacing: 24,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(ProjectSource.noConnectionLogo),
            CustomText.title(text: "no_internet_connection_screen_title".tr()),
            CustomText.basic(
              text: "no_internet_connection_screen_subtitle".tr(),
              maxLines: 3,
              color: ProjectColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
