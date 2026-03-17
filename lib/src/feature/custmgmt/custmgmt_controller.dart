import 'package:riverpod/riverpod.dart';

//Infact we are storing Company Name here
final custMgmtNameProvider = StateProvider<String>((ref) {
  return "";
});

//Infact we are storing Program Details Name here
final custMgmtPrgSelectProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final custMgmtCmpyCtrlTxnPrgSelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {};
});


final custMgmtCmpyCtrlLocPrgSelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final custMgmtCmpyCtrlTxnPrgNameProvider = StateProvider<String>((ref) {
  return "";
});

//Infact we are storing Program Details Name here
final custMgmtMbrPrgSelectProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final custMgmtMbrCtrlTxnPrgSelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final custMgmtMbrCtrlTxnPrgNameProvider = StateProvider<String>((ref) {
  return "";
});
