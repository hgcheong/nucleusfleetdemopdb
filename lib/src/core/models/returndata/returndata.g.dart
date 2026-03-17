// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'returndata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Returndata _$ReturndataFromJson(Map<String, dynamic> json) => _Returndata(
      data: json['data'] as List<dynamic>?,
      output: (json['output'] as List<dynamic>?)
          ?.map((e) => Output.fromJson(e as Map<String, dynamic>))
          .toList(),
      rowcount: (json['rowcount'] as num?)?.toInt(),
      columnInfo: (json['columnInfo'] as List<dynamic>?)
          ?.map((e) => ColumnInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] == null
          ? null
          : Message.fromJson(json['message'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$ReturndataToJson(_Returndata instance) =>
    <String, dynamic>{
      'data': instance.data,
      'output': instance.output,
      'rowcount': instance.rowcount,
      'columnInfo': instance.columnInfo,
      'message': instance.message,
      'error': instance.error,
    };
