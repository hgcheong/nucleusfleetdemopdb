import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accessmodel.g.dart';

@JsonSerializable()

class Accessmodel extends Equatable {
  @JsonKey(name: 'Dscp')
  final String? dscp;
  @JsonKey(name: 'ModuleName')
  final String? moduleName;
  @JsonKey(name: 'ModuleType')
  final String? moduleType;
  @JsonKey(name: 'AccessRightInd')
  final String? accessRightInd;
  @JsonKey(name: 'SetupId')
  final int? setupId;
  @JsonKey(name: 'ModuleId')
  final int? moduleId;
  @JsonKey(name: 'UId')
  final int? uId;
  @JsonKey(name: 'EttyId')
  final int? ettyId;
  @JsonKey(name: 'Apps')
  final String? apps;
  @JsonKey(name: 'GrpId')
  final int? grpId;
  @JsonKey(name: 'ParentId')
  final int? parentId;
  @JsonKey(name: 'LevelId')
  final int? levelId;

  const Accessmodel({
    this.dscp,
    this.moduleName,
    this.moduleType,
    this.accessRightInd,
    this.setupId,
    this.moduleId,
    this.uId,
    this.ettyId,
    this.apps,
    this.grpId,
    this.parentId,
    this.levelId,
  });

  factory Accessmodel.fromJson(Map<String, dynamic> json) {
    return _$AccessmodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AccessmodelToJson(this);

  static List<Accessmodel> fromJsonList(List list) {
    return list.map((item) => Accessmodel.fromJson(item)).toList();
  }

  Accessmodel copyWith({
    String? dscp,
    String? moduleName,
    String? moduleType,
    String? accessRightInd,
    int? setupId,
    int? moduleId,
    int? uId,
    int? ettyId,
    String? apps,
    int? grpId,
    int? parentId,
    int? levelId,
  }) {
    return Accessmodel(
      dscp: dscp ?? this.dscp,
      moduleName: moduleName ?? this.moduleName,
      moduleType: moduleType ?? this.moduleType,
      accessRightInd: accessRightInd ?? this.accessRightInd,
      setupId: setupId ?? this.setupId,
      moduleId: moduleId ?? this.moduleId,
      uId: uId ?? this.uId,
      ettyId: ettyId ?? this.ettyId,
      apps: apps ?? this.apps,
      grpId: grpId ?? this.grpId,
      parentId: parentId ?? this.parentId,
      levelId: levelId ?? this.levelId,
    );
  }

  @override
  List<Object?> get props {
    return [
      dscp,
      moduleName,
      moduleType,
      accessRightInd,
      setupId,
      moduleId,
      uId,
      ettyId,
      apps,
      grpId,
      parentId,
      levelId,
    ];
  }
}
