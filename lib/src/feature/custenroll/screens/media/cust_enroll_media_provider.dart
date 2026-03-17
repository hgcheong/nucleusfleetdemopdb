import 'package:riverpod/riverpod.dart';

final mediaCmpyEttyIdProvider = StateProvider<String>((ref) {
  return "";
});

final mediaCostCenterEttyIdProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    "CustEttyId": null,
    "CmpyEttyId": null,
    "CostCtrEttyId": null,
    "MbrEttyId": null
  };
});

final mediaMediaHolderNameProvider = StateProvider<String>((ref) {
  return "";
});

final mediaMediaPrgSelectProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {"PrgEttyId": null};
});

final mediaMediaCategorySelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {"MediaCtgry": null,"Dscp":null};
});

final mediaMediaPrgNameProvider = StateProvider<String>((ref) {
  return "";
});
