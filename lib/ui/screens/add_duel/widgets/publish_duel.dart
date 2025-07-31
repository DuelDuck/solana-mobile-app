import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/ui/widgets/button/custom_button.dart';
import 'package:duelduck_solana/ui/widgets/card/duel_card.dart';
import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/ui/widgets/text/gradient_text.dart';
import 'package:duelduck_solana/utils/constants.dart';

class PublishDuel extends StatefulWidget {
  final CreateDuelModel createDuelModel;
  final bool isPublished;
  final bool isLoading;
  final Function() onEdit;
  final Function(CreateDuelModel) onVote;
  const PublishDuel({
    super.key,
    required this.createDuelModel,
    required this.isPublished,
    required this.isLoading,
    required this.onEdit,
    required this.onVote,
  });

  @override
  State<PublishDuel> createState() => _PublishDuelState();
}

class _PublishDuelState extends State<PublishDuel> {
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

                  if (!widget.isPublished) ...[
                    const SizedBox(height: 12),
                    CustomText.basic(
                      text: "add_duel_screen_publish_description".tr(),
                      style: ProjectFonts.bodyRegular.copyWith(
                        color: ProjectColors.grey,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  DuelCard.createdByMe(
                    model: widget.createDuelModel,
                    selectedVotingButton:
                        widget.createDuelModel.answer == null
                            ? null
                            : widget.createDuelModel.answer == 1
                            ? "vote_button_yes".tr()
                            : "vote_button_no".tr(),
                    pressedYes: () {
                      if (widget.createDuelModel.answer != null) return;
                      widget.onVote(widget.createDuelModel.copyWith(answer: 1));
                    },
                    pressedNo: () {
                      if (widget.createDuelModel.answer != null) return;
                      widget.onVote(widget.createDuelModel.copyWith(answer: 0));
                    },
                  ),
                  const SizedBox(height: 24),
                  Spacer(),

                  if (widget.isLoading) CircularProgressIndicator(),
                  if (widget.isPublished) ...[
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
                  ] else ...[
                    CustomButton(
                      title: "add_duel_screen_edit_button".tr(),
                      textStyleTitle: ProjectFonts.headerRegular.copyWith(
                        fontSize: 16,
                        color: ProjectColors.grey,
                      ),
                      onPressed: widget.onEdit,
                    ),
                  ],
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
