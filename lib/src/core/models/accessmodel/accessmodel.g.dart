// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Accessmodel _$AccessmodelFromJson(Map<String, dynamic> json) => Accessmodel(
      dscp: json['Dscp'] as String?,
      moduleName: json['ModuleName'] as String?,
      moduleType: json['ModuleType'] as String?,
      accessRightInd: json['AccessRightInd'] as String?,
      setupId: (json['SetupId'] as num?)?.toInt(),
      moduleId: (json['ModuleId'] as num?)?.toInt(),
      uId: (json['UId'] as num?)?.toInt(),
      ettyId: (json['EttyId'] as num?)?.toInt(),
      apps: json['Apps'] as String?,
      grpId: (json['GrpId'] as num?)?.toInt(),
      parentId: (json['ParentId'] as num?)?.toInt(),
      levelId: (json['LevelId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AccessmodelToJson(Accessmodel instance) =>
    <String, dynamic>{
      'Dscp': instance.dscp,
      'ModuleName': instance.moduleName,
      'ModuleType': instance.moduleType,
      'AccessRightInd': instance.accessRightInd,
      'SetupId': instance.setupId,
      'ModuleId': instance.moduleId,
      'UId': instance.uId,
      'EttyId': instance.ettyId,
      'Apps': instance.apps,
      'GrpId': instance.grpId,
      'ParentId': instance.parentId,
      'LevelId': instance.levelId,
    };
