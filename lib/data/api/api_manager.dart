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
      return ApiResponse(data: null, errorMessage: "error_get_user".tr());
    }
  }

  Future<ApiResponse> changeUserName(String newName) async {
    try {
      Future<Response> request = dio.put(
        "/user/username",
        data: {"username": newName},
      );
      return await ApiResponse.executeResponse(request: request);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(
        data: null,
        errorMessage: "error_change_user_name".tr(),
      );
    }
  }

  Future<ApiResponse> getTransactionToCreateDuel(CreateDuelModel model) async {
    try {
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

  // for user is not authorized
  Future<ApiResponse> getAllDuels() async {
    try {
      Future<Response> request = dio.get(
        "/duel/all",
        queryParameters: {
          "opts.filters[0].column": "is_app_duel",
          "opts.filters[0].value": "true",
          "opts.filters[0].operator": "is",
          "opts.filters[0].where_or": "false",
        },
      );
      return await ApiResponse.executeResponse(request: request);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(data: null, errorMessage: "error_get_duels".tr());
    }
  }

  // for authorized
  Future<ApiResponse> getAllWithJoinedDuels() async {
    try {
      final deadline = DateTime.now();

      Future<Response> request = dio.get(
        "/duel/all-with-joined",
        queryParameters: {
          'opts.pagination.page_size': 20,
          'opts.pagination.page_num': 1,
          'opts.order.order_by': 'players_count',
          'opts.order.order_type': 'desc',

          'opts.filters[0].column': 'payment_type',
          'opts.filters[0].value': 1,
          'opts.filters[0].operator': '=',
          'opts.filters[0].where_or': false,

          'opts.filters[1].column': 'is_app_duel',
          'opts.filters[1].value': true,
          'opts.filters[1].operator': 'is',
          'opts.filters[1].where_or': false,

          'opts.filters[2].column': 'status',
          'opts.filters[2].value': 4,
          'opts.filters[2].operator': '=',
          'opts.filters[2].where_or': false,

          'opts.filters[3].column': 'p.user_id',
          'opts.filters[3].value': null,
          'opts.filters[3].operator': 'is',
          'opts.filters[3].where_or': false,

          'opts.filters[4].column': 'deadline',
          'opts.filters[4].value': '${deadline.toIso8601String()}Z',
          'opts.filters[4].operator': '>',
          'opts.filters[4].where_or': false,
        },
      );
      return await ApiResponse.executeResponse(request: request);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(data: null, errorMessage: "error_get_duels".tr());
    }
  }

  Future<ApiResponse> getTransactionToJoinDuel({
    required int answer,
    required String duelId,
  }) async {
    try {
      Future<Response> request = dio.post(
        "/crypto-duel/app/join/sign-tx",
        data: {"answer": answer, "duel_id": duelId},
      );
      return await ApiResponse.executeResponse(request: request);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(
        data: null,
        errorMessage: "error_get_transaction_to_join_duel".tr(),
      );
    }
  }

  Future<ApiResponse> joinToDuel({
    required int answer,
    required String duelId,
    required String hash,
  }) async {
    try {
      Future<Response> request = dio.post(
        "/crypto-duel/app/join",
        data: {
          "duel": {"answer": answer, "duel_id": duelId},
          "tx_hash": hash,
        },
      );
      return await ApiResponse.executeResponse(request: request);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(data: null, errorMessage: "error_join_to_duel".tr());
    }
  }

  Future<ApiResponse> getAllMyDuels() async {
    try {
      Future<Response> request = dio.get(
        "/duel/participating",
        queryParameters: {
          'opts.pagination.page_size': 20,
          'opts.pagination.page_num': 1,
          'opts.order.order_by': 'created_at',
          'opts.order.order_type': 'desc',
        },
      );
      return await ApiResponse.executeResponse(request: request);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(data: null, errorMessage: "error_get_my_duels".tr());
    }
  }

  Future<ApiResponse> resolveDuel({
    required int answer,
    required String duelId,
  }) async {
    try {
      Future<Response> request = dio.post(
        "/crypto-duel/app/resolve",
        data: {"answer": answer, "duel_id": duelId},
      );
      return await ApiResponse.executeResponse(request: request);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(data: null, errorMessage: "error_resolve_duel".tr());
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
