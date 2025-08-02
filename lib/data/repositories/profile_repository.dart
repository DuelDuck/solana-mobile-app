import 'package:duelduck_solana/data/api/api_manager.dart';
import 'package:duelduck_solana/data/repositories/models/leaderboard.dart';
import 'package:duelduck_solana/data/repositories/models/user.dart';
import 'package:duelduck_solana/injector/injector.dart';

class ProfileRepository {
  final ApiManager _apiManager = getIt.get<ApiManager>();

  Future<ApiResponse<User?>> getUser() async {
    ApiResponse response = await _apiManager.getUser();

    if (response.errorMessage != null) {
      return ApiResponse<User?>(
        errorMessage: response.errorMessage,
        data: null,
      );
    }

    final user = User.fromJson(response.data);

    return ApiResponse(data: user, errorMessage: null);
  }

  Future<ApiResponse<Leaderboard?>> getLeaderboard() async {
    ApiResponse response = await _apiManager.getUserLeaderboardRank();

    if (response.errorMessage != null) {
      return ApiResponse<Leaderboard?>(
        errorMessage: response.errorMessage,
        data: null,
      );
    }

    final leaderboard =
        response.data != null
            ? Leaderboard.fromJson(response.data)
            : Leaderboard.empty();

    return ApiResponse(data: leaderboard, errorMessage: null);
  }

  Future<ApiResponse> changeUserName(String newName) async {
    ApiResponse response = await _apiManager.changeUserName(newName);

    if (response.errorMessage != null) {
      return ApiResponse(errorMessage: response.errorMessage, data: null);
    }

    return ApiResponse(data: response.data, errorMessage: null);
  }
}
