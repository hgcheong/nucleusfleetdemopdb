import 'package:freezed_annotation/freezed_annotation.dart';

part 'column_info.freezed.dart';
part 'column_info.g.dart';

@freezed
abstract class ColumnInfo with _$ColumnInfo {
  factory ColumnInfo({
    String? title,
    String? data,
    String? dataType,
    bool? visible,
    bool? isReq
  }) = _ColumnInfo;

  factory ColumnInfo.fromJson(Map<String, dynamic> json) =>
      _$ColumnInfoFromJson(json);
}
