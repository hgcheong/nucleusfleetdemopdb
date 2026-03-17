// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'themodel.freezed.dart';
part 'themodel.g.dart';

@freezed
abstract class Themodel with _$Themodel {
  factory Themodel({
    @JsonKey(name: 'CmpyName') String? cmpyName,
    @JsonKey(name: 'AgrmtNo') String? agrmtNo,
    @JsonKey(name: 'AgrmtDate') String? agrmtDate,
    @JsonKey(name: 'CmpyType') String? cmpyType,
    @JsonKey(name: 'RgstionName') String? rgstionName,
    @JsonKey(name: 'RgstionNo') String? rgstionNo,
    @JsonKey(name: 'RgstionDate') String? rgstionDate,
    @JsonKey(name: 'BusnType') String? busnType,
    @JsonKey(name: 'SegmtType') dynamic segmtType,
    @JsonKey(name: 'ApplRef') String? applRef,
    @JsonKey(name: 'ApplSrc') String? applSrc,
    @JsonKey(name: 'SubmtDate') String? submtDate,
    @JsonKey(name: 'AcctMgrName') String? acctMgrName,
    @JsonKey(name: 'TaxCtgry') String? taxCtgry,
    @JsonKey(name: 'TaxNo') String? taxNo,
    @JsonKey(name: 'CmpySize') dynamic cmpySize,
    @JsonKey(name: 'DedupInd') String? dedupInd,
    @JsonKey(name: 'MchtSts') dynamic mchtSts,
  }) = _Themodel;

  factory Themodel.fromJson(Map<String, dynamic> json) =>
      _$ThemodelFromJson(json);
}
