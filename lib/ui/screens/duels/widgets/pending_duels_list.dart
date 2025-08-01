import 'package:duelduck_solana/bloc/duels_cubit/duels_cubit.dart';
import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/ui/widgets/card/duel_card.dart';
import 'package:duelduck_solana/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingDuelsList extends StatelessWidget {
  final List<DuelModel> pendingDuelsList;
  const PendingDuelsList({super.key, required this.pendingDuelsList});

  @override
  Widget build(BuildContext context) {
    if (pendingDuelsList.isNotEmpty) {
      return ListView.builder(
        itemCount: pendingDuelsList.length,
        itemBuilder: (context, index) {
          final DuelModel duel = pendingDuelsList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: DuelCard.expandable(
              type: duel.duelCardType ?? DuelCardType.activeToVote,
              model: duel,
              pressedYes:
                  () => context.read<DuelsCubit>().resolveDuel(
                    answer: 1,
                    duelId: duel.id,
                  ),
              pressedNo:
                  () => context.read<DuelsCubit>().resolveDuel(
                    answer: 0,
                    duelId: duel.id,
                  ),
            ),
          );
        },
      );
    }

    return Center(
      child: Text(
        "duels_screen_pending_tab".tr(),
        style: ProjectFonts.headerRegular.copyWith(color: Colors.white),
      ),
    );
  }
}
