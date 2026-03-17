

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/models/accessmodel/accessmodel.dart';

final userMgmtControllerProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final userPortalControllerProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});

final userAccessControllerProvider = StateProvider<List<Accessmodel>?>((ref) {
  return [];
});

final isDeniedPageControllerProvider = StateProvider<List<Accessmodel>?>((ref) {
  return [];
});

final isDeniedActionControllerProvider = StateProvider<List<Accessmodel>?>((ref) {
  return [];
});

final userRoleGridSearchControllerProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
  "UserType": null,
  "SignIn" : null,
  "Email":null
};
});

