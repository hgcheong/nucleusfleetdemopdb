

import 'package:flutter_riverpod/flutter_riverpod.dart';

final mchtMgmtLocPrgFeestransProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {"FeeId": null, "MediaType": null, "TxnCtgry": null};
});
