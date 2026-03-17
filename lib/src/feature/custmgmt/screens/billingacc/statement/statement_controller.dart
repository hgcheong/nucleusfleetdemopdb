

import 'package:flutter_riverpod/flutter_riverpod.dart';

final statementSearchContorllerProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {"AcctId": null, "PrgEttyId": null, "CustEttyId": null};
});
