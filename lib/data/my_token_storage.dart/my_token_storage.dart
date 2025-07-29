import 'dart:convert';

import 'package:duelduck_solana/data/secure_storage/secure_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:fresh_dio/fresh_dio.dart';

class MyTokenStorage<T> extends TokenStorage<T> {
  final SecureStorage localStorage = SecureStorage();

  OAuth2Token fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return OAuth2Token(
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
    );
  }

  String toJson(OAuth2Token token) {
    Map json = {
      "accessToken": token.accessToken,
      "refreshToken": token.refreshToken,
    };
    return jsonEncode(json);
  }

  @override
  Future<void> delete() async {
    await localStorage.deleteByKey(SecureStorage.token);
    debugPrint("MyTokenStorage delete");
  }

  @override
  Future<T?> read() async {
    String? jsonToken = await localStorage.get(SecureStorage.token);
    return jsonToken != null ? fromJson(jsonToken) as T : null;
  }

  @override
  Future<void> write(T token) async {
    String json = toJson(token as OAuth2Token);
    debugPrint("MyTokenStorage write $token");
    await localStorage.save(SecureStorage.token, json);
  }
}
