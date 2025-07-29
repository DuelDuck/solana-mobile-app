part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthConnectionWallet extends AuthState {
  const AuthConnectionWallet();
}

class AuthSuccessConnectWallet extends AuthState {
  final String walletAddress;
  const AuthSuccessConnectWallet({required this.walletAddress});
}

class AuthErrorConnectWallet extends AuthState {
  final String errorMessage;
  const AuthErrorConnectWallet(this.errorMessage);
}

class AuthNotConnectedWallet extends AuthState {
  const AuthNotConnectedWallet();
}

class AuthLogoutLoading extends AuthState {
  const AuthLogoutLoading();
}

class AuthLogouError extends AuthState {
  final String error;
  const AuthLogouError(this.error);
}
