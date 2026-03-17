

import 'package:flutter_riverpod/flutter_riverpod.dart';

final billingAccPrgNameProvider = StateProvider<String>((ref) {
  return "";
});

final accountHolderNameProvider = StateProvider<String>((ref) {
  return "";
});

final billingAccDetailProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "CustEttyId": null,
    "PrgEttyId": null,
    "EttyId": null,
    "AcctType": null,
    "AcctId": null,
  };
});

final billingAcctModelIdProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {"PrgEttyId": null, "BillingType": null};
});

final pukalCustEnrollAccDetailProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    "CustEttyId": null,
    "PrgEttyId": null,
    "EttyId": null,
    "AcctId": null,
    "AcctNo": null
  };
});