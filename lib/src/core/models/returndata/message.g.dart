// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
      msgId: (json['msgId'] as num?)?.toInt(),
      dscp: json['dscp'] as String?,
      msgSeverity: (json['msgSeverity'] as num?)?.toInt(),
      bitInd: (json['bitInd'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
      'msgId': instance.msgId,
      'dscp': instance.dscp,
      'msgSeverity': instance.msgSeverity,
      'bitInd': instance.bitInd,
    };
