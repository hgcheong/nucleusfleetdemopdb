// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';

// const _primaryColor = Colors.blue;
//
const _primaryColor = DbColors.primary; // DiBold (was Color.fromARGB(255, 70, 74, 83))
//const _secondaryColor = Colors.orange;
const _secondaryColor = DbColors.primary700; // DiBold (was Colors.green)
const _successColor = DbColors.success;
const _infoColor = DbColors.info;
const _warningColor = DbColors.warning;
const _dangerColor = DbColors.danger;

const _textColorDark = DbColors.slate900;
const _textColorLight = Color(0xFFf6f6f6);

enum AppColorVariant {
  Primary,
  Secondary,
  // Info,
  // Success,
  // Warning,
  Danger,
}

enum AppSizeVariant {
  Xs,
  Sm,
  Md,
  Lg,
  Xl,
}

extension CustomColorScheme on ColorScheme {
  Color get primary => _primaryColor;
  Color get secondary => _secondaryColor;
  Color get success => _successColor;
  Color get info => _infoColor;
  Color get warning => _warningColor;
  Color get danger => _dangerColor;

  Color get text =>
      brightness == Brightness.light ? _textColorDark : _textColorLight;

  Color get playerBackground => brightness == Brightness.light
      ? const Color.fromRGBO(230, 230, 230, 1)
      : const Color.fromRGBO(20, 20, 20, 1);

  // Color get playerForeground => brightness == Brightness.light
  //     ? const Color.fromRGBO(20, 20, 20, 1)
  //     : const Color.fromRGBO(200, 200, 200, 1);

   Color get playerForeground => brightness == Brightness.light
      ? const Color.fromRGBO(20, 20, 20, 1)
      : const Color.fromRGBO(200, 200, 200, 1);

  // buttons
  Color get primaryButtonBg => primary;
  Color get primaryButtonFg => const Color(0xFFFFFFFF);

  Color get secondaryButtonBg => secondary;
  Color get secondaryButtonFg => const Color(0xFFFFFFFF);

  Color get dangerButtonBg => danger;
  Color get dangerButtonFg => const Color(0xFFFFFFFF);
}

class AppTheme {
  final ThemeData themeData;

  const AppTheme({
    required this.themeData,
  });

  factory AppTheme.light(BuildContext context) {
    // final themeData = ThemeData.light().copyWith(
    //   cardTheme: const CardTheme(color: secondarylightColor),
    //   primaryTextTheme: const TextTheme(
    //     labelLarge: TextStyle(color: Colors.red)
    //   ),
    //   tabBarTheme: const TabBarTheme(
    //       indicator: UnderlineTabIndicator(
    //           //   borderSide: BorderSide(color: Colors.blue))),
    //           borderSide: BorderSide(color: Color.fromARGB(255, 241, 112, 0)))),
    //   navigationRailTheme: const NavigationRailThemeData(indicatorColor: bgColor, useIndicator: true, labelType: NavigationRailLabelType.selected, backgroundColor: secondarylightColor),
    //   appBarTheme: const AppBarTheme(
    //     color: secondarylightColor,
    //   ),
    //   scaffoldBackgroundColor: bgColor,
    //   textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
    //   canvasColor: secondaryColor,
    // );
    // return AppTheme(themeData: themeData);
    // final themeData = ThemeData.light().copyWith(
    //    cardTheme: const CardTheme(color: secondaryColor),
    //   primaryTextTheme: const TextTheme(
    //     labelLarge: TextStyle(color: Colors.red)
    //   ),
    //   drawerTheme: const DrawerThemeData(backgroundColor: Color.fromARGB(255, 75, 109, 221)),
    //   tabBarTheme: const TabBarTheme(
    //       indicator: UnderlineTabIndicator(
    //           //   borderSide: BorderSide(color: Colors.blue))),
    //           borderSide: BorderSide(color: Color.fromARGB(255, 75, 109, 221)))),
    //   navigationRailTheme: const NavigationRailThemeData(indicatorColor: bgColor, useIndicator: true, labelType: NavigationRailLabelType.selected, backgroundColor: secondaryColor),
    //   appBarTheme: const AppBarTheme(
    //     color: secondaryColor,
    //   ),
    //   scaffoldBackgroundColor: Colors.white30,
    //   textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(

    //     bodyColor: Colors.black),
    //   canvasColor: secondaryColor,
    // );
    // return AppTheme(themeData: themeData);
    return AppTheme(themeData: ThemeData.light());
  }

  // factory AppTheme.dark() {
  //   final _themeData = ThemeData(
  //     colorScheme: ColorScheme.fromSwatch(
  //       brightness: Brightness.dark,
  //       primarySwatch: createMaterialColor(_primaryColor),
  //       accentColor: _secondaryColor,
  //     ),
  //     textTheme: _textTheme(true),
  //   );

  //   return AppTheme(themeData: _themeData);
  // }

  factory AppTheme.dark(BuildContext context) {
    // final themeData = ThemeData.dark().copyWith(
    //   cardTheme: const CardTheme(color: secondaryColor),
    //   primaryTextTheme: const TextTheme(
    //     labelLarge: TextStyle(color: Colors.red)
    //   ),
    //   tabBarTheme: const TabBarTheme(
    //       indicator: UnderlineTabIndicator(
    //           //   borderSide: BorderSide(color: Colors.blue))),
    //           borderSide: BorderSide(color: Color.fromARGB(255, 241, 112, 0)))),
    //   navigationRailTheme: const NavigationRailThemeData(indicatorColor: bgColor, useIndicator: true, labelType: NavigationRailLabelType.selected, backgroundColor: secondaryColor),
    //   appBarTheme: const AppBarTheme(
    //     color: secondaryColor,
    //   ),
    //   scaffoldBackgroundColor: bgColor,
    //   textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
    //   canvasColor: secondaryColor,
    // );

    // return AppTheme(themeData: themeData);
    return AppTheme(themeData: ThemeData.dark());
  }

  // static TextTheme _textTheme([bool isDark = false]) {
  //   return TextTheme(
  //     displayLarge: TextStyle(
  //       fontSize: 42,
  //       fontWeight: FontWeight.w700,
  //       color: isDark ? _textColorLight : _textColorDark,
  //     ),
  //     displayMedium: TextStyle(
  //       fontSize: 36,
  //       fontWeight: FontWeight.w600,
  //       color: isDark ? _textColorLight : _textColorDark,
  //     ),
  //     displaySmall: TextStyle(
  //       fontSize: 30,
  //       fontWeight: FontWeight.w500,
  //       color: isDark ? _textColorLight : _textColorDark,
  //     ),
  //     headlineMedium: TextStyle(
  //       fontSize: 24,
  //       fontWeight: FontWeight.w500,
  //       color: (isDark ? _textColorLight : _textColorDark).withOpacity(0.8),
  //     ),
  //     headlineSmall: TextStyle(
  //       fontSize: 20,
  //       fontWeight: FontWeight.w500,
  //       color: (isDark ? _textColorLight : _textColorDark).withOpacity(0.7),
  //     ),
  //     titleLarge: TextStyle(
  //       fontSize: 18,
  //       fontWeight: FontWeight.w500,
  //       color: (isDark ? _textColorLight : _textColorDark).withOpacity(0.6),
  //     ),
  //   );
  // }

  static Color appVariantToColor(BuildContext context, AppColorVariant variant) {
    final colors = Theme.of(context).colorScheme;
    switch (variant) {
      case AppColorVariant.Primary:
        return colors.primary;
      case AppColorVariant.Secondary:
        return colors.secondary;
      // case AppColorVariant.Info:
      //   return _colors.info;
      // case AppColorVariant.Success:
      //   return _colors.success;
      // case AppColorVariant.Warning:
      //   return _colors.warning;
      case AppColorVariant.Danger:
        return colors.danger;
    }
  }
}
