import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:solana/base58.dart';

import 'package:duelduck_solana/data/api/api_manager.dart';
import 'package:duelduck_solana/data/my_token_storage.dart/my_token_storage.dart';
import 'package:duelduck_solana/data/repositories/auth_repo.dart';
import 'package:duelduck_solana/data/repositories/models/token.dart';
import 'package:duelduck_solana/data/repositories/solana_repo.dart';
import 'package:duelduck_solana/injector/injector.dart';
import 'package:duelduck_solana/utils/constants.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SolanaRepository _solanaRepository = SolanaRepository();
  final AuthRepository _authRepository = AuthRepository();

  final MyTokenStorage<OAuth2Token> myStorageToken = MyTokenStorage();

  late final Fresh<OAuth2Token> tokenRefreshInterceptor;

  AuthCubit() : super(const AuthInitial()) {
    tokenRefreshInterceptor = _getInterceptor();
    getIt.get<ApiManager>().dio.interceptors.add(tokenRefreshInterceptor);
    _checkAuthStatus();
  }

  Fresh<OAuth2Token> _getInterceptor() => Fresh.oAuth2(
    tokenHeader: (token) => {'Authorization': 'Bearer ${token.accessToken}'},
    tokenStorage: myStorageToken,
    shouldRefresh: (response) => response?.statusCode == 401,
    refreshToken: (OAuth2Token? currentToken, Dio client) async {
      try {
        Token? newToken = await _getRefreshToken(currentToken!.refreshToken!);
        OAuth2Token oAuth2Token = tokenToOauth2Token(newToken!);
        return oAuth2Token;
      } catch (e) {
        emit(AuthErrorConnectWallet("error_refresh_token".tr()));
        logOut();
        throw RevokeTokenException();
      }
    },
  );

  Future<void> logOut() async {
    emit(const AuthLogoutLoading());
    try {
      await tokenRefreshInterceptor.clearToken();
      await _authRepository.clearStorage();
      emit(const AuthNotConnectedWallet());
    } catch (e) {
      emit(AuthLogouError("error_log_out".tr()));
    }
  }

  Future<void> _checkAuthStatus() async {
    try {
      final OAuth2Token? token =
          await myStorageToken.read(); // required for Init MyStorageToken
      tokenRefreshInterceptor.setToken(token); // and save

      final String? walletAddress =
          await _authRepository.getWalletAddressFromStorage();

      if (walletAddress == null) {
        emit(const AuthNotConnectedWallet());
        return;
      }

      emit(AuthSuccessConnectWallet(walletAddress: walletAddress));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Token?> _getRefreshToken(String refreshToken) async {
    ApiResponse<Token?> response = await _authRepository.refreshToken(
      refreshToken,
    );
    return response.data;
  }

  connectWallet() async {
    emit(AuthConnectionWallet());

    try {
      final ({Uint8List publicKey, Uint8List signature})? result =
          await _solanaRepository.connectWallet();
      if (result == null) {
        emit(AuthErrorConnectWallet("error_connect_wallet".tr()));
        return;
      }

      final String pubkeyBase58 = base58encode(
        result.publicKey,
      ); // base 58 for public key
      await _authRepository.saveWalletAddressToStorage(pubkeyBase58);

      final String signaturePubKey = base64Encode(
        result.signature,
      ); // base 64 for signature

      ApiResponse response = await _authRepository.signWithWallet(
        address: pubkeyBase58,
        signedPublicAddress: signaturePubKey,
      );

      if (response.errorMessage != null) {
        emit(AuthErrorConnectWallet("error_connect_wallet".tr()));
        return;
      }

      Token token = response.data[ProjectConstants.tokenData];
      OAuth2Token newToken = tokenToOauth2Token(token);
      await tokenRefreshInterceptor.setToken(newToken);

      // User user = response.data[ProjectConstants.userData];
      // await _authRepository.saveUser(user);

      emit(AuthSuccessConnectWallet(walletAddress: pubkeyBase58));
    } catch (e) {
      emit(AuthErrorConnectWallet("error_connect_wallet".tr()));
    }
  }
}
