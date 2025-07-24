import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:duelduck_solana/data/repositories/models/create_duel.dart';
import 'package:duelduck_solana/ui/widgets/button/custom_button.dart';
import 'package:duelduck_solana/ui/widgets/countdown_timer.dart';
import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/utils/constants.dart';

class DuelCard extends StatefulWidget {
  final CreateDuel createDuelModel;
  final String? selectedVotingButton;
  final Function() pressedYes;
  final Function() pressedNo;
  const DuelCard({
    super.key,
    required this.createDuelModel,
    required this.selectedVotingButton,
    required this.pressedYes,
    required this.pressedNo,
  });

  @override
  State<DuelCard> createState() => _DuelCardState();
}

class _DuelCardState extends State<DuelCard> {
  bool _showTimer = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: ProjectColors.black),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: SizedBox(
                      height: 115,
                      width: double.infinity,

                      child: Image.file(
                        File(widget.createDuelModel.imagePath),
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (_showTimer)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: ProjectColors.backgroundDark,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: CountdownTimer(
                          startDate: widget.createDuelModel.deadline,
                          onFinish: () {
                            setState(() {
                              _showTimer = false;
                            });
                          },
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(ProjectSource.duckIcon),
                    const SizedBox(width: 8),
                    CustomText.basic(
                      text: "User Name",
                      style: ProjectFonts.bodyMedium.copyWith(
                        color: ProjectColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomText.basic(
                  text: widget.createDuelModel.question,
                  style: ProjectFonts.bodySemibold,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomButton(
                buttonHeight: 56,
                borderRadius: 8,
                background:
                    widget.selectedVotingButton == "vote_button_no".tr()
                        ? ProjectColors.red
                        : ProjectColors.black,
                borderSideColor: ProjectColors.black,
                textStyleTitle: ProjectFonts.headerRegular.copyWith(
                  color:
                      widget.selectedVotingButton == "vote_button_no".tr()
                          ? ProjectColors.backgroundDark
                          : ProjectColors.red,
                  fontSize: 20,
                ),
                onPressed: widget.pressedNo,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText.basic(
                      text: "vote_button_no".tr(),
                      style: ProjectFonts.headerRegular.copyWith(
                        color:
                            widget.selectedVotingButton == "vote_button_no".tr()
                                ? ProjectColors.backgroundDark
                                : ProjectColors.red,
                        fontSize: 20,
                      ),
                    ),
                    if (widget.selectedVotingButton == "vote_button_no".tr())
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: SvgPicture.asset(
                          ProjectSource.selectedVoteButton,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomButton(
                buttonHeight: 56,
                borderRadius: 8,
                background:
                    widget.selectedVotingButton == "vote_button_yes".tr()
                        ? ProjectColors.green
                        : ProjectColors.black,
                borderSideColor: ProjectColors.black,
                textStyleTitle: ProjectFonts.headerRegular.copyWith(
                  color:
                      widget.selectedVotingButton == "vote_button_yes".tr()
                          ? ProjectColors.backgroundDark
                          : ProjectColors.green,
                  fontSize: 20,
                ),
                onPressed: widget.pressedYes,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText.basic(
                      text: "vote_button_yes".tr(),
                      style: ProjectFonts.headerRegular.copyWith(
                        color:
                            widget.selectedVotingButton ==
                                    "vote_button_yes".tr()
                                ? ProjectColors.backgroundDark
                                : ProjectColors.green,
                        fontSize: 20,
                      ),
                    ),
                    if (widget.selectedVotingButton == "vote_button_yes".tr())
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: SvgPicture.asset(
                          ProjectSource.selectedVoteButton,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
