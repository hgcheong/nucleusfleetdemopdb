import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
part 'multireturndata.freezed.dart';
part 'multireturndata.g.dart';

@freezed
abstract class MultiReturndata with _$MultiReturndata {
  factory MultiReturndata({
    List<Returndata>? multidata,
  }) = _MultiReturndata;

  factory MultiReturndata.fromJson(Map<String, dynamic> json) =>
      _$MultiReturndataFromJson(json);
}
