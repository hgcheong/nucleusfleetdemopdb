import 'package:flutter/material.dart';

/// DiBold design tokens (Mantraksh Devs "DiBold" admin template).
///
/// The primary scale is copied from DiBold's `src/index.css` @theme tokens.
/// Neutrals follow Tailwind's slate scale, which DiBold is built on.
/// Change values here only — theme, grids, drawers, charts and PDF export
/// all read from this class.
class DbColors {
  DbColors._();

  // ── Primary (DiBold teal) — --color-primary-50 … 900 ───────────────────────
  static const Color primary50 = Color(0xFFE6F7F7);
  static const Color primary100 = Color(0xFFC0EBEB);
  static const Color primary200 = Color(0xFF99DFDF);
  static const Color primary300 = Color(0xFF66CCCC);
  static const Color primary400 = Color(0xFF33B8B8);
  static const Color primary500 = Color(0xFF027F80);
  static const Color primary600 = Color(0xFF026B6C);
  static const Color primary700 = Color(0xFF025757);
  static const Color primary800 = Color(0xFF014242);
  static const Color primary900 = Color(0xFF002E2E);

  /// Main brand colour (= primary500).
  static const Color primary = primary500;

  // ── Neutrals (Tailwind slate) ─────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color slate950 = Color(0xFF020617);

  // ── Status ────────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF059669);
  static const Color warning = Color(0xFFD97706);
  static const Color danger = Color(0xFFDC2626);
  static const Color info = Color(0xFF0284C7);

  /// Required-field label colour (readable on light and dark surfaces).
  static const Color required = Color(0xFFD97706);

  // ── Chart series ──────────────────────────────────────────────────────────
  static const List<Color> chartSeries = [
    primary500,
    Color(0xFF6366F1), // indigo
    Color(0xFFF59E0B), // amber
    primary300,
    Color(0xFFEF4444), // red
    Color(0xFF8B5CF6), // violet
    Color(0xFF10B981), // emerald
    slate500,
  ];
}
