import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:nucleusv2/src/core/app/session_provider.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/core/models/query_object.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:riverpod/riverpod.dart';

class ApiAcxLangKeyValService extends ApiService {
  ApiAcxLangKeyValService(this.sessm);
  final SessionModel sessm;

  Future<List<Langkeypair>> retrieveLangKey(
      String querysql, Map<String, dynamic> params) async {
    try {
      final toSubmit = {...params, 'SignIn': sessm.user!.email.toString()};
      final response = await postHttp(querysql, params: toSubmit);
      final returnData = Returndata.fromJson(response);
      final returnRef = Langkeypair.fromJsonList(returnData.data!.toList());
      return returnRef;
    } catch (e) {
      return [];
    }
  }
}

final repoLangKeyValueProvider = Provider<ApiAcxLangKeyValService>((ref) {
  final user = ref.watch(sessionStateNotifierProvider);
  return ApiAcxLangKeyValService(user);
});

final queryLangKeyValueProvider =
    FutureProvider.family<List<Langkeypair>, TheQueryObject>(
        (ref, query) async {
  final repo = ref.watch(repoLangKeyValueProvider);
  return repo.retrieveLangKey(query.querysql, query.params);
});

final returnLangKeyProvider = FutureProvider.autoDispose
    .family<List<Langkeypair>, QueryObject>((ref, query) async {
  final repo = ref.watch(repoLangKeyValueProvider);
  return repo.retrieveLangKey(query.querysql, query.params);
});

class LangKeyValueProvider extends StateNotifier<List<Langkeypair>> {
  LangKeyValueProvider(super.state);
}
