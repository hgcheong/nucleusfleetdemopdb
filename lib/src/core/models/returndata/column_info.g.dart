// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'column_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ColumnInfo _$ColumnInfoFromJson(Map<String, dynamic> json) => _ColumnInfo(
      title: json['title'] as String?,
      data: json['data'] as String?,
      dataType: json['dataType'] as String?,
      visible: json['visible'] as bool?,
      isReq: json['isReq'] as bool?,
    );

Map<String, dynamic> _$ColumnInfoToJson(_ColumnInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'data': instance.data,
      'dataType': instance.dataType,
      'visible': instance.visible,
      'isReq': instance.isReq,
    };
