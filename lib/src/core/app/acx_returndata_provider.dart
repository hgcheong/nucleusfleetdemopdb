import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/app/acx_returndataservice.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/core/models/returndata/multireturndata.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'acx_returndata_provider.g.dart';

//When using parameter without QueryObject it will rebuild even with same paramter
//TAKE NOTE on QueryObject and Freeze
@Riverpod(keepAlive: false)
Future<Returndata> returndata(Ref ref,
    {required String querysql,
    required Map<String, dynamic> params,
    bool showMsg = false}) async {
  return await AcxReturnDataService()
      .retrieve(querysql, params, showMsg: showMsg);
}

@Riverpod(keepAlive: false)
Future<MultiReturndata> multireturndata(
    Ref ref,  {required String querysql,
    required Map<String, dynamic> params,
    bool showMsg = false}) async {
  return await AcxMultiReturnDataService()
      .retrieve(querysql, params, showMsg: showMsg);
}

//When using parameter without QueryObject then its with freezed so same object comparisan even same param will not rebuilt using freezed
@Riverpod(keepAlive: false)
Future<Returndata> returndatafreezed(Ref ref, QueryObject query) async {
  final queryStr = query.querysql.contains('/')
      ? query.querysql
      : '/sp/${query.querysql}/queryasync';
  return await AcxReturnDataService()
      .retrieve(queryStr, query.params, showMsg: query.showMsg);
}

@Riverpod(keepAlive: false)
Future<Returndata> returndatafreezedwTitle(
    Ref ref, QueryObject query, QueryObject titleQuery) async {
  return await AcxReturnDataService()
      .retrieve(query.querysql, query.params, showMsg: query.showMsg);
}

@Riverpod(keepAlive: false)
Future<MultiReturndata> multireturndatafreezed(
    Ref ref, QueryObject query) async {
  return await AcxMultiReturnDataService()
      .retrieve(query.querysql, query.params, showMsg: query.showMsg);
}
