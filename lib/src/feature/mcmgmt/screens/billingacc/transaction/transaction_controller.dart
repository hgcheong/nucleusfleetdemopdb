

import 'package:flutter_riverpod/flutter_riverpod.dart';

final txnSearchMchtContorllerProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "MchtEttyId": null,
    "LocEttyId": null,
    "TxnCtgry": null,
    "MediaNo": null,
    "FromDate": null,
    "ToDate": null
  };
});

final txnSearchMchtOltpContorllerProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    "CustEttyId": null,
    "EttyId": null,
    "AcctId": null,
    "LocNo": null,
    "MediaNo": null,
    "TxnInd": 0,
    "TadNo": null,
    "TxnDate": null
  };
});
