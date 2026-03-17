import 'package:riverpod/riverpod.dart';

//Infact we are storing Company Name here
final mchtEnrollNameProvider = StateProvider<String>((ref) {
  return "";
});

//Infact we are storing Program Details Name here
final mchtEnrollPrgSelectProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final mchtEnrollCmpyCtrlTxnPrgSelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final mchtEnrollCmpyCtrlTxnPrgNameProvider = StateProvider<String>((ref) {
  return "";
});

//Infact we are storing Program Details Name here
final mchtEnrollMbrPrgSelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final mchtEnrollMbrCtrlTxnPrgSelectProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final mchtEnrollMbrCtrlTxnPrgNameProvider = StateProvider<String>((ref) {
  return "";
});
