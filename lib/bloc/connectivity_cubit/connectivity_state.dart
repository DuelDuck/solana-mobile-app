part of 'connectivity_cubit.dart';

// This should be the only state class for this cubit. No need to create [ConnectivityInitial],
// because it's gonna be the same as [ConnectivityState], which will create boilerplate code in this case.
final class ConnectivityState {
  final bool isOffline;

  const ConnectivityState({required this.isOffline});
}
