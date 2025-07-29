import 'dart:convert';
import 'dart:typed_data';

import 'package:duelduck_solana/utils/app_properties.dart';
import 'package:solana/base58.dart';
import 'package:solana/solana.dart';
import 'package:solana_mobile_client/solana_mobile_client.dart';

class SolanaManager {
  final SolanaClient solanaClient;
  final RpcClient rpcClient;

  SolanaManager()
    : solanaClient = SolanaClient(
        rpcUrl: Uri.parse(AppProperties.solanaMainnetRpcUrl),
        websocketUrl: Uri.parse(AppProperties.solanaMainnetWebsocketUrl),
      ),
      rpcClient = RpcClient(AppProperties.solanaMainnetRpcUrl);

  Future<({Uint8List publicKey, Uint8List signature})?>
  authorizeWallet() async {
    final scenario = await LocalAssociationScenario.create();
    scenario.startActivityForResult(null).ignore();

    final mwaClient = await scenario.start();
    final result = await mwaClient.authorize(
      identityUri: Uri.parse(AppProperties.duelDuckUrl),
      identityName: AppProperties.appName,
      cluster: 'mainnet-beta',
    );

    if (result == null) return null;

    final publicKey = result.publicKey;

    final messageToSign = Uint8List.fromList(
      utf8.encode(base58encode(publicKey)),
    );

    final signResult = await mwaClient.signMessages(
      messages: [messageToSign],
      addresses: [publicKey],
    );

    await scenario.close();

    if (signResult.signedMessages.isEmpty) {
      throw Exception('No signature returned');
    }

    return (
      publicKey: publicKey,
      signature: signResult.signedMessages.first.signatures.first,
    );
  }
}
