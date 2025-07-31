import 'dart:typed_data';

import 'package:duelduck_solana/data/solana/solana_manager.dart';
import 'package:duelduck_solana/injector/injector.dart';

class SolanaRepository {
  final SolanaManager _manager = getIt.get<SolanaManager>();

  Future<({Uint8List publicKey, Uint8List signature})?> connectWallet() async {
    return await _manager.authorizeWallet();
  }

  Future<String?> signAndSendBase64Transaction(String base64Tx) async {
    return await _manager.signAndSendBase64Transaction(base64Tx);
  }
}
