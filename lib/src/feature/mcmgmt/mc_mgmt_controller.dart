import 'package:riverpod/riverpod.dart';

//Infact we are storing Company Name here
final mchtMgmtNameProvider = StateProvider<String>((ref) {
  return "";
});

//Infact we are storing Program Details Name here
final mchtMgmtPrgSelectProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final mchtMgmtCmpyCtrlTxnPrgSelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final mchtMgmtCmpyCtrlTxnPrgNameProvider = StateProvider<String>((ref) {
  return "";
});

//Infact we are storing Program Details Name here
final mchtMgmtMbrPrgSelectProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final mchtMgmtMbrCtrlTxnPrgSelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final mchtMgmtMbrCtrlTxnPrgNameProvider = StateProvider<String>((ref) {
  return "";
});
