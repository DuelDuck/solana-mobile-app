import 'package:duelduck_solana/data/repositories/models/add_duel_repository.dart';
import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_dio/fresh_dio.dart';

import 'package:duelduck_solana/data/api/api_manager.dart';
import 'package:duelduck_solana/data/my_token_storage.dart/my_token_storage.dart';
import 'package:duelduck_solana/data/repositories/solana_repo.dart';

part 'add_duel_state.dart';

class AddDuelCubit extends Cubit<AddDuelState> {
  final SolanaRepository _solanaRepository = SolanaRepository();
  final AddDuelRepository _addDuelRepository = AddDuelRepository();

  final MyTokenStorage<OAuth2Token> myStorageToken = MyTokenStorage();

  late final Fresh<OAuth2Token> tokenRefreshInterceptor;

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

  createDuel(CreateDuelModel createModel) async {
    emit(
      AddDuelLoading(
        createDuelModel: state.createDuelModel,
        isPublishStep: state.isPublishStep,
      ),
    );

    try {
      ApiResponse responseTransaction = await _addDuelRepository
          .getTransactionToCreateDuel(createModel);

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
            model: createModel,
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
}
