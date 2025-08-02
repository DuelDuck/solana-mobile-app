import 'package:duelduck_solana/data/api/api_manager.dart';
import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/injector/injector.dart';

class AddDuelRepository {
  final ApiManager _apiManager = getIt.get<ApiManager>();

  Future<ApiResponse<String?>> getTransactionToCreateDuel(
    CreateDuelModel model,
  ) async {
    ApiResponse response = await _apiManager.getTransactionToCreateDuel(model);

    if (response.errorMessage != null) {
      return ApiResponse<String?>(
        errorMessage: response.errorMessage,
        data: null,
      );
    }

    final tx = response.data["tx"];

    return ApiResponse<String>(errorMessage: null, data: tx);
  }

  Future<ApiResponse<CreateDuelModel?>> createDuel({
    required CreateDuelModel model,
    required String txHashBase58,
  }) async {
    ApiResponse response = await _apiManager.createDuel(
      model: model,
      txHashBase58: txHashBase58,
    );

    if (response.errorMessage != null) {
      return ApiResponse<CreateDuelModel?>(
        errorMessage: response.errorMessage,
        data: null,
      );
    }

    final createDuelModel = CreateDuelModel.fromJson(response.data["duel"]);

    return ApiResponse<CreateDuelModel>(
      errorMessage: null,
      data: createDuelModel,
    );
  }
}
