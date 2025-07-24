import 'package:duelduck_solana/ui/widgets/animation/animated_clip_rect.dart';
import 'package:duelduck_solana/ui/widgets/card/duel_card.dart';
import 'package:duelduck_solana/ui/widgets/tooltip/tooltip.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/ui/widgets/countdown_timer.dart';
import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/utils/constants.dart';

class DuelCardBody extends StatelessWidget {
  final BaseDuelModel _model;
  final bool _isTimeFinish;
  final bool? _isExpand;
  final DuelCardType? _type;
  final Function() _onTimeFinish;
  final Function()? _onChangeValueExpand;

  const DuelCardBody.short({
    super.key,
    required CreateDuelModel model,
    required bool isTimeFinish,
    required Function() onTimeFinish,
  }) : _model = model,
       _isTimeFinish = isTimeFinish,
       _type = null,
       _isExpand = null,
       _onTimeFinish = onTimeFinish,
       _onChangeValueExpand = null;

  const DuelCardBody.long({
    super.key,
    required DuelModel model,
    required bool isTimeFinish,
    required DuelCardType type,
    required bool isExpand,
    required Function() onTimeFinish,
    required Function()? onChangeValueExpand,
  }) : _model = model,
       _isTimeFinish = isTimeFinish,
       _type = type,
       _isExpand = isExpand,
       _onTimeFinish = onTimeFinish,
       _onChangeValueExpand = onChangeValueExpand;

  @override
  Widget build(BuildContext context) {
    if (_onChangeValueExpand != null && _isExpand != null) {
      return _LongCardBody(
        model: _model as DuelModel,
        isTimeFinish: _isTimeFinish,
        isExpand: _isExpand,
        type: _type ?? DuelCardType.activeToVote,
        onTimeFinish: _onTimeFinish,
        onChangeValueExpand: _onChangeValueExpand,
      );
    }

    return _ShortCardBody(
      model: _model as CreateDuelModel,
      isTimeFinish: _isTimeFinish,
      onTimeFinish: _onTimeFinish,
    );
  }
}

class _ShortCardBody extends StatelessWidget {
  final CreateDuelModel model;
  final bool isTimeFinish;
  final Function() onTimeFinish;

  const _ShortCardBody({
    required this.model,
    required this.isTimeFinish,
    required this.onTimeFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                // TODO: image
                // child: Image.file(
                //   File(imagePath),
                //   width: 64,
                //   height: 64,
                //   fit: BoxFit.cover,
                // ),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/3/3f/Fronalpstock_big.jpg',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CircularProgressIndicator();
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 100);
                  },
                ),
              ),
            ),
            if (isTimeFinish)
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: ProjectColors.backgroundDark,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CountdownTimer(
                    startDate: model.deadline,
                    onFinish: onTimeFinish,
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
            text: model.question,
            style: ProjectFonts.bodySemibold,
          ),
        ),
      ],
    );
  }
}

class _LongCardBody extends StatelessWidget {
  final DuelModel model;
  final bool isTimeFinish;
  final bool isExpand;
  final DuelCardType type;
  final Function() onTimeFinish;
  final Function() onChangeValueExpand;

  const _LongCardBody({
    required this.model,
    required this.isTimeFinish,
    required this.isExpand,
    required this.type,
    required this.onTimeFinish,
    required this.onChangeValueExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                // TODO: image
                // child: Image.file(
                //   File(imagePath),
                //   width: 64,
                //   height: 64,
                //   fit: BoxFit.cover,
                // ),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/3/3f/Fronalpstock_big.jpg',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CircularProgressIndicator();
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 100);
                  },
                ),
              ),
            ),
            if (type == DuelCardType.activeToVote && isTimeFinish) ...[
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: ProjectColors.backgroundDark,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CountdownTimer(
                    startDate: model.deadline,
                    onFinish: onTimeFinish,
                  ),
                ),
              ),
            ] else ...[
              // TODO: status label
              // Positioned(
              //   top: 16,
              //   left: 16,
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //     decoration: BoxDecoration(
              //       color: ProjectColors.backgroundDark,
              //       borderRadius: BorderRadius.circular(100),
              //     ),
              //     child: ,
              //   ),
              // ),
            ],

            if (type == DuelCardType.activeToVote)
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: ProjectColors.backgroundDark,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      ProjectSource.shareIcon,
                      colorFilter: ColorFilter.mode(
                        ProjectColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
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
            text: model.question,
            style: ProjectFonts.bodySemibold,
          ),
        ),
        Column(
          children: [
            AnimatedClipRect(
              open: isExpand,
              horizontalAnimation: false,
              verticalAnimation: true,
              child: _buildStatisticData(
                votePrice: model.duelPrice,
                fee: model.commission,
                resolves: model.resolvedBy,
                sourceOfTrue: model.sourceOfTruth,
              ),
            ),
            GestureDetector(
              onTap: onChangeValueExpand,
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 25,
                width: double.infinity,
                alignment: Alignment.topCenter,
                child:
                    isExpand
                        ? SvgPicture.asset(ProjectSource.arrowTopIcon)
                        : SvgPicture.asset(ProjectSource.arrowBottomIcon),
              ),
            ),
            const SizedBox(height: 12),
            if (type == DuelCardType.activeToVote)
              _buildStatisticLine(
                playersCount: model.playersCount,
                yesCount: model.yesCount,
                noCount: model.noCount,
              ),
          ],
        ),
      ],
    );
  }

  _buildStatisticData({
    required int votePrice,
    required int fee,
    required String resolves,
    required String sourceOfTrue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Vote price
          Row(
            children: [
              CustomText.basic(
                text: "duel_card_body_details_vote_price".tr(),
                style: ProjectFonts.bodyMedium.copyWith(
                  color: ProjectColors.grey,
                ),
              ),
              const SizedBox(width: 8),
              TooltipWidget(
                text: "duel_card_body_details_tooltip_vote_price".tr(),
              ),
              Spacer(),
              _buildUsdcIcon(),
              const SizedBox(width: 8),
              CustomText.basic(
                text: votePrice.toString(),
                style: ProjectFonts.headerRegular.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Fee
          Row(
            children: [
              CustomText.basic(
                text: "duel_card_body_details_vote_fee".tr(),
                style: ProjectFonts.bodyMedium.copyWith(
                  color: ProjectColors.grey,
                ),
              ),
              const SizedBox(width: 8),
              TooltipWidget(text: "duel_card_body_details_tooltip_fee".tr()),
              Spacer(),
              CustomText.basic(
                text: "$fee%",
                style: ProjectFonts.headerRegular.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Who resolves
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText.basic(
                text: "duel_card_body_details_vote_resolves".tr(),
                style: ProjectFonts.bodyMedium.copyWith(
                  color: ProjectColors.grey,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: CustomText.basic(
                  text: resolves,
                  style: ProjectFonts.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Source of True
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                CustomText.basic(
                  text: "duel_card_body_details_vote_source".tr(),
                  style: ProjectFonts.bodyMedium.copyWith(
                    color: ProjectColors.grey,
                  ),
                ),
                Spacer(),
                CustomText.basic(
                  text: "duel_card_body_details_vote_source_link".tr(),
                  style: ProjectFonts.bodyMedium,
                ),
                const SizedBox(width: 8),
                Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    color: ProjectColors.greyBlack,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(ProjectSource.arrowRightTop),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
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

  _buildStatisticLine({
    required int playersCount,
    required int yesCount,
    required int noCount,
  }) {
    final int yesPercent =
        playersCount == 0 ? 0 : ((yesCount / playersCount) * 100).round();
    final int noPercent =
        playersCount == 0 ? 0 : ((noCount / playersCount) * 100).round();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText.basic(
                text: "duel_card_body_statistic_no".tr(args: ["$noPercent"]),
                style: ProjectFonts.bodyMedium.copyWith(
                  color: ProjectColors.grey,
                ),
              ),
              CustomText.basic(
                text: "duel_card_body_statistic_votes".tr(
                  args: ["$playersCount"],
                ),
                style: ProjectFonts.bodyMedium.copyWith(
                  color: ProjectColors.grey,
                ),
              ),
              CustomText.basic(
                text: "duel_card_body_statistic_yes".tr(args: ["$yesPercent"]),
                style: ProjectFonts.bodyMedium.copyWith(
                  color: ProjectColors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          child: Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(color: ProjectColors.grey),
            child: Row(
              children: [
                // No
                Expanded(
                  flex: noPercent,
                  child: Container(
                    decoration: BoxDecoration(color: ProjectColors.red),
                  ),
                ),
                // Yes
                Expanded(
                  flex: yesPercent,
                  child: Container(
                    decoration: BoxDecoration(color: ProjectColors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
