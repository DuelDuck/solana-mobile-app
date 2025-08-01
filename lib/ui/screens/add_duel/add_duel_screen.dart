import 'package:duelduck_solana/bloc/add_duel_cubit/add_duel_cubit.dart';
import 'package:flutter/material.dart';

import 'package:duelduck_solana/ui/screens/add_duel/widgets/publish_duel.dart';
import 'package:duelduck_solana/ui/screens/add_duel/widgets/duel_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDuelScreen extends StatefulWidget {
  const AddDuelScreen({super.key});

  @override
  State<AddDuelScreen> createState() => _AddDuelScreenState();
}

class _AddDuelScreenState extends State<AddDuelScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddDuelCubit, AddDuelState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child:
                state.isPublishStep && state.createDuelModel != null
                    ? PublishDuel(
                      createDuelModel: state.createDuelModel!,
                      isPublished: state is AddDuelSuccessCreate,
                      isLoading: state is AddDuelLoading,
                      onEdit:
                          () => context.read<AddDuelCubit>().goToCreateStep(),
                      onVote:
                          (model) =>
                              context.read<AddDuelCubit>().createDuel(model),
                      onShare:
                          () => context.read<AddDuelCubit>().copyShareLink(
                            state.createDuelModel!.id,
                          ),
                    )
                    : DuelSettings(
                      createDuelModel: state.createDuelModel,
                      onNextStep:
                          (createDuel) => context
                              .read<AddDuelCubit>()
                              .goToNextStep(createDuel),
                    ),
          ),
        );
      },
    );
  }
}
