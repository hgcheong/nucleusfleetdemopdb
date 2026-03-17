// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libref.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Libref _$LibrefFromJson(Map<String, dynamic> json) => Libref(
      refType: json['RefType'] as String?,
      refCd: json['RefCd'] as String?,
      dscp: json['Dscp'] as String?,
      bitInd: (json['BitInd'] as num?)?.toInt(),
      sts: json['Sts'] as String?,
    );

Map<String, dynamic> _$LibrefToJson(Libref instance) => <String, dynamic>{
      'RefType': instance.refType,
      'RefCd': instance.refCd,
      'Dscp': instance.dscp,
      'BitInd': instance.bitInd,
      'Sts': instance.sts,
    };
