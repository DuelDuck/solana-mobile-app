import 'package:duelduck_solana/ui/widgets/button/custom_button.dart';
import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LogInModal extends StatelessWidget {
  final Function() onPressed;
  const LogInModal({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ProjectColors.greyBlack,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText.basic(
                text: "connect_wallet_modal_title".tr(),
                style: ProjectFonts.headerRegular.copyWith(fontSize: 16),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                visualDensity: VisualDensity.compact,
                icon: SvgPicture.asset(ProjectSource.closeIcon),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          const SizedBox(height: 18),
          CustomText.basic(
            text: "connect_wallet_modal_description_1".tr(),
            style: ProjectFonts.bodyMedium.copyWith(
              fontSize: 15,
              color: ProjectColors.grey,
            ),
          ),
          CustomText.basic(
            text: "connect_wallet_modal_description_2".tr(),
            style: ProjectFonts.bodyMedium.copyWith(fontSize: 15),
          ),
          CustomText.basic(
            text: "connect_wallet_modal_description_1".tr(),
            style: ProjectFonts.bodyMedium.copyWith(
              fontSize: 15,
              color: ProjectColors.grey,
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            textStyleTitle: ProjectFonts.headerRegular.copyWith(fontSize: 16),
            background: ProjectColors.black,
            borderRadius: 100,
            onPressed: onPressed,
            child: Row(
              children: [
                Image.asset(ProjectSource.iconWallet, width: 25),
                const SizedBox(width: 16),
                CustomText.basic(
                  text: "connect_wallet_modal_button_title".tr(),
                  style: ProjectFonts.headerRegular.copyWith(fontSize: 16),
                ),
                Spacer(),
                SvgPicture.asset(ProjectSource.arrowRightIcon),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
