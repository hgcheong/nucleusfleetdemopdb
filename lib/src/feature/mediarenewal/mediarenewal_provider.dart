

import 'package:flutter_riverpod/flutter_riverpod.dart';

final mediaSearchContorllerProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    "CmpyEttyId": null,
    "MediaEttyId": null,
    "VhcRgsNo": null,
    "FromDate": null,
    "ToDate": null
  };
});
