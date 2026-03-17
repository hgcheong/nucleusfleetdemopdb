import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final pukalSearchOutBoundContorllerProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "PrgEttyId": null,
    "Yr": DateFormat('yyyy').format(DateTime.now()),
    "Mn":DateFormat('M').format(DateTime.now()),
  };
});

final pukalSearchInboundContorllerProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "PrgEttyId": null,
    "DateTime":null
  };
});
//rptSearchContorllerProvider

final rptpukalSearchContorllerProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "RptType": "PUKAL",
    "Yr":  DateFormat('yyyy').format(DateTime.now()),
    "Mn": DateFormat('M').format(DateTime.now()),
  };
});