

import 'package:hooks_riverpod/hooks_riverpod.dart';

final txnSearchContorllerProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "CustEttyId": null,
    "TxnCtgry": null,
    "PrgEttyId":null,
    "FromDate": null,
    "ToDate": null,
    "PostDate":null
  };
});

final txnSearchContorllerUnbilledProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "TxnCtgry": null,
    "PrgEttyId":null,
    "FromDate": null,
    "ToDate": null,
    "AcctId":null,
    "MediaNo":null
  };
});

final txnSearchPostedContorllerProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "CustEttyId": null,
    "TxnCtgry": null,
    "PrgEttyId":null,
    "FromDate": null,
    "ToDate": null,
    "PostDate":null
  };
});

final txnSearchSwitchByPostedDate = StateProvider<bool>((ref){
  return false;
});

final txnSearchOltpContorllerProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    "CustEttyId": null,
    "EttyId": null,
    "AcctId": null,
    "LocNo": null,
    "MediaNo": null,
    "TxnInd": "0",
    "TadNo": null,
    "TxnDate": null
  };
});

//  "MediaNo":null,
// "FromDate": null,
//  "ToDate": null,
//  "TxnCtgry":null};
