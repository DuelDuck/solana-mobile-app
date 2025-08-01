import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/ui/widgets/card/duel_card.dart';
import 'package:duelduck_solana/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreatedDuelsList extends StatelessWidget {
  final List<DuelModel> createdDuelsList;
  const CreatedDuelsList({super.key, required this.createdDuelsList});

  @override
  Widget build(BuildContext context) {
    if (createdDuelsList.isNotEmpty) {
      return ListView.builder(
        itemCount: createdDuelsList.length,
        itemBuilder: (context, index) {
          final DuelModel duel = createdDuelsList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: DuelCard.expandable(
              type: duel.duelCardType ?? DuelCardType.activeToVote,
              model: duel,
              pressedYes: () {},
              pressedNo: () {},
            ),
          );
        },
      );
    }

    return Center(
      child: Text(
        "duels_screen_created_tab".tr(),
        style: ProjectFonts.headerRegular.copyWith(color: Colors.white),
      ),
    );
  }
}
