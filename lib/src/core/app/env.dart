// ignore_for_file: constant_identifier_names, library_prefixes

import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:nucleusv2/generated/assets.gen.dart';

enum _Environment { UAT, PROD, DEVLOCAL, DEVAWS }

const _env = _Environment.UAT;

class Env {
  static Future<void> init() async {
    String? envPath;
    switch (_env) {
      case _Environment.UAT:
        envPath = Assets.env.uat;
        break;
      case _Environment.DEVLOCAL:
        envPath = Assets.env.devlocal;
        break;
      case _Environment.DEVAWS:
        envPath = Assets.env.devaws;
        break;
      case _Environment.PROD:
        envPath = Assets.env.prod;
        break;
    }

    await DotEnv.dotenv.load(fileName: envPath);
  }

   static String get appVersion {
    return DotEnv.dotenv.env['APP_VERSION'] ?? '';
  }

  static String get envName {
    return DotEnv.dotenv.env['ENVIRONMENT_NAME'] ?? 'unset';
  }

  static String get storagePrefix {
    return DotEnv.dotenv.env['STORAGE_PREFIX'] ?? 'unset';
  }

  static String get apiBaseUrl {
    return DotEnv.dotenv.env['API_BASE_URL'] ?? '';
  }

  static String get awspukalFolder{
    return DotEnv.dotenv.env['AWS_PUKAL_FOLDER'] ?? '';
  }
  static String get ssrsBaseUrl {
    return DotEnv.dotenv.env['SSRS_BASE_URL'] ?? '';
  }

  static bool get debug {
    return DotEnv.dotenv.env['DEBUG'] == "true";
  }

  static String get debugLoginEmail {
    if (!debug) return "";
    return DotEnv.dotenv.env['DEBUG_LOGIN_EMAIL'] ?? "";
  }

  static String get debugLoginPassword {
    if (!debug) return "";
    return DotEnv.dotenv.env['DEBUG_LOGIN_PASSWORD'] ?? "";
  }
}
