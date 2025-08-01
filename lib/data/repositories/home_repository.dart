import 'package:duelduck_solana/data/api/api_manager.dart';
import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/injector/injector.dart';

class HomeRepository {
  final ApiManager _apiManager = getIt.get<ApiManager>();

  Future<ApiResponse<List<DuelModel>?>> getAllDuels(bool isAutorization) async {
    ApiResponse response =
        isAutorization
            ? await _apiManager.getAllWithJoinedDuels()
            : await _apiManager.getAllDuels();

    if (response.errorMessage != null) {
      return ApiResponse<List<DuelModel>?>(
        errorMessage: response.errorMessage,
        data: null,
      );
    }

    final List<DuelModel> duels =
        (response.data as List)
            .map((item) => DuelModel.fromJson(item))
            .toList();

    return ApiResponse<List<DuelModel>?>(errorMessage: null, data: duels);
  }

  Future<ApiResponse<String?>> getTransactionToJoinDuel({
    required int answer,
    required String duelId,
  }) async {
    ApiResponse response = await _apiManager.getTransactionToJoinDuel(
      answer: answer,
      duelId: duelId,
    );

    if (response.errorMessage != null) {
      return ApiResponse<String?>(
        errorMessage: response.errorMessage,
        data: null,
      );
    }

    final tx = response.data["tx"];

    return ApiResponse<String>(errorMessage: null, data: tx);
  }

  Future<ApiResponse> jointToDuel({
    required int answer,
    required String duelId,
    required String hash,
  }) async {
    ApiResponse response = await _apiManager.joinToDuel(
      answer: answer,
      duelId: duelId,
      hash: hash,
    );

    if (response.errorMessage != null) {
      return ApiResponse(errorMessage: response.errorMessage, data: null);
    }

    return ApiResponse(errorMessage: null, data: response.data);
  }
}
