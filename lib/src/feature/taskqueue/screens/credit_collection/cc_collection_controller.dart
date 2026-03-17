

import 'package:flutter_riverpod/flutter_riverpod.dart';

final txnCollectionContorllerProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    "CmpyName":null,
    "AcctNo":null
  };
});

final reloadMe = StateProvider<DateTime>((ref){
  return DateTime.now();
});