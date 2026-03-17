import 'package:flutter_riverpod/flutter_riverpod.dart';

final needRefreshTransListProvider = StateProvider((ref) => DateTime.now());
final needRefreshTransProvider = StateProvider((ref) => DateTime.now());
final needRefreshTransFeePlanListProvider =
    StateProvider((ref) => DateTime.now());
