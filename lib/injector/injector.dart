import 'package:dio/dio.dart';
import 'package:duelduck_solana/data/api/api_manager.dart';
import 'package:duelduck_solana/data/solana/solana_manager.dart';
import 'package:duelduck_solana/utils/app_properties.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class Injector {
  register() {
    getIt.allowReassignment = true;
    getIt.registerSingleton<ApiManager>(ApiManager(dio: _createDio()));
    getIt.registerSingleton<SolanaManager>(SolanaManager());
  }

  Dio _createDio() => Dio(
    BaseOptions(
      baseUrl: AppProperties.domain,
      receiveTimeout: Duration(minutes: 3),
      connectTimeout: Duration(minutes: 3),
    ),
  );
}
