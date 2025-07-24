import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String nameWallet;
  final Function() onTapLogOut;
  const CustomAppBar({
    super.key,
    required this.nameWallet,
    required this.onTapLogOut,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 55,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 0, 4),
        child: Image.asset(ProjectSource.logoCircle),
      ),
      title: CustomText.title(
        text: "app_name".tr(),
        color: ProjectColors.yellow,
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            color: ProjectColors.greyBlack,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          width: 150,
          padding: EdgeInsets.all(8),
          child: Row(
            spacing: 8,
            children: [
              Image.asset(ProjectSource.iconWallet, width: 30),
              Flexible(
                child: CustomText.basic(
                  text: nameWallet,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: onTapLogOut,
                child: Image.asset(ProjectSource.logOut, width: 27),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
