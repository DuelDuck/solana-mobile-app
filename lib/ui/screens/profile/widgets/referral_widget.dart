import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:duelduck_solana/ui/widgets/field/custom_text_field.dart';
import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/ui/widgets/text/gradient_text.dart';
import 'package:duelduck_solana/utils/constants.dart';

class ReferralWidget extends StatefulWidget {
  const ReferralWidget({super.key});

  @override
  State<ReferralWidget> createState() => _ReferralWidgetState();
}

class _ReferralWidgetState extends State<ReferralWidget> {
  late TextEditingController _referralController;
  final _referralBalance = 0;

  @override
  void initState() {
    super.initState();
    _referralController = TextEditingController(
      text: "duelduck/profile.com/horuna",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Center(
          child: GradientText(
            text: "profile_screen_tab_referral_title".tr(),
            style: ProjectFonts.headerRegular.copyWith(fontSize: 22),
            gradient: LinearGradient(
              colors: [Colors.white, ProjectColors.gradientGrey],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildUsdcIcon(),
            const SizedBox(width: 8),
            CustomText.basic(
              text: "+$_referralBalance",
              style: ProjectFonts.headerRegular.copyWith(
                fontSize: 18,
                color:
                    _referralBalance > 0
                        ? ProjectColors.green
                        : ProjectColors.greySecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        CustomTextField.outline(
          controller: _referralController,
          readOnly: true,
          hint: "",
          suffixIcon: GestureDetector(
            onTap: () {
              Clipboard.setData(
                const ClipboardData(text: "duelduck/profile.com/horuna"),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: ProjectColors.primaryYellow,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(ProjectSource.shareIcon),
              ),
            ),
          ),
          onChanged: (vallue) {},
          onSubmitted: (value) {},
        ),
        const SizedBox(height: 16),
        _buildDescriptionField(
          "profile_screen_tab_referral_description_1".tr(),
        ),
        _buildDescriptionField(
          "profile_screen_tab_referral_description_2".tr(),
        ),
        _buildDescriptionField(
          "profile_screen_tab_referral_description_3".tr(),
        ),
        _buildDescriptionField(
          "profile_screen_tab_referral_description_4".tr(),
        ),
      ],
    );
  }

  _buildUsdcIcon() {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ProjectColors.greyBorder,
      ),
      padding: EdgeInsets.all(3),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          SvgPicture.asset(ProjectSource.usdcIcon),
        ],
      ),
    );
  }

  _buildDescriptionField(String text) {
    return Row(
      children: [
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            color: ProjectColors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        CustomText.basic(
          text: text,
          style: ProjectFonts.bodyRegular.copyWith(color: ProjectColors.grey),
        ),
      ],
    );
  }
}
