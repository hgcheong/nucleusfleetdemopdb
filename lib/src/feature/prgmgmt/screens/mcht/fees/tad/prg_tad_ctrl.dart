import 'package:riverpod/riverpod.dart';

final planIdProvider = StateProvider((ref) => "");
final needRefreshTadListProvider = StateProvider((ref) => DateTime.now());
final needRefreshTadProvider = StateProvider((ref) => DateTime.now());
final needRefreshFeePlanListProvider = StateProvider((ref) => DateTime.now());
final isTadFormVisible = StateProvider((ref) => true);
