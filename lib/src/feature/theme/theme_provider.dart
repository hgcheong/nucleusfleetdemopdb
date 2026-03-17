// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app/storage.dart';

const DEFAULT_THEME = ThemeMode.dark;

class ThemeProvider extends StateNotifier<ThemeMode> {
  late final Storage _storage = singleton<Storage>();

  ThemeProvider([super.themeMode = DEFAULT_THEME]) {
    _init();
  }

  Future<void> _init() async {
    final savedTheme = _storage.getString(Storage.THEME_KEY);

    if (savedTheme == 'ThemeMode.light') {
      setLight();
    } else if (savedTheme == 'ThemeMode.dark') {
      setDark();
    }
  }

  void _set(ThemeMode themeMode) {
    state = themeMode;
    _storage.setString(Storage.THEME_KEY, themeMode.toString());
  }

  void setLight() {
    _set(ThemeMode.light);
  }

  void setDark() {
    _set(ThemeMode.dark);
  }

  void setSystem() {
    _set(ThemeMode.system);
  }
}

final themeProvider =
    StateNotifierProvider<ThemeProvider, ThemeMode>((ref) => ThemeProvider());
