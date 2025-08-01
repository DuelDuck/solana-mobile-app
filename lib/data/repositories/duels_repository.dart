import 'package:duelduck_solana/data/api/api_manager.dart';
import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/injector/injector.dart';

class DuelsRepository {
  final ApiManager _apiManager = getIt.get<ApiManager>();

  Future<ApiResponse<List<DuelModel>?>> getAllMyDuels() async {
    ApiResponse response = await _apiManager.getAllMyDuels();

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

  Future<ApiResponse> resolveDuel({
    required int answer,
    required String duelId,
  }) async {
    ApiResponse response = await _apiManager.resolveDuel(
      answer: answer,
      duelId: duelId,
    );

    if (response.errorMessage != null) {
      return ApiResponse(errorMessage: response.errorMessage, data: null);
    }

    return ApiResponse(data: response.data["tx_hashes"], errorMessage: null);
  }
}
