import 'package:duelduck_solana/bloc/auth_cubit/auth_cubit.dart';
import 'package:duelduck_solana/bloc/home_cubit/home_cubit.dart';
import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/ui/widgets/card/duel_card.dart';
import 'package:duelduck_solana/ui/widgets/modal/log_in_modal.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isAutorization;
  @override
  void initState() {
    isAutorization =
        context.read<AuthCubit>().state is AuthSuccessConnectWallet;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous is! AuthInitial,
      listener: (context, state) {
        context.read<HomeCubit>().loadAllDuels();
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state.duelsList != null) {
            return ListView.builder(
              itemCount: state.duelsList!.length,
              itemBuilder: (context, index) {
                final DuelModel duel = state.duelsList![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 16,
                  ),
                  child: DuelCard.expandable(
                    // type: duel.status, // TODO: duel
                    type: DuelCardType.activeToVote,
                    model: duel,
                    pressedYes:
                        () => _joinToDuel(
                          answer: 1,
                          duel: duel,
                          duelList: state.duelsList!,
                        ),
                    pressedNo:
                        () => _joinToDuel(
                          answer: 0,
                          duel: duel,
                          duelList: state.duelsList!,
                        ),
                  ),
                );
              },
            );
          }

          return SizedBox();
        },
      ),
    );
  }

  _joinToDuel({
    required int answer,
    required DuelModel duel,
    required List<DuelModel> duelList,
  }) {
    if (duel.yourAnswer != null) return;

    if (context.read<AuthCubit>().state is! AuthSuccessConnectWallet) {
      _showLogInModal();
      return;
    }

    context.read<HomeCubit>().jointToDuel(
      answer: answer,
      duelId: duel.id,
      duelList: duelList,
    );
  }

  _showLogInModal() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder:
          (BuildContext modalContext) => LogInModal(
            onPressed: () {
              context.read<AuthCubit>().connectWallet();
              context.pop();
            },
          ),
    );
  }
}
