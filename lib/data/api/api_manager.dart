import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:duelduck_solana/data/repositories/models/duel.dart';
import 'package:duelduck_solana/utils/app_properties.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ApiManager {
  final Dio dio;
  ApiManager({required this.dio});

  static Future<bool> hasNetwork() async {
    try {
      List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      bool isOffline = connectivityResult.contains(ConnectivityResult.none);
      return !isOffline;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<ApiResponse> signWithWallet({
    required String address,
    required String signedPublicAddress,
  }) async {
    try {
      Future<Response> request = dio.post(
        "/auth/sign-in-wallet",
        data: {"address": address, "secret": signedPublicAddress},
      );
      return await ApiResponse.executeResponse(request: request);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(data: null, errorMessage: "error_connect_wallet".tr());
    }
  }

  Future<ApiResponse> refreshToken(String refreshToken) async {
    try {
      Future<Response> request = Dio(
        BaseOptions(baseUrl: AppProperties.domain),
      ).post(
        "/auth/refresh",
        options: Options(headers: {"Authorization": "Bearer $refreshToken"}),
      );
      return await ApiResponse.executeResponse(request: request);
    } catch (e) {
      return ApiResponse(errorMessage: "error_refresh_token".tr(), data: null);
    }
  }

  Future<ApiResponse> getUser() async {
    try {
      Future<Response> request = dio.get("/user");
      return await ApiResponse.executeResponse(request: request);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(data: null, errorMessage: "error_connect_wallet".tr());
    }
  }

  Future<ApiResponse> getTransactionToCreateDuel(CreateDuelModel model) async {
    try {
      print(model.toJson());
      Future<Response> request = dio.post(
        "/crypto-duel/app/sign-tx",
        data: model.toJson(),
      );
      return await ApiResponse.executeResponse(request: request);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(
        data: null,
        errorMessage: "error_sign_transaction".tr(),
      );
    }
  }

  Future<ApiResponse> createDuel({
    required CreateDuelModel model,
    required String txHashBase58,
  }) async {
    try {
      Future<Response> request = dio.post(
        "/crypto-duel/app",
        data: {"duel": model.toJson(), "tx_hash": txHashBase58},
      );
      return await ApiResponse.executeResponse(request: request);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(
        data: null,
        errorMessage: "error_sign_transaction".tr(),
      );
    }
  }
}

class ApiResponse<T> {
  final String? errorMessage;
  final T data;
  ApiResponse({required this.data, required this.errorMessage});

  @override
  String toString() => "ApiResponse(errorMessage: $errorMessage, data: $data)";

  static Future<ApiResponse> executeResponse({
    required Future<Response> request,
  }) async {
    try {
      bool hasNetwork = await ApiManager.hasNetwork();
      if (!hasNetwork) {
        /// The user does not have an Internet connection
        return ApiResponse(
          errorMessage: "error_no_connection_internet".tr(),
          data: null,
        );
      }

      Response response = await request;
      String? message = response.data is Map ? response.data["message"] : null;

      return ApiResponse(errorMessage: message, data: response.data);
    } on DioException catch (e) {
      debugPrint(
        "DioException ${e.response?.statusCode.toString()} ${e.response}  ${e.requestOptions.path}",
      );
      String? message = e.response?.data;
      if (e.response?.statusCode == 500) {
        return ApiResponse(
          errorMessage: message ?? "error_internal_server_error".tr(),
          data: null,
        );
      }
      if (e.response?.statusCode == 401) {
        return ApiResponse(
          errorMessage: message ?? "error_unauthorized".tr(),
          data: null,
        );
      }
      if (e.response?.statusCode == 400) {
        return ApiResponse(
          errorMessage: message ?? "error_bad_request".tr(),
          data: null,
        );
      }

      return ApiResponse(
        errorMessage: message ?? "error_from_backend".tr(),
        data: null,
      );
    }
  }
}
