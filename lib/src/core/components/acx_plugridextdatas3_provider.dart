import 'package:riverpod/riverpod.dart';

final s3SelectedRowProvider = StateProvider<String>((ref) {
  return '';
});

final s3ProgressProvider = StateProvider<String>((ref) {
  return '';
});

final s3ReloadProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
