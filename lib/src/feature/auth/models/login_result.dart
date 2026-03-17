import 'package:nucleusv2/src/feature/auth/models/token.dart';

class LoginResult {
  final Token? token;
  final bool twoFa;
  final String? errorMsg;

  const LoginResult({this.token, this.twoFa = false, this.errorMsg});
}
