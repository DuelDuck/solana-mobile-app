import 'package:duelduck_solana/data/repositories/models/add_duel_repository.dart';
import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/utils/app_properties.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:duelduck_solana/data/api/api_manager.dart';
import 'package:duelduck_solana/data/repositories/solana_repo.dart';

part 'add_duel_state.dart';

class AddDuelCubit extends Cubit<AddDuelState> {
  final SolanaRepository _solanaRepository = SolanaRepository();
  final AddDuelRepository _addDuelRepository = AddDuelRepository();

  AddDuelCubit() : super(const AddDuelInitial());

  goToCreateStep() {
    emit(
      AddDuelCreateStep(
        createDuelModel: state.createDuelModel,
        isPublishStep: false,
      ),
    );
  }

  goToNextStep(CreateDuelModel newCreateDuel) {
    emit(
      AddDuelPublishStep(createDuelModel: newCreateDuel, isPublishStep: true),
    );
  }

  createDuel(CreateDuelModel newCreateDuel) async {
    emit(
      AddDuelLoading(
        createDuelModel: state.createDuelModel,
        isPublishStep: state.isPublishStep,
      ),
    );

    try {
      ApiResponse responseTransaction = await _addDuelRepository
          .getTransactionToCreateDuel(newCreateDuel);

      if (responseTransaction.errorMessage != null) {
        emit(
          AddDuelErrorSignTransaction(
            errorMessage: responseTransaction.errorMessage!,
            createDuelModel: state.createDuelModel,
            isPublishStep: state.isPublishStep,
          ),
        );
        return;
      }

      final String tx = responseTransaction.data;

      String? txHashBase58 = await _solanaRepository
          .signAndSendBase64Transaction(tx);

      if (txHashBase58 == null) {
        emit(
          AddDuelErrorSignTransaction(
            errorMessage: "error_sign_transaction".tr(),
            createDuelModel: state.createDuelModel,
            isPublishStep: state.isPublishStep,
          ),
        );
        return;
      }

      ApiResponse<CreateDuelModel?> responseCreateDuel =
          await _addDuelRepository.createDuel(
            model: newCreateDuel,
            txHashBase58: txHashBase58,
          );

      if (responseCreateDuel.errorMessage != null) {
        emit(
          AddDuelErrorSignTransaction(
            errorMessage: responseCreateDuel.errorMessage!,
            createDuelModel: state.createDuelModel,
            isPublishStep: state.isPublishStep,
          ),
        );
        return;
      }

      emit(
        AddDuelSuccessCreate(
          isShareLinkCopied: false,
          createDuelModel: responseCreateDuel.data,
          isPublishStep: state.isPublishStep,
        ),
      );
    } catch (e) {
      emit(
        AddDuelErrorSignTransaction(
          errorMessage: "error_sign_transaction".tr(),
          createDuelModel: state.createDuelModel,
          isPublishStep: state.isPublishStep,
        ),
      );
    }
  }

  copyShareLink(String? duelId) {
    if (duelId == null) return;

    final String link = AppProperties.shareUrl + duelId;
    Clipboard.setData(ClipboardData(text: link));

    emit(
      AddDuelSuccessCreate(
        isShareLinkCopied: true,
        createDuelModel: state.createDuelModel,
        isPublishStep: state.isPublishStep,
      ),
    );
  }
}
