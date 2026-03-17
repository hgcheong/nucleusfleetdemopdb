import 'package:riverpod/riverpod.dart';

//We specify if Str or Int
//Enum AttrBIt {"Str", "Int"};

// final mainSearchAttributeProvider = StateProvider<String>((ref) {
//   return "Str";
// });

// final mainSearchRefCdTypeProvider = StateProvider<String>((ref) {
//   return "MCHTNAME";
// });

final mainSearchSearchFieldProvider = StateProvider<String>((ref) {
  return "MCHTNAME|MERCHANT NAME|Str";
});

final mainSearchInput = StateProvider<String>((ref) {
  return "";
});

final mainSearchKeyFieldProvider = StateProvider<String>((ref) {
  return "EttyId";
});

final showHideOptionsProvider = StateProvider<bool>((ref) {
  return false;
});
