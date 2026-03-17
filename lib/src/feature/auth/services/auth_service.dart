import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:nucleusv2/src/feature/auth/models/login_result.dart';
import 'package:nucleusv2/src/feature/auth/models/token.dart';
import 'package:nucleusv2/src/feature/user/models/user.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class AuthService extends ApiService {
  Future<LoginResult?> 
  login({
    required String email,
    String? otpCode,
    String? password,
  }) async {
    if (otpCode == null && password == null) {
      return null;
    }

    // final Map<String, dynamic> _params = {
    //   'email': email,
    //   ...otpCode != null ? {'otp': otpCode} : {},
    //   ...password != null ? {'password': password} : {},
    // };
   // String deviceData = "Build151";
    // final deviceInfoPlugin = singleton<DeviceInfoPlugin>();
    // if (kIsWeb) {
    //   var webinfo = await deviceInfoPlugin.webBrowserInfo;
    //   deviceData = webinfo.userAgent.toString();
      
    // } else {
    //   if (Platform.isAndroid) {
    //     var androidinfo = await deviceInfoPlugin.androidInfo;
    //     deviceData = androidinfo.model.toString();
    //   } else if (Platform.isIOS) {
    //     var iosinfo = await deviceInfoPlugin.iosInfo;
    //     deviceData = iosinfo.utsname.machine.toString();
    //   }
    //   // } else if (Platform.isLinux) {
    //   //   deviceData = <String, dynamic>{
    //   //     'ApplVer': await deviceInfoPlugin.linuxInfo
    //   //   };
    //   // } else if (Platform.isMacOS) {
    //   //   deviceData = <String, dynamic>{
    //   //     'ApplVer': await deviceInfoPlugin.macOsInfo
    //   //   };
    //   // } else if (Platform.isWindows) {
    //   //   deviceData = <String, dynamic>{
    //   //     'ApplVer': await deviceInfoPlugin.windowsInfo
    //   //   };
    //   // }
    // }
    // var parser = RSAKeyParser();
    // RSAPublicKey publicKey = parser.parse(
    //         "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt4k2LaAwRP7Yp+OwyQMdyHsK8IzOEm72sC+4wQuEp3KZNDuunw0EO5kUQafNBFDmzPAxgpS5UiuTrYdI1jtreha0vxEfEOKOrm36LVzg0NVPiovL9aIzHJOo3zZpjIDlUmYIt3TehwFErut4HbjbxhlcF+fyWqyQM+dRWochUje+C3XmqhEpsxzE9pw5lrVbb8aYLHWPqoQl9kS9kEPHBYVb531gGd9ic7OqUqVTJSL4wY9tEO6oBAleiXmDVAZ0mg+/oiKhhQBe4q+pqLoKrbXJIjq3hImBSDtjazNTK/EA7aNvm5Ssu0DFWu00zDwxOmTE8BfcVLcwv8p5vclQ1wIDAQAB\n-----END PUBLIC KEY-----")
    //     as RSAPublicKey;
    // Encrypter encrypter;
    // Encrypted encrypted;
    // encrypter = Encrypter(
    //   RSA(publicKey: publicKey, encoding: RSAEncoding.OAEP),
    // );
    // encrypted = encrypter.encrypt(password.toString());
    // password = encrypted.base64;
    final Map<String, dynamic> params = {
      'UserId': email,
      'SignIn': email,
      ...{'PwdHash': getRSAEncryptedPWD(password.toString())},
      'UserType': 'I',
      'ReqType': 'LOGIN',
      //  'ApplName': kIsWeb ? 'Web' : 'App|${appl.appName}|$deviceData',
      // 'ApplVer': '${appl.version}|${appl.buildNumber}'
      'ApplName': 'Web10618',
      'ApplVer': '1.0'
    };

    try {
      final response =
          await postHttp('/auth/token', params: params, auth: false);
      if (response.keys.contains("is_2fa_enabled") &&
          response['is_2fa_enabled'] == true) {
        return const LoginResult(twoFa: true);
      }

      final token = Token.fromJson(response);

      return LoginResult(token: token);
    } catch (e) {
      return null;
    }
  }

  Future<bool> validateLoginCredentials({
    required String email,
    required String password,
  }) async {
    final Map<String, dynamic> params = {
      'email': email,
      'password': password,
    };

    try {
      await postHttp('/auth/token', params: params, auth: false);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User?> register({
    required String email,
    required String username,
    required String password,
    required phoneNumber,
    required name,
  }) async {
    final user = User.register(
      email: email,
      username: username,
      password: password,
      phoneNumber: phoneNumber,
      name: name,
    );

    try {
      final data = await postHttp('/auth/register',
          params: user.serializeForRegister(), auth: false);

      return User.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  Future<Token?> refresh(String refreshToken, String oldAuthToken) async {
    final params = {
      'refresh_token': refreshToken,
      'access_token': oldAuthToken
    };

    try {
      final response =
          await postHttp('/auth/refresh', params: params, auth: false);
      return Token.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<bool> emailAvailable(String email) async {
    try {
      final data = await postHttp('/auth/email/validate',
          params: {'email': email}, auth: false);
      return data['is_available'] ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> usernameAvailable(String username) async {
    return true; //TEMP since current BP does not have usernames yet
    // try {
    //  final data = await postHttp('/auth/username/validate',
    //       params: {'username': username}, auth: false);
    //   return data['is_available'] ?? false;
    // } catch (e) {
    //   return false;
    // }
  }

  Future<bool> requestPasswordReset({String? email, String? username}) async {
    if (email == null && username == null) {
      return false;
    }

    try {
      final params = email != null ? {'email': email} : {'username': username};
      await postHttp('/auth/password-reset', params: params, auth: false);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> completePasswordReset({
    required String password,
    required String token,
  }) async {
    return true;
  }

  Future<bool> changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      // final params = {
      //   'old_password': oldPassword,
      //   'new_password': newPassword,
      // };

      final params = {
        "ApplName": "Nucleus",
        "ApplVer": "1",
        "OldPwdHash": getRSAEncryptedPWD(oldPassword),
        "PwdHash": getRSAEncryptedPWD(newPassword) ,
        "ReqType": "Login",
        "SignIn": email,
        "UserType": "I"
      };
//  "SignIn": email,
// //"UserId": email,
// "OldPwdHash": oldPassword,
//   "PwdHash": newPassword,
//   "Email":email,
//     "Mobile": "0133333333",
//   "ReqType": "Login",
//   "UserType": "I",
//   "ApplVer":"1",
//   "ApplName": "Nucleus",
//   "Sts": "A",
//   //"SrcIpAddr":null
// };

     var res = await postHttp('/sp/ApiSignInPwdHashSave/queryasync', params: params);

      if(res['message']['msgSeverity'] == 1){
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changeEmail({
    required String email,
  }) async {
    try {
      final params = {
        'email': email,
      };

      await postHttp('/auth/email/change', params: params);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> completeEmailChange({
    required String token,
  }) async {
    final params = {
      'token': token,
    };
    try {
      await postHttp('/auth/email/change/complete/', params: params);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePhoneNumber({
    required String phoneNumber,
  }) async {
    try {
      final params = {
        'phone_number': phoneNumber,
      };

      await postHttp('/auth/phone-number/change', params: params);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Future<bool> completePhoneNumberChange({
  //   required String token,
  // }) async {
  //   final params = {
  //     'token': token,
  //   };
  //   try {
  //     await postHttp('/auth/phone-number/change/complete/', params: params);
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
