import 'package:duelduck_solana/data/api/api_manager.dart';
import 'package:duelduck_solana/data/repositories/models/token.dart';
import 'package:duelduck_solana/data/repositories/models/user.dart';
import 'package:duelduck_solana/data/secure_storage/secure_storage.dart';
import 'package:duelduck_solana/injector/injector.dart';
import 'package:duelduck_solana/utils/constants.dart';

class AuthRepository {
  final ApiManager _apiManager = getIt.get<ApiManager>();
  final SecureStorage _secureStorage = SecureStorage();

  Future saveWalletAddressToStorage(String walletAddress) async {
    await _secureStorage.save(SecureStorage.walletAddress, walletAddress);
  }

  Future<String?> getWalletAddressFromStorage() async {
    String? walletAddress = await _secureStorage.get(
      SecureStorage.walletAddress,
    );

    return walletAddress;
  }

  Future clearStorage() async {
    await _secureStorage.deleteAll();
  }

  Future<ApiResponse> signWithWallet({
    required String address,
    required String signedPublicAddress,
  }) async {
    ApiResponse response = await _apiManager.signWithWallet(
      address: address,
      signedPublicAddress: signedPublicAddress,
    );

    if (response.errorMessage != null) {
      return ApiResponse(data: null, errorMessage: response.errorMessage);
    }

    return ApiResponse(
      data: {
        ProjectConstants.tokenData: Token.fromJson(
          response.data[ProjectConstants.tokenData],
        ),
        ProjectConstants.userData: User.fromJson(
          response.data[ProjectConstants.userData],
        ),
      },
      errorMessage: null,
    );
  }

  Future saveUser(User user) async {
    getIt.registerSingleton<User>(user);
  }

  Future<ApiResponse<Token?>> refreshToken(String refreshToken) async {
    ApiResponse response = await _apiManager.refreshToken(refreshToken);
    if (response.errorMessage != null) {
      return ApiResponse<Token?>(
        errorMessage: response.errorMessage,
        data: null,
      );
    }

    return ApiResponse<Token>(
      errorMessage: null,
      data: Token.fromJson(response.data[ProjectConstants.tokenData]),
    );
  }
}
