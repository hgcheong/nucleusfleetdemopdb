import 'package:nucleusv2/src/core/app/acx_returndataservice.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'acx_returndata_async.g.dart';

@riverpod
class AcxReturnData extends _$AcxReturnData {
  AcxReturnData();
  Future<Returndata> _fetchData(QueryObject query) async {
    return AcxReturnDataService()
        .retrieve(query.querysql, query.params, showMsg: query.showMsg);
  }

  @override
  FutureOr<Returndata> build(QueryObject query) async {
    return _fetchData(query);
  }

  // Let's allow the UI to add todos.
  Future<Returndata> retrieve(QueryObject query) {
    return _fetchData(query);
  }
}
