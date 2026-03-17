import 'package:riverpod/riverpod.dart';

final mediaCustMgmtCmpyEttyIdProvider = StateProvider<String>((ref) {
  return "";
});

final mediaCustMgmtCostCenterEttyIdProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    "CustEttyId": null,
    "CmpyEttyId": null,
    "CostCtrEttyId": null,
    "MbrEttyId": null
  };
});

final mediaCustMgmtMediaHolderNameProvider = StateProvider<String>((ref) {
  return "";
});

final mediaCustMgmtMediaPrgSelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {"PrgEttyId": null};
});

final mediaCustMgmtMediaCategorySelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {"MediaCtgry": null,"Dscp":null};
});

final mediaCustMgmtMediaPrgNameProvider = StateProvider<String>((ref) {
  return "";
});
