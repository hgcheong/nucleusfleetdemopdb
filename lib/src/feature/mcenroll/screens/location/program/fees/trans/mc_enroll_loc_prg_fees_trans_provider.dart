

import 'package:flutter_riverpod/flutter_riverpod.dart';

final mchtEnrollLocPrgFeestransProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {"FeeId": null, "MediaType": null, "TxnCtgry": null};
});
