import 'package:freezed_annotation/freezed_annotation.dart';
import 'column_info.dart';
import 'message.dart';
import 'output.dart';
part 'returndata.freezed.dart';
part 'returndata.g.dart';

@freezed
abstract class Returndata with _$Returndata {
  factory Returndata({
    List<dynamic>? data,
    List<Output>? output,
    int? rowcount,
    List<ColumnInfo>? columnInfo,
    Message? message,
    dynamic error,
  }) = _Returndata;

  factory Returndata.fromJson(Map<String, dynamic> json) =>
      _$ReturndataFromJson(json);
}
