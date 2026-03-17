
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trina_grid/trina_grid.dart';

final dataentryTxnIdProvider = StateProvider<String>((ref) {
  return "";
});

final apiMnlTxnPukalListProvider = StateProvider<TrinaRow>((ref) {
  return TrinaRow.fromJson({});
});
