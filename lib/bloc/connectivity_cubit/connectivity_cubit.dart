import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Stream<List<ConnectivityResult>> connection =
      Connectivity().onConnectivityChanged;

  ConnectivityCubit() : super(const ConnectivityState(isOffline: false)) {
    _subscriptionToInternetConnection();
  }

  _subscriptionToInternetConnection() {
    connection.listen((List<ConnectivityResult> result) {
      bool isOffline = result.contains(ConnectivityResult.none);

      emit(ConnectivityState(isOffline: isOffline));
    });
  }
}
