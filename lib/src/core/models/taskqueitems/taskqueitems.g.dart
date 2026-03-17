// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskqueitems.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Taskqueitems _$TaskqueitemsFromJson(Map<String, dynamic> json) => Taskqueitems(
      wfPrcsDscp: json['WfPrcsDscp'] as String?,
      refTo: json['RefTo'] as String?,
      refNo: json['RefNo'] as String?,
      refNote: json['RefNote'] as String?,
      finDate: json['FinDate'] as String?,
      prgDscp: json['PrgDscp'] as String?,
      reqCrLimit: (json['ReqCrLimit'] as num?)?.toInt(),
      proposedCrLimit: (json['ProposedCrLimit'] as num?)?.toInt(),
      crRiskDscp: json['CrRiskDscp'],
      crCtgryDscp: json['CrCtgryDscp'],
      crtionDate: json['CrtionDate'] == null
          ? null
          : DateTime.parse(json['CrtionDate'] as String),
      crtBy: json['CrtBy'] as String?,
      actDate: json['ActDate'],
      actBy: json['ActBy'],
      actStsDscp: json['ActStsDscp'] as String?,
      actSts: json['ActSts'] as String?,
      wfPrcsTaskId: (json['WfPrcsTaskId'] as num?)?.toInt(),
      wfTaskId: (json['WfTaskId'] as num?)?.toInt(),
      wfPrcsTaskDscp: json['WfPrcsTaskDscp'] as String?,
      seq: (json['Seq'] as num?)?.toInt(),
      wfPrcsId: (json['WfPrcsId'] as num?)?.toInt(),
      recId: (json['RecId'] as num?)?.toInt(),
      asgnToGrp: (json['AsgnToGrp'] as num?)?.toInt(),
      asgnToUser: json['AsgnToUser'] as String?,
      note: json['Note'],
      taskId: (json['TaskId'] as num?)?.toInt(),
      taskSts: json['TaskSts'] as String?,
      taskStsDscp: json['TaskStsDscp'] as String?,
      wfCd: json['WfCd'] as String?,
      crRiskCd: json['CrRiskCd'],
      crCtgryCd: json['CrCtgryCd'],
      appvlSp: json['AppvlSp'] as String?,
      rtnSp: json['RtnSp'],
      rejSp: json['RejSp'] as String?,
    );

Map<String, dynamic> _$TaskqueitemsToJson(Taskqueitems instance) =>
    <String, dynamic>{
      'WfPrcsDscp': instance.wfPrcsDscp,
      'RefTo': instance.refTo,
      'RefNo': instance.refNo,
      'RefNote': instance.refNote,
      'FinDate': instance.finDate,
      'PrgDscp': instance.prgDscp,
      'ReqCrLimit': instance.reqCrLimit,
      'ProposedCrLimit': instance.proposedCrLimit,
      'CrRiskDscp': instance.crRiskDscp,
      'CrCtgryDscp': instance.crCtgryDscp,
      'CrtionDate': instance.crtionDate?.toIso8601String(),
      'CrtBy': instance.crtBy,
      'ActDate': instance.actDate,
      'ActBy': instance.actBy,
      'ActStsDscp': instance.actStsDscp,
      'ActSts': instance.actSts,
      'WfPrcsTaskId': instance.wfPrcsTaskId,
      'WfTaskId': instance.wfTaskId,
      'WfPrcsTaskDscp': instance.wfPrcsTaskDscp,
      'Seq': instance.seq,
      'WfPrcsId': instance.wfPrcsId,
      'RecId': instance.recId,
      'AsgnToGrp': instance.asgnToGrp,
      'AsgnToUser': instance.asgnToUser,
      'Note': instance.note,
      'TaskId': instance.taskId,
      'TaskSts': instance.taskSts,
      'TaskStsDscp': instance.taskStsDscp,
      'WfCd': instance.wfCd,
      'CrRiskCd': instance.crRiskCd,
      'CrCtgryCd': instance.crCtgryCd,
      'AppvlSp': instance.appvlSp,
      'RtnSp': instance.rtnSp,
      'RejSp': instance.rejSp,
    };
