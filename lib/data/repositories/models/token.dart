import 'dart:convert';

import 'package:fresh_dio/fresh_dio.dart';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));
String tokenToJson(Token data) => json.encode(data.toJson());
OAuth2Token tokenToOauth2Token(Token data) => Token.toOauth2Token(data);

class Token {
  String accessToken;

  String refreshToken;

  Token({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };

  static toOauth2Token(Token data) => OAuth2Token(
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
      );

  factory Token.fromOAuth2Token(OAuth2Token token) => Token(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken!,
      );
}
