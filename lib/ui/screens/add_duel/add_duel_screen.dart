import 'package:duelduck_solana/bloc/add_duel_cubit/add_duel_cubit.dart';
import 'package:duelduck_solana/ui/widgets/custom_toast/custom_toast.dart';
import 'package:easy_localization/easy_localization.dart';
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
    return BlocConsumer<AddDuelCubit, AddDuelState>(
      listener: (context, state) {
        if (state is AddDuelSuccessCreate && state.isShareLinkCopied) {
          CustomToast.success("share_link_copied".tr()).show(context);
        }
      },
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
