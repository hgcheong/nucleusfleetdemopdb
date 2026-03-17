import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final rptSearchContorllerProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "RptType": null,
    "Yr":  DateFormat('yyyy').format(DateTime.now()),
    "Mn": DateFormat('M').format(DateTime.now()),
  };
});


final rptQueryControllerProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "QryType": null,
    "Yr":  DateFormat('yyyy').format(DateTime.now()),
    "Mn": DateFormat('M').format(DateTime.now()),
  };
});