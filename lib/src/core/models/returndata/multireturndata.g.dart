// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multireturndata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MultiReturndata _$MultiReturndataFromJson(Map<String, dynamic> json) =>
    _MultiReturndata(
      multidata: (json['multidata'] as List<dynamic>?)
          ?.map((e) => Returndata.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MultiReturndataToJson(_MultiReturndata instance) =>
    <String, dynamic>{
      'multidata': instance.multidata,
    };
