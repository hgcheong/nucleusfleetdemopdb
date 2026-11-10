import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';

export 'package:nucleusv2/src/feature/theme/db_colors.dart';

/// DiBold theme for the Nucleus web app.
///
/// Mirrors the DiBold admin template: teal primary (#027F80), Nunito Sans,
/// white header and sidebar with a teal active state, white bordered cards on
/// a slate-50 page in light mode, slate-800 cards on slate-900 in dark mode.
///
///   theme: DiboldTheme.light(),
///   darkTheme: DiboldTheme.dark(),
///
/// Status colours: `context.dbStatus.success` / `.warning` / `.info` / `.danger`.
class DiboldTheme {
  DiboldTheme._();

  /// Corner radius for cards, dialogs and menus (DiBold "rounded" preset).
  static const double radius = 12;

  /// Corner radius for buttons, inputs and chips.
  static const double radiusSm = 8;

  /// Fixed height of single-line form fields (text, number, date, lookup).
  static const double fieldHeight = 48;

  /// Vertical gap between two form fields.
  static const double fieldSpacing = 16;

  /// Gap between action buttons (save, back to list, audit log), and
  /// between those buttons and their neighbours.
  static const double actionSpacing = 10;

  // ── Colour schemes ────────────────────────────────────────────────────────
  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: DbColors.primary500,
    onPrimary: DbColors.white,
    primaryContainer: DbColors.primary50,
    onPrimaryContainer: DbColors.primary800,
    secondary: DbColors.primary700,
    onSecondary: DbColors.white,
    secondaryContainer: DbColors.primary100,
    onSecondaryContainer: DbColors.primary900,
    tertiary: DbColors.slate600,
    onTertiary: DbColors.white,
    tertiaryContainer: DbColors.slate100,
    onTertiaryContainer: DbColors.slate800,
    error: DbColors.danger,
    onError: DbColors.white,
    errorContainer: Color(0xFFFEE2E2),
    onErrorContainer: Color(0xFF7F1D1D),
    surface: DbColors.white,
    onSurface: DbColors.slate800,
    onSurfaceVariant: DbColors.slate500,
    surfaceDim: DbColors.slate100,
    surfaceBright: DbColors.white,
    surfaceContainerLowest: DbColors.white,
    surfaceContainerLow: DbColors.slate50,
    surfaceContainer: DbColors.slate100,
    surfaceContainerHigh: DbColors.slate100,
    surfaceContainerHighest: DbColors.slate200,
    outline: DbColors.slate300,
    outlineVariant: DbColors.slate200,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: DbColors.slate800,
    onInverseSurface: DbColors.slate50,
    inversePrimary: DbColors.primary300,
    surfaceTint: Colors.transparent,
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: DbColors.primary400,
    onPrimary: DbColors.primary900,
    primaryContainer: DbColors.primary800,
    onPrimaryContainer: DbColors.primary100,
    secondary: DbColors.primary300,
    onSecondary: DbColors.primary900,
    secondaryContainer: DbColors.primary900,
    onSecondaryContainer: DbColors.primary100,
    tertiary: DbColors.slate400,
    onTertiary: DbColors.slate900,
    tertiaryContainer: DbColors.slate700,
    onTertiaryContainer: DbColors.slate100,
    error: Color(0xFFF87171),
    onError: Color(0xFF450A0A),
    errorContainer: Color(0xFF7F1D1D),
    onErrorContainer: Color(0xFFFEE2E2),
    surface: DbColors.slate800,
    onSurface: DbColors.slate100,
    onSurfaceVariant: DbColors.slate400,
    surfaceDim: DbColors.slate900,
    surfaceBright: DbColors.slate700,
    surfaceContainerLowest: DbColors.slate900,
    surfaceContainerLow: DbColors.slate800,
    surfaceContainer: DbColors.slate800,
    surfaceContainerHigh: DbColors.slate700,
    surfaceContainerHighest: DbColors.slate600,
    outline: DbColors.slate600,
    outlineVariant: DbColors.slate700,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: DbColors.slate100,
    onInverseSurface: DbColors.slate800,
    inversePrimary: DbColors.primary600,
    surfaceTint: Colors.transparent,
  );

  static ThemeData light() => _build(lightScheme, DbStatusColors.light);

  static ThemeData dark() => _build(darkScheme, DbStatusColors.dark);

  // ── ThemeData builder ─────────────────────────────────────────────────────
  static ThemeData _build(ColorScheme cs, DbStatusColors status) {
    final isDark = cs.brightness == Brightness.dark;
    final pageBg = isDark ? DbColors.slate900 : DbColors.slate50;
    const shapeSm = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(radiusSm)),
    );
    const shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: cs.brightness,
      colorScheme: cs,
    );

    // Nunito Sans — DiBold's typeface (loaded by google_fonts at runtime).
    final textTheme = GoogleFonts.nunitoSansTextTheme(base.textTheme).apply(
      bodyColor: cs.onSurface,
      displayColor: cs.onSurface,
    );
    final fontFamily = GoogleFonts.nunitoSans().fontFamily;

    OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(radiusSm)),
          borderSide: BorderSide(color: c, width: w),
        );

    final labelBold = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700);

    return base.copyWith(
      textTheme: textTheme,
      scaffoldBackgroundColor: pageBg,
      canvasColor: cs.surface,
      dividerColor: cs.outlineVariant,
      extensions: [status],

      // DiBold header: surface-coloured with a hairline bottom border.
      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: Border(bottom: BorderSide(color: cs.outlineVariant)),
        iconTheme: IconThemeData(color: cs.onSurfaceVariant),
        actionsIconTheme: IconThemeData(color: cs.onSurfaceVariant),
        titleTextStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: cs.onSurface,
        ),
      ),

      // DiBold sidebar: surface-coloured, teal active item.
      drawerTheme: DrawerThemeData(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: cs.surface,
        indicatorColor: cs.primaryContainer,
        selectedIconTheme: IconThemeData(color: cs.primary),
        unselectedIconTheme: IconThemeData(color: cs.onSurfaceVariant),
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: cs.primary,
        unselectedLabelColor: cs.onSurfaceVariant,
        indicatorColor: cs.primary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: cs.outlineVariant,
        labelStyle: labelBold,
        unselectedLabelStyle: TextStyle(fontFamily: fontFamily),
      ),

      cardTheme: CardThemeData(
        color: cs.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(radius)),
          side: BorderSide(color: cs.outlineVariant),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        shape: shape,
        titleTextStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      ),

      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: isDark ? DbColors.slate900 : DbColors.white,
        border: border(cs.outline),
        enabledBorder: border(cs.outline),
        focusedBorder: border(cs.primary, 1.5),
        errorBorder: border(cs.error),
        focusedErrorBorder: border(cs.error, 1.5),
        disabledBorder: border(cs.outlineVariant),
        hintStyle: TextStyle(color: cs.onSurfaceVariant),
        labelStyle: TextStyle(color: cs.onSurfaceVariant),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return TextStyle(color: cs.error);
          }
          if (states.contains(WidgetState.focused)) {
            return TextStyle(color: cs.primary);
          }
          return TextStyle(color: cs.onSurfaceVariant);
        }),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          disabledBackgroundColor: cs.onSurface.withValues(alpha: 0.12),
          disabledForegroundColor: cs.onSurface.withValues(alpha: 0.38),
          elevation: 0,
          shape: shapeSm,
          textStyle: labelBold,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          shape: shapeSm,
          textStyle: labelBold,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          side: BorderSide(color: cs.primary),
          shape: shapeSm,
          textStyle: labelBold,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cs.primary,
          shape: shapeSm,
          textStyle: labelBold,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: cs.onSurfaceVariant),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        shape: shape,
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? cs.primary : null),
        checkColor: WidgetStatePropertyAll(cs.onPrimary),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? cs.primary : cs.outline),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? cs.onPrimary : null),
        trackColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? cs.primary : null),
      ),

      listTileTheme: ListTileThemeData(
        dense: true,
        iconColor: cs.onSurfaceVariant,
        selectedColor: cs.primary,
        selectedTileColor: cs.primaryContainer,
        shape: shapeSm,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: cs.surfaceContainer,
        selectedColor: cs.primaryContainer,
        side: BorderSide(color: cs.outlineVariant),
        shape: shapeSm,
      ),
      dataTableTheme: DataTableThemeData(
        headingRowColor: WidgetStatePropertyAll(
            isDark ? DbColors.slate700 : DbColors.slate50),
        headingTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w700,
          color: cs.onSurfaceVariant,
        ),
        dividerThickness: 1,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: cs.primary,
        linearTrackColor: cs.primaryContainer,
      ),
      dividerTheme: DividerThemeData(color: cs.outlineVariant, thickness: 1),
      popupMenuTheme: PopupMenuThemeData(
        color: cs.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(radiusSm)),
          side: BorderSide(color: cs.outlineVariant),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? DbColors.slate700 : DbColors.slate800,
        contentTextStyle:
            TextStyle(fontFamily: fontFamily, color: DbColors.white),
        actionTextColor: DbColors.primary300,
        behavior: SnackBarBehavior.floating,
        shape: shapeSm,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: isDark ? DbColors.slate700 : DbColors.slate800,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        textStyle: TextStyle(
            fontFamily: fontFamily, fontSize: 12, color: DbColors.white),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: cs.primary,
        selectionColor: cs.primary.withValues(alpha: 0.25),
        selectionHandleColor: cs.primary,
      ),
    );
  }
}

/// Status colours not covered by Material's ColorScheme.
@immutable
class DbStatusColors extends ThemeExtension<DbStatusColors> {
  const DbStatusColors({
    required this.success,
    required this.warning,
    required this.info,
    required this.danger,
  });

  final Color success;
  final Color warning;
  final Color info;
  final Color danger;

  static const light = DbStatusColors(
    success: DbColors.success,
    warning: DbColors.warning,
    info: DbColors.info,
    danger: DbColors.danger,
  );

  static const dark = DbStatusColors(
    success: Color(0xFF34D399),
    warning: Color(0xFFFBBF24),
    info: Color(0xFF38BDF8),
    danger: Color(0xFFF87171),
  );

  @override
  DbStatusColors copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? danger,
  }) =>
      DbStatusColors(
        success: success ?? this.success,
        warning: warning ?? this.warning,
        info: info ?? this.info,
        danger: danger ?? this.danger,
      );

  @override
  DbStatusColors lerp(ThemeExtension<DbStatusColors>? other, double t) {
    if (other is! DbStatusColors) return this;
    return DbStatusColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }
}

extension DbThemeContext on BuildContext {
  DbStatusColors get dbStatus =>
      Theme.of(this).extension<DbStatusColors>() ?? DbStatusColors.light;
}
