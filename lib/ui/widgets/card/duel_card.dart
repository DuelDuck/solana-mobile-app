import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/ui/widgets/button/custom_button.dart';
import 'package:duelduck_solana/ui/widgets/card/duel_card_body.dart';
import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/utils/constants.dart';

class DuelCard extends StatefulWidget {
  final DuelCardType _type;
  final BaseDuelModel _model;
  final String? _selectedVotingButton;
  final VoidCallback _pressedYes;
  final VoidCallback _pressedNo;

  const DuelCard.createdByMe({
    super.key,
    required CreateDuelModel model,
    required String? selectedVotingButton,
    required VoidCallback pressedYes,
    required VoidCallback pressedNo,
  }) : _type = DuelCardType.createdByMe,
       _model = model,
       _selectedVotingButton = selectedVotingButton,
       _pressedYes = pressedYes,
       _pressedNo = pressedNo;

  const DuelCard.expandable({
    super.key,
    required DuelCardType type,
    required DuelModel model,
    required VoidCallback pressedYes,
    required VoidCallback pressedNo,
  }) : _type = type,
       _model = model,
       _selectedVotingButton = null,
       _pressedYes = pressedYes,
       _pressedNo = pressedNo;

  @override
  State<DuelCard> createState() => _DuelCardState();
}

class _DuelCardState extends State<DuelCard> {
  @override
  Widget build(BuildContext context) {
    if (widget._type == DuelCardType.createdByMe) {
      return _CreateDuelCard(
        model: widget._model as CreateDuelModel,
        selectedVotingButton: widget._selectedVotingButton,
        pressedYes: widget._pressedYes,
        pressedNo: widget._pressedNo,
      );
    }

    return _ExpandableDuelCard(
      type: widget._type,
      model: widget._model as DuelModel,
      pressedYes: widget._pressedYes,
      pressedNo: widget._pressedNo,
    );
  }
}

class _CreateDuelCard extends StatefulWidget {
  final CreateDuelModel model;
  final String? selectedVotingButton;
  final VoidCallback pressedYes;
  final VoidCallback pressedNo;

  const _CreateDuelCard({
    required this.model,
    required this.selectedVotingButton,
    required this.pressedYes,
    required this.pressedNo,
  });

  @override
  State<_CreateDuelCard> createState() => _CreateDuelCardState();
}

class _CreateDuelCardState extends State<_CreateDuelCard> {
  bool _showLabel = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ProjectColors.black,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.only(bottom: 24),
          child: DuelCardBody.short(
            model: widget.model,
            isTimeFinish: _showLabel,
            onTimeFinish: () {
              setState(() {
                _showLabel = false;
              });
            },
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

class _ExpandableDuelCard extends StatefulWidget {
  final DuelCardType type;
  final DuelModel model;
  final VoidCallback pressedYes;
  final VoidCallback pressedNo;

  const _ExpandableDuelCard({
    required this.type,
    required this.model,
    required this.pressedYes,
    required this.pressedNo,
  });

  @override
  State<_ExpandableDuelCard> createState() => _ExpandableDuelCardState();
}

class _ExpandableDuelCardState extends State<_ExpandableDuelCard> {
  final List<DuelModel> listExpandDuels = [];

  bool _isTimeFinish = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ProjectColors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft:
                  widget.type == DuelCardType.activeToVote ||
                          widget.type == DuelCardType.refunded
                      ? Radius.circular(15)
                      : Radius.zero,
              bottomRight:
                  widget.type == DuelCardType.activeToVote ||
                          widget.type == DuelCardType.refunded
                      ? Radius.circular(15)
                      : Radius.zero,
            ),
          ),
          child: Column(
            children: [
              DuelCardBody.long(
                model: widget.model,
                isTimeFinish: _isTimeFinish,
                type: widget.type,
                isExpand:
                    listExpandDuels.indexWhere(
                      (d) => d.id == widget.model.id,
                    ) !=
                    -1,
                onChangeValueExpand: () {
                  if (listExpandDuels.indexWhere(
                        (d) => d.id == widget.model.id,
                      ) !=
                      -1) {
                    listExpandDuels.removeWhere((d) => d.id == widget.model.id);
                  } else {
                    listExpandDuels.add(widget.model);
                  }
                  setState(() {});
                },
                onTimeFinish: () {
                  setState(() {
                    _isTimeFinish = false;
                  });
                },
              ),
            ],
          ),
        ),
        if (widget.type == DuelCardType.waitingForResult)
          _buildOneResultButton(
            title: "duel_card_button_wating_for_result_title".tr(),
            textStyle: ProjectFonts.headerRegular.copyWith(
              color: ProjectColors.grey,
              fontSize: 18,
            ),
          ),

        if (widget.type == DuelCardType.cancelled)
          _buildOneResultButton(
            title: "duel_card_button_cancelled".tr(),
            textStyle: ProjectFonts.headerRegular.copyWith(
              color: ProjectColors.grey,
              fontSize: 18,
            ),
          ),
        if (widget.type == DuelCardType.activeToVote)
          _buildTwoButtons(
            titleLeftBtn: "vote_button_no".tr(),
            titleRightBtn: "vote_button_yes".tr(),
            cardType: widget.type,
          ),
        if (widget.type == DuelCardType.pending)
          _buildTwoButtons(
            titleLeftBtn: "duel_card_button_waiting_resolver_no_wins".tr(),
            titleRightBtn: "duel_card_button_waiting_resolver_yes_wins".tr(),
            cardType: widget.type,
          ),
        if (widget.type == DuelCardType.cancelled)
          _buildOneResultButton(
            title: "duel_card_button_cancelled".tr(),
            textStyle: ProjectFonts.headerRegular.copyWith(
              color: ProjectColors.grey,
              fontSize: 18,
            ),
          ),
        if (widget.type == DuelCardType.done)
          _buildOneResultButton(
            title:
                widget.model.finalResult == 1
                    ? "duel_card_button_yes_won".tr()
                    : "duel_card_button_no_won".tr(),
            textStyle: ProjectFonts.headerRegular.copyWith(
              color: ProjectColors.green,
              fontSize: 18,
            ),
          ),
      ],
    );
  }

  _buildTwoButtons({
    required String titleLeftBtn,
    required String titleRightBtn,
    required DuelCardType cardType,
  }) {
    // final isSelectedNo =
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomButton(
              buttonHeight: 56,
              borderRadius: 8,
              background:
                  (widget.model.yourAnswer == 0 &&
                              cardType != DuelCardType.pending) ||
                          (cardType == DuelCardType.pending &&
                              widget.model.finalResult == 0)
                      ? ProjectColors.red
                      : ProjectColors.black,
              borderSideColor: ProjectColors.black,
              textStyleTitle: ProjectFonts.headerRegular.copyWith(
                color:
                    (widget.model.yourAnswer == 0 &&
                                cardType != DuelCardType.pending) ||
                            ((cardType == DuelCardType.pending &&
                                widget.model.finalResult == 0))
                        ? ProjectColors.backgroundDark
                        : ProjectColors.red,
                fontSize: 20,
              ),
              onPressed: widget.pressedNo,
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText.basic(
                      text: titleLeftBtn,
                      style: ProjectFonts.headerRegular.copyWith(
                        color:
                            (widget.model.yourAnswer == 0 &&
                                        cardType != DuelCardType.pending) ||
                                    (cardType == DuelCardType.pending &&
                                        widget.model.finalResult == 0)
                                ? ProjectColors.backgroundDark
                                : ProjectColors.red,
                        fontSize: 20,
                      ),
                    ),
                    if (widget.model.yourAnswer == 0 &&
                        cardType != DuelCardType.pending)
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
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomButton(
              buttonHeight: 56,
              borderRadius: 8,
              background:
                  (widget.model.yourAnswer == 1 &&
                              cardType != DuelCardType.pending) ||
                          (cardType == DuelCardType.pending &&
                              widget.model.finalResult == 1)
                      ? ProjectColors.green
                      : ProjectColors.black,
              borderSideColor: ProjectColors.black,
              textStyleTitle: ProjectFonts.headerRegular.copyWith(
                color:
                    widget.model.yourAnswer == 1 &&
                                cardType != DuelCardType.pending ||
                            (cardType == DuelCardType.pending &&
                                widget.model.finalResult == 1)
                        ? ProjectColors.backgroundDark
                        : ProjectColors.green,
                fontSize: 20,
              ),
              onPressed: widget.pressedYes,
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText.basic(
                      text: titleRightBtn,
                      style: ProjectFonts.headerRegular.copyWith(
                        color:
                            widget.model.yourAnswer == 1 &&
                                        cardType != DuelCardType.pending ||
                                    (cardType == DuelCardType.pending &&
                                        widget.model.finalResult == 1)
                                ? ProjectColors.backgroundDark
                                : ProjectColors.green,
                        fontSize: 20,
                      ),
                    ),
                    if ((widget.model.yourAnswer == 1 &&
                            cardType != DuelCardType.pending) ||
                        (cardType == DuelCardType.pending &&
                            widget.model.finalResult == 1))
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
          ),
        ],
      ),
    );
  }

  _buildOneResultButton({required String title, required TextStyle textStyle}) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ProjectColors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      alignment: Alignment.center,
      child: CustomText.basic(text: title, style: textStyle),
    );
  }
}
