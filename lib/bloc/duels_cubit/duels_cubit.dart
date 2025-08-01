import 'package:duelduck_solana/data/api/api_manager.dart';
import 'package:duelduck_solana/data/repositories/auth_repo.dart';
import 'package:duelduck_solana/data/repositories/duels_repository.dart';
import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/data/repositories/models/user.dart';
import 'package:duelduck_solana/injector/injector.dart';
import 'package:duelduck_solana/utils/utils.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'duels_state.dart';

class DuelsCubit extends Cubit<DuelsState> {
  final DuelsRepository _duelsRepository = DuelsRepository();
  final AuthRepository _authRepository = AuthRepository();

  DuelsCubit() : super(const DuelsInitial());

  loadAllMyDuels() async {
    emit(
      DuelsLoading(
        votedDuelsList: state.votedDuelsList,
        createdDuelsList: state.createdDuelsList,
        pendingDuelsList: state.pendingDuelsList,
        doneDuelsList: state.doneDuelsList,
      ),
    );

    try {
      final ApiResponse<List<DuelModel>?> response =
          await _duelsRepository.getAllMyDuels();

      if (response.errorMessage != null) {
        emit(
          DuelsErrorGetList(
            errorMessage: response.errorMessage!,
            votedDuelsList: state.votedDuelsList,
            createdDuelsList: state.createdDuelsList,
            pendingDuelsList: state.pendingDuelsList,
            doneDuelsList: state.doneDuelsList,
          ),
        );
        return;
      }

      final List<DuelModel> allMyDuels = response.data ?? [];

      List<DuelModel> votedDuels = [];
      List<DuelModel> createdDuels = [];
      List<DuelModel> pendingDuels = [];
      List<DuelModel> doneDuels = [];

      if (allMyDuels.isNotEmpty) {
        final User? user =
            getIt.isRegistered<User>()
                ? getIt.get<User>()
                : await _authRepository.getUserFromStorage();

        for (final duel in allMyDuels) {
          if (user?.id == duel.ownerId &&
              duel.status == 4 &&
              Utils.isDateInPast(duel.deadline)) {
            pendingDuels.add(duel.copyWith(duelCardType: DuelCardType.pending));
            continue;
          } else if (user?.id == duel.ownerId && duel.status == 4) {
            createdDuels.add(
              duel.copyWith(duelCardType: DuelCardType.waitingForResult),
            );
            continue;
          }

          if (user?.id != duel.ownerId && duel.status == 4) {
            votedDuels.add(
              duel.copyWith(duelCardType: DuelCardType.waitingForResult),
            );
            continue;
          }

          if (duel.status == 5) {
            doneDuels.add(duel.copyWith(duelCardType: DuelCardType.done));
            continue;
          }

          if (duel.status == 2 || duel.status == 3) {
            doneDuels.add(duel.copyWith(duelCardType: DuelCardType.cancelled));
            continue;
          }

          if (duel.status == 6) {
            doneDuels.add(duel.copyWith(duelCardType: DuelCardType.refunded));
            continue;
          }

          doneDuels.add(duel);
        }
      }

      emit(
        DuelsSuccessGetList(
          votedDuelsList: votedDuels,
          createdDuelsList: createdDuels,
          pendingDuelsList: pendingDuels,
          doneDuelsList: doneDuels,
        ),
      );
    } catch (e) {
      emit(
        DuelsErrorGetList(
          errorMessage: e.toString(),
          votedDuelsList: state.votedDuelsList,
          createdDuelsList: state.createdDuelsList,
          pendingDuelsList: state.pendingDuelsList,
          doneDuelsList: state.doneDuelsList,
        ),
      );
    }
  }

  resolveDuel({required int answer, required String duelId}) async {
    emit(
      DuelsLoading(
        votedDuelsList: state.votedDuelsList,
        createdDuelsList: state.createdDuelsList,
        pendingDuelsList: state.pendingDuelsList,
        doneDuelsList: state.doneDuelsList,
      ),
    );
    try {
      ApiResponse response = await _duelsRepository.resolveDuel(
        answer: answer,
        duelId: duelId,
      );

      if (response.errorMessage != null) {
        emit(
          DuelsErrorResolve(
            errorMessage: response.errorMessage!,
            votedDuelsList: state.votedDuelsList,
            createdDuelsList: state.createdDuelsList,
            pendingDuelsList: state.pendingDuelsList,
            doneDuelsList: state.doneDuelsList,
          ),
        );
        return;
      }

      final updatedPendingDuelsList =
          state.pendingDuelsList.map((duel) {
            if (duel.id == duelId) {
              return duel.copyWith(finalResult: answer);
            }
            return duel;
          }).toList();

      emit(
        DuelsSuccessResolve(
          votedDuelsList: state.votedDuelsList,
          createdDuelsList: state.createdDuelsList,
          pendingDuelsList: updatedPendingDuelsList,
          doneDuelsList: state.doneDuelsList,
        ),
      );
    } catch (e) {
      emit(
        DuelsErrorResolve(
          errorMessage: e.toString(),
          votedDuelsList: state.votedDuelsList,
          createdDuelsList: state.createdDuelsList,
          pendingDuelsList: state.pendingDuelsList,
          doneDuelsList: state.doneDuelsList,
        ),
      );
    }
  }
}
