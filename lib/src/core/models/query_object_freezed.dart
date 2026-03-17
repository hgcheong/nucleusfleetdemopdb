import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_object_freezed.freezed.dart';

@freezed
abstract class QueryObject with _$QueryObject {
  factory QueryObject(
      {required String querysql,
      required Map<String, dynamic> params,
      required bool showMsg}) = _QueryObject;
}
