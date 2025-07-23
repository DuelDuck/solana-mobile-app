import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:duelduck_solana/data/repositories/models/create_duel.dart';
import 'package:duelduck_solana/ui/widgets/button/custom_button.dart';
import 'package:duelduck_solana/ui/widgets/card/duel_card.dart';
import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/ui/widgets/text/gradient_text.dart';
import 'package:duelduck_solana/utils/constants.dart';

class PublishDuel extends StatefulWidget {
  final CreateDuel createDuelModel;
  const PublishDuel({super.key, required this.createDuelModel});

  @override
  State<PublishDuel> createState() => _PublishDuelState();
}

class _PublishDuelState extends State<PublishDuel> {
  bool _isPublished = false;

  String? _selectedVotingButton;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  GradientText(
                    text:
                        "add_duel_screen_vote_to_publish_header"
                            .tr()
                            .toUpperCase(),
                    style: ProjectFonts.headerRegular.copyWith(fontSize: 22),
                    gradient: LinearGradient(
                      colors: [Colors.white, ProjectColors.gradientGrey],
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomText.basic(
                    text: "add_duel_screen_publish_description".tr(),
                    style: ProjectFonts.bodyRegular.copyWith(
                      color: ProjectColors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  DuelCard(
                    createDuelModel: widget.createDuelModel,
                    selectedVotingButton: _selectedVotingButton,
                    pressedYes: () {
                      setState(() {
                        _isPublished = true;
                        _selectedVotingButton = "vote_button_yes".tr();
                      });
                    },
                    pressedNo: () {
                      setState(() {
                        _isPublished = false;
                        _selectedVotingButton = "vote_button_no".tr();
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  Spacer(),
                  if (_isPublished)
                    CustomButton(
                      title: "add_duel_screen_share_button".tr(),
                      background: ProjectColors.primaryYellow,
                      borderSideColor: ProjectColors.primaryYellow,
                      textStyleTitle: ProjectFonts.headerRegular.copyWith(
                        fontSize: 16,
                        color: ProjectColors.backgroundDark,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ProjectSource.shareIcon),
                          const SizedBox(width: 16),
                          CustomText.basic(
                            text: "add_duel_screen_share_button".tr(),
                            style: ProjectFonts.headerRegular.copyWith(
                              fontSize: 16,
                              color: ProjectColors.backgroundDark,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
