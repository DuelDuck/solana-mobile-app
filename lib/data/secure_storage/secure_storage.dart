import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const String walletAddress = "WalletAddress";
  static const String token = "Token";

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> save(String key, String value) =>
      _storage.write(key: key, value: value);

  Future<String?> get(String key) => _storage.read(key: key);

  Future<Map<String, String>> getAllData() => _storage.readAll();

  Future<void> deleteByKey(String key) => _storage.delete(key: key);

  Future<void> deleteAll() => _storage.deleteAll();
}
