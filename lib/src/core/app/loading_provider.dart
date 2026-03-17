import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingProvider extends StateNotifier<bool> {
  // ignore: use_super_parameters
  LoadingProvider([dynamic loading = false]) : super(loading);

  void _setLoading([bool value = true]) {
    state = value;
  }

  void start() {
    _setLoading(true);
  }

  void complete() {
    _setLoading(false);
  }
}

final loadingProvider =
    StateNotifierProvider<LoadingProvider, bool>((ref) => LoadingProvider());
