
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trina_grid/trina_grid.dart';

final billingCustMgmtAccDetailProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    "CustEttyId": null,
    "PrgEttyId": null,
    "EttyId": null,
    "AcctType": null,
    "AcctId": null,
  };
});

final txnCustMgmtAccDetailProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "CustEttyId": null,
    "PrgEttyId": null,
    "EttyId": null,
    "AcctId": null,
  };
});

final pukalCustMgmtAccDetailProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    "CustEttyId": null,
    "PrgEttyId": null,
    "EttyId": null,
    "AcctId": null,
    "AcctNo": null
  };
});

final apiMgmtCustBillingAcctList = StateProvider<TrinaRow>((ref) {
  return TrinaRow.fromJson({});
});

final billingAcctMgmtModelIdProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {"PrgEttyId": null, "BillingType": null};
});
