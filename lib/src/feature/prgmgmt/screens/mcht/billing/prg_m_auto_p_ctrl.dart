import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/app/acx_returndataservice.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prg_m_auto_p_ctrl.g.dart';

@Riverpod(keepAlive: true)
Future<Returndata> prgmautopFormData(Ref ref, QueryObject query) async {
  return await AcxReturnDataService()
      .retrieve(query.querysql, query.params, showMsg: query.showMsg);
}
