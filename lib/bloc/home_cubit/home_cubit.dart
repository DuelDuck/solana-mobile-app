import 'package:duelduck_solana/data/api/api_manager.dart';
import 'package:duelduck_solana/data/my_token_storage.dart/my_token_storage.dart';
import 'package:duelduck_solana/data/repositories/home_repository.dart';
import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/data/repositories/solana_repo.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_dio/fresh_dio.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final SolanaRepository _solanaRepository = SolanaRepository();
  final HomeRepository _homeRepository = HomeRepository();

  final MyTokenStorage<OAuth2Token> myStorageToken = MyTokenStorage();

  HomeCubit() : super(const HomeInitial());

  _checkAutorization() async {
    final OAuth2Token? token = await myStorageToken.read();
    return token;
  }

  loadAllDuels() async {
    emit(HomeLoading(duelsList: state.duelsList));

    try {
      final isAutorization = await _checkAutorization();

      final ApiResponse<List<DuelModel>?> response = await _homeRepository
          .getAllDuels(isAutorization != null);

      if (response.errorMessage != null) {
        emit(
          HomeErrorGetDuels(
            errorMessage: response.errorMessage!,
            duelsList: state.duelsList,
          ),
        );
        return;
      }

      emit(HomeSuccessGetDuels(duelsList: response.data));
    } catch (e) {
      emit(
        HomeErrorGetDuels(
          errorMessage: e.toString(),
          duelsList: state.duelsList,
        ),
      );
    }
  }

  jointToDuel({
    required int answer,
    required String duelId,
    required List<DuelModel> duelList,
  }) async {
    emit(HomeLoading(duelsList: state.duelsList));

    try {
      ApiResponse responseTransaction = await _homeRepository
          .getTransactionToJoinDuel(answer: answer, duelId: duelId);

      if (responseTransaction.errorMessage != null) {
        emit(
          HomeErrorJoinToDuel(
            errorMessage: responseTransaction.errorMessage!,
            duelsList: state.duelsList,
          ),
        );
        return;
      }

      final String tx = responseTransaction.data;

      String? txHashBase58 = await _solanaRepository
          .signAndSendBase64Transaction(tx);

      if (txHashBase58 == null) {
        emit(
          HomeErrorJoinToDuel(
            errorMessage: "error_join_to_duel".tr(),
            duelsList: state.duelsList,
          ),
        );
        return;
      }

      ApiResponse responseJoinToDuel = await _homeRepository.jointToDuel(
        answer: answer,
        duelId: duelId,
        hash: txHashBase58,
      );

      if (responseJoinToDuel.errorMessage != null) {
        emit(
          HomeErrorJoinToDuel(
            errorMessage: responseJoinToDuel.errorMessage!,
            duelsList: state.duelsList,
          ),
        );
        return;
      }

      duelList =
          duelList.map((duel) {
            if (duel.id == duelId) {
              return duel.copyWith(yourAnswer: answer);
            }
            return duel;
          }).toList();

      emit(HomeSuccessJoinToDuel(duelsList: duelList));
    } catch (e) {
      emit(
        HomeErrorJoinToDuel(
          errorMessage: "error_join_to_duel".tr(),
          duelsList: state.duelsList,
        ),
      );
    }
  }
}
