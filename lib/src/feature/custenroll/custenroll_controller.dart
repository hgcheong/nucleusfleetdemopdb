import 'package:riverpod/riverpod.dart';

//Infact we are storing Company Name here
final custEnrollNameProvider = StateProvider<String>((ref) {
  return "";
});

//Infact we are storing Program Details Name here
final custEnrollPrgSelectProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final custEnrollCmpyCtrlTxnPrgSelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final custEnrollCmpyCtrlLocPrgSelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final custEnrollMbrCtrlTxnPrgSelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final custEnrollCmpyCtrlTxnPrgNameProvider = StateProvider<String>((ref) {
  return "";
});

//Infact we are storing Program Details Name here
final custEnrollMbrPrgSelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final custEnrollMbrCtrlTxnPrgNameProvider = StateProvider<String>((ref) {
  return "";
});
