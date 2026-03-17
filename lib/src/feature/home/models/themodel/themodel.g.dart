// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'themodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Themodel _$ThemodelFromJson(Map<String, dynamic> json) => _Themodel(
      cmpyName: json['CmpyName'] as String?,
      agrmtNo: json['AgrmtNo'] as String?,
      agrmtDate: json['AgrmtDate'] as String?,
      cmpyType: json['CmpyType'] as String?,
      rgstionName: json['RgstionName'] as String?,
      rgstionNo: json['RgstionNo'] as String?,
      rgstionDate: json['RgstionDate'] as String?,
      busnType: json['BusnType'] as String?,
      segmtType: json['SegmtType'],
      applRef: json['ApplRef'] as String?,
      applSrc: json['ApplSrc'] as String?,
      submtDate: json['SubmtDate'] as String?,
      acctMgrName: json['AcctMgrName'] as String?,
      taxCtgry: json['TaxCtgry'] as String?,
      taxNo: json['TaxNo'] as String?,
      cmpySize: json['CmpySize'],
      dedupInd: json['DedupInd'] as String?,
      mchtSts: json['MchtSts'],
    );

Map<String, dynamic> _$ThemodelToJson(_Themodel instance) => <String, dynamic>{
      'CmpyName': instance.cmpyName,
      'AgrmtNo': instance.agrmtNo,
      'AgrmtDate': instance.agrmtDate,
      'CmpyType': instance.cmpyType,
      'RgstionName': instance.rgstionName,
      'RgstionNo': instance.rgstionNo,
      'RgstionDate': instance.rgstionDate,
      'BusnType': instance.busnType,
      'SegmtType': instance.segmtType,
      'ApplRef': instance.applRef,
      'ApplSrc': instance.applSrc,
      'SubmtDate': instance.submtDate,
      'AcctMgrName': instance.acctMgrName,
      'TaxCtgry': instance.taxCtgry,
      'TaxNo': instance.taxNo,
      'CmpySize': instance.cmpySize,
      'DedupInd': instance.dedupInd,
      'MchtSts': instance.mchtSts,
    };
