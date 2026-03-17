// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:convert';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app/storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Token {
  static const AUTH_TOKEN_KEY = "AUTH_TOKEN";

  String access_token;
  String refresh_token;
  bool twoFA;

  Token({
    required this.access_token,
    required this.refresh_token,
    this.twoFA = false,
  });
  factory Token.fromJson(dynamic json) {
    return Token(
        access_token: json['access_token'],
        refresh_token: json['refresh_token']);
  }

  factory Token.empty() {
    return Token(access_token: "", refresh_token: "");
  }
  factory Token.twoFA() {
    return Token(access_token: "", refresh_token: "", twoFA: true);
  }

  factory Token.fromStorage() {
    final tokenString = singleton<Storage>().getString(Token.AUTH_TOKEN_KEY);
    if (tokenString != null) {
      return Token.fromJson(jsonDecode(tokenString));
    }
    return Token.empty();
  }

  // private
  Map<String, dynamic> _decode(dynamic string) {
    return JwtDecoder.decode(string);
  }

  bool _isExpired(dynamic string) {
    return JwtDecoder.isExpired(string);
  }

  DateTime _getExpirationDate(dynamic string) {
    return JwtDecoder.getExpirationDate(string);
  }



  String toJson() {
    return jsonEncode({
      'access_token': access_token,
      'refresh_token': refresh_token,
    });
  }

  // decoding
  Map<String, dynamic> decodeAccessToken() {
    return _decode(access_token);
  }

  Map<String, dynamic> decodeRefreshToken() {
    return _decode(refresh_token);
  }

  // expiry checks
  bool accessTokenIsExpired() {
    return _isExpired(access_token);
  }

  bool refreshTokenIsExpired() {
    return _isExpired(refresh_token);
  }

  // expiry dates
  DateTime accessTokenExpiresAt() {
    return _getExpirationDate(access_token);
  }

  DateTime refreshTokenExpiresAt() {
    return _getExpirationDate(refresh_token);
  }

  // access expiry
  int secondsUntilExpiry() {
    DateTime expiresAt = accessTokenExpiresAt();
    return expiresAt.difference(DateTime.now()).inSeconds;
  }
}
