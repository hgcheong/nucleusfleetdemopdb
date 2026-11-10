import 'dart:io';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:nucleusv2/src/core/app/env.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/localization/string_hardcoded.dart';
import 'src/app.dart';
import 'src/exceptions/async_error_logger.dart';
import 'src/exceptions/error_logger.dart';

class MyHttpOverrides extends HttpOverrides {
  // @override
  // HttpClient createHttpClient(SecurityContext? context) {
  //   return super.createHttpClient(context)
  //     ..badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => true;
  // }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HttpOverrides.global = MyHttpOverrides();
  await Env.init();

  //INitiallially it was  setPathUrlStrategy()
  //but to completely disable the navigate back we use the below to set it to null
  //setUrlStrategy(null);

  //setPathUrlStrategy();
  usePathUrlStrategy();
  await initSingletons();

  final container = ProviderContainer(
    overrides: [],
    observers: [AsyncErrorLogger()],
  );

  final errorLogger = container.read(errorLoggerProvider);
  registerErrorHandlers(errorLogger);
  runApp(RootRestorationScope(
    restorationId: "root",
    child: UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  ));
}

void registerErrorHandlers(ErrorLogger errorLogger) {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    // FlutterError.presentError(details);
    errorLogger.logError(details.exception, details.stack);
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    errorLogger.logError(error, stack);
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: DbColors.primary700,
        title: Text('An error occurred'.hardcoded),
      ),
      body: SingleChildScrollView(child: SelectableText(details.toString())),
    );
  };
}
