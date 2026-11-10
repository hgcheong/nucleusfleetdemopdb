import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/generated/l10n.dart';
import 'package:nucleusv2/src/core/app/loading_provider.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router_observer.dart';
import 'package:nucleusv2/src/feature/locale/locale_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/feature/theme/theme_provider.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

GlobalKey<State<BottomNavigationBar>> bottomNavigationBar =
    GlobalKey<State<BottomNavigationBar>>();

GlobalKey<NavigatorState> rootNavigatorKey =
    singleton<AppRouter>().navigatorKey;

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class App extends ConsumerWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
 
    final appRouter = singleton<AppRouter>();
    return MaterialApp.router(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      locale: ref.watch(localeProvider),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      // DiBold theme — palette lives in lib/src/feature/theme/db_colors.dart
      theme: DiboldTheme.light(),
      darkTheme: DiboldTheme.dark(),
      //  theme: AppTheme.light(context).themeData,
      //  darkTheme: AppTheme.dark(context).themeData,
      //   theme: AppTheme.light(context).themeData.copyWith(colorScheme:MaterialTheme.lightScheme() ),
      // darkTheme: AppTheme.dark(context).themeData.copyWith(colorScheme:MaterialTheme.darkScheme() ),
      //   darkTheme: AppTheme.dark(context).themeData.copyWith(

      //     inputDecorationTheme: const InputDecorationTheme(

      //     helperStyle: TextStyle(fontSize: defaultFontSize, fontFamily: 'Arial', color: defaultWhite),
      //       labelStyle: TextStyle(fontSize: defaultFontSize, fontFamily: 'Arial', color: defaultWhite),
      //  //     floatingLabelStyle: TextStyle(fontSize: 10.0),
      //     ),
      //     dropdownMenuTheme: const DropdownMenuThemeData(
      //       inputDecorationTheme: InputDecorationTheme(

      //         labelStyle: TextStyle(fontSize: defaultFontSize, fontFamily: 'Arial', color: defaultWhite) ),
      //       textStyle: TextStyle(fontSize: defaultFontSize, fontFamily: 'Arial', color: defaultWhite),

      //     ),
      //     listTileTheme: const ListTileThemeData(
      //       titleTextStyle: defaultTextStyle,
      //       leadingAndTrailingTextStyle: defaultTextStyle,
      //       subtitleTextStyle: defaultTextStyle,
      //     )),
      //   textTheme:
      //     const TextTheme(

      //   bodyLarge:TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.white),
      //   bodyMedium: defaultTextStyle,
      //   bodySmall:defaultTextStyle,
      //   displayLarge: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.white),
      //   displayMedium: defaultTextStyle,
      //  displaySmall: defaultTextStyle,
      //  headlineLarge: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.white),
      //  headlineMedium: defaultTextStyle,
      //  headlineSmall: defaultTextStyle,
      //  labelLarge: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.white),
      //  labelMedium: defaultTextStyle,
      //  labelSmall: defaultTextStyle,
      //  titleLarge: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.white),
      //  titleMedium: defaultTextStyle,
      //  titleSmall: defaultTextStyle,
      // )
      // Theme.of(context).textTheme.apply(
      //     fontSizeFactor: 1.1,
      //     fontSizeDelta: 2.0,
      //   ),
      // ),

      //The Below does not seem to work
      // theme: ThemeData(useMaterial3: true),
      themeMode: ref.watch(themeProvider),
      routeInformationParser:
          appRouter.defaultRouteParser(includePrefixMatches: true),
      routerDelegate: AutoRouterDelegate(
        appRouter,
        navigatorObservers: () => [MyAppRouter()],
      ),
      builder: (context, widget) {
        return Stack(
          children: [
            // ResponsiveWrapper.builder(
            //   BouncingScrollWrapper.builder(context, widget!),
            //   defaultScale: true,
            //   breakpoints: BreakPoints.breakpoints,
            // ),
            ResponsiveBreakpoints.builder(
              child: widget!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
            if (ref.watch(loadingProvider))
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  //   final appRouter = singleton<AppRouter>();
  //   return MaterialApp.router(
  //     restorationScopeId: 'app',
  //     debugShowCheckedModeBanner: false,
  //     scaffoldMessengerKey: rootScaffoldMessengerKey,
  //     locale: ref.watch(localeProvider),
  //     localizationsDelegates: const [
  //       S.delegate,
  //       GlobalMaterialLocalizations.delegate,
  //       GlobalWidgetsLocalizations.delegate,
  //       GlobalCupertinoLocalizations.delegate,
  //     ],
  //   supportedLocales: S.delegate.supportedLocales,
  //  //  theme: AppTheme.light(context).themeData,
  // //   darkTheme: AppTheme.dark(context).themeData,
  //     theme: AppTheme.light(context).themeData.copyWith(
  //   inputDecorationTheme: const InputDecorationTheme(
  //          helperStyle: defaultWhiteTextStyle,
  //         labelStyle: defaultWhiteTextStyle,
  //    //     floatingLabelStyle: TextStyle(fontSize: 10.0),
  //       ),
  //        drawerTheme: const DrawerThemeData(

  //        ),
  //       listTileTheme: const ListTileThemeData(
  //         titleTextStyle: defaultWhiteTextStyle,
  //         leadingAndTrailingTextStyle: defaultWhiteTextStyle,
  //         subtitleTextStyle: defaultWhiteTextStyle,
  //       ),
  //       textTheme:
  //          const TextTheme(
  //       bodyLarge:TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //       bodyMedium:  TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //       bodySmall:TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //       displayLarge: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //       displayMedium: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //      displaySmall: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //      headlineLarge: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //      headlineMedium: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //      headlineSmall: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //      labelLarge: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //      labelMedium: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //      labelSmall: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //      titleLarge: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //      titleMedium: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //      titleSmall: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.black),
  //     )
  //       ),
  //       darkTheme: AppTheme.dark(context).themeData.copyWith(
  //   inputDecorationTheme: const InputDecorationTheme(
  //          helperStyle: defaultTextStyle,
  //         labelStyle: defaultTextStyle,
  //    //     floatingLabelStyle: TextStyle(fontSize: 10.0),
  //       ),
  //       listTileTheme: const ListTileThemeData(
  //         titleTextStyle: defaultTextStyle,
  //         leadingAndTrailingTextStyle: defaultTextStyle,
  //         subtitleTextStyle: defaultTextStyle,
  //       ),
  //       textTheme:
  //         const TextTheme(

  //       bodyLarge:defaultTextStyle,
  //       bodyMedium: defaultTextStyle,
  //       bodySmall:defaultTextStyle,
  //       displayLarge: defaultTextStyle,
  //       displayMedium: defaultTextStyle,
  //      displaySmall: defaultTextStyle,
  //      headlineLarge: defaultTextStyle,
  //      headlineMedium: defaultTextStyle,
  //      headlineSmall: defaultTextStyle,
  //      labelLarge: defaultTextStyle,
  //      labelMedium: defaultTextStyle,
  //      labelSmall: defaultTextStyle,
  //      titleLarge: defaultTextStyle,
  //      titleMedium: defaultTextStyle,
  //      titleSmall: defaultTextStyle,

  //     )
  //       ),
  //   //   darkTheme: AppTheme.dark(context).themeData.copyWith(

  //   //     inputDecorationTheme: const InputDecorationTheme(

  //   //     helperStyle: TextStyle(fontSize: defaultFontSize, fontFamily: 'Arial', color: defaultWhite),
  //   //       labelStyle: TextStyle(fontSize: defaultFontSize, fontFamily: 'Arial', color: defaultWhite),
  //   //  //     floatingLabelStyle: TextStyle(fontSize: 10.0),
  //   //     ),
  //   //     dropdownMenuTheme: const DropdownMenuThemeData(
  //   //       inputDecorationTheme: InputDecorationTheme(

  //   //         labelStyle: TextStyle(fontSize: defaultFontSize, fontFamily: 'Arial', color: defaultWhite) ),
  //   //       textStyle: TextStyle(fontSize: defaultFontSize, fontFamily: 'Arial', color: defaultWhite),

  //   //     ),
  //   //     listTileTheme: const ListTileThemeData(
  //   //       titleTextStyle: defaultTextStyle,
  //   //       leadingAndTrailingTextStyle: defaultTextStyle,
  //   //       subtitleTextStyle: defaultTextStyle,
  //   //     )),
  //     //   textTheme:
  //     //     const TextTheme(

  //     //   bodyLarge:TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.white),
  //     //   bodyMedium: defaultTextStyle,
  //     //   bodySmall:defaultTextStyle,
  //     //   displayLarge: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.white),
  //     //   displayMedium: defaultTextStyle,
  //     //  displaySmall: defaultTextStyle,
  //     //  headlineLarge: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.white),
  //     //  headlineMedium: defaultTextStyle,
  //     //  headlineSmall: defaultTextStyle,
  //     //  labelLarge: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.white),
  //     //  labelMedium: defaultTextStyle,
  //     //  labelSmall: defaultTextStyle,
  //     //  titleLarge: TextStyle(fontSize: 12.0, fontFamily: 'Arial', color: Colors.white),
  //     //  titleMedium: defaultTextStyle,
  //     //  titleSmall: defaultTextStyle,
  //     // )
  //     // Theme.of(context).textTheme.apply(
  //     //     fontSizeFactor: 1.1,
  //     //     fontSizeDelta: 2.0,
  //     //   ),
  //      // ),

  //     //The Below does not seem to work
  //     // theme: ThemeData(useMaterial3: true),
  //     themeMode: ref.watch(themeProvider),
  //     routeInformationParser: appRouter.defaultRouteParser(includePrefixMatches: true),
  //     routerDelegate: AutoRouterDelegate(
  //       appRouter,
  //       navigatorObservers: () => [MyAppRouter()],
  //     ),
  //     builder: (context, widget) {
  //       return Stack(
  //         children: [
  //           // ResponsiveWrapper.builder(
  //           //   BouncingScrollWrapper.builder(context, widget!),
  //           //   defaultScale: true,
  //           //   breakpoints: BreakPoints.breakpoints,
  //           // ),
  //           ResponsiveBreakpoints.builder(
  //             child: widget!,
  //             breakpoints: [
  //               const Breakpoint(start: 0, end: 450, name: MOBILE),
  //               const Breakpoint(start: 451, end: 800, name: TABLET),
  //               const Breakpoint(start: 801, end: 1920, name: DESKTOP),
  //               const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
  //             ],
  //           ),
  //           if (ref.watch(loadingProvider))
  //             Container(
  //               color: Colors.black54,
  //               child: const Center(
  //                 child: CircularProgressIndicator(),
  //               ),
  //             )
  //         ],
  //       );
  //     },
  //   );
  // }
}
