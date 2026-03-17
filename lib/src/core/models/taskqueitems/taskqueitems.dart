import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'taskqueitems.g.dart';

@JsonSerializable()
class Taskqueitems extends Equatable {
  @JsonKey(name: 'WfPrcsDscp')
  final String? wfPrcsDscp;
  @JsonKey(name: 'RefTo')
  final String? refTo;
  @JsonKey(name: 'RefNo')
  final String? refNo;
  @JsonKey(name: 'RefNote')
  final String? refNote;
  @JsonKey(name: 'FinDate')
  final String? finDate;
  @JsonKey(name: 'PrgDscp')
  final String? prgDscp;
  @JsonKey(name: 'ReqCrLimit')
  final int? reqCrLimit;
  @JsonKey(name: 'ProposedCrLimit')
  final int? proposedCrLimit;
  @JsonKey(name: 'CrRiskDscp')
  final dynamic crRiskDscp;
  @JsonKey(name: 'CrCtgryDscp')
  final dynamic crCtgryDscp;
  @JsonKey(name: 'CrtionDate')
  final DateTime? crtionDate;
  @JsonKey(name: 'CrtBy')
  final String? crtBy;
  @JsonKey(name: 'ActDate')
  final dynamic actDate;
  @JsonKey(name: 'ActBy')
  final dynamic actBy;
  @JsonKey(name: 'ActStsDscp')
  final String? actStsDscp;
  @JsonKey(name: 'ActSts')
  final String? actSts;
  @JsonKey(name: 'WfPrcsTaskId')
  final int? wfPrcsTaskId;
  @JsonKey(name: 'WfTaskId')
  final int? wfTaskId;
  @JsonKey(name: 'WfPrcsTaskDscp')
  final String? wfPrcsTaskDscp;
  @JsonKey(name: 'Seq')
  final int? seq;
  @JsonKey(name: 'WfPrcsId')
  final int? wfPrcsId;
  @JsonKey(name: 'RecId')
  final int? recId;
  @JsonKey(name: 'AsgnToGrp')
  final int? asgnToGrp;
  @JsonKey(name: 'AsgnToUser')
  final String? asgnToUser;
  @JsonKey(name: 'Note')
  final dynamic note;
  @JsonKey(name: 'TaskId')
  final int? taskId;
  @JsonKey(name: 'TaskSts')
  final String? taskSts;
  @JsonKey(name: 'TaskStsDscp')
  final String? taskStsDscp;
  @JsonKey(name: 'WfCd')
  final String? wfCd;
  @JsonKey(name: 'CrRiskCd')
  final dynamic crRiskCd;
  @JsonKey(name: 'CrCtgryCd')
  final dynamic crCtgryCd;
  @JsonKey(name: 'AppvlSp')
  final String? appvlSp;
  @JsonKey(name: 'RtnSp')
  final dynamic rtnSp;
  @JsonKey(name: 'RejSp')
  final String? rejSp;

  const Taskqueitems({
    this.wfPrcsDscp,
    this.refTo,
    this.refNo,
    this.refNote,
    this.finDate,
    this.prgDscp,
    this.reqCrLimit,
    this.proposedCrLimit,
    this.crRiskDscp,
    this.crCtgryDscp,
    this.crtionDate,
    this.crtBy,
    this.actDate,
    this.actBy,
    this.actStsDscp,
    this.actSts,
    this.wfPrcsTaskId,
    this.wfTaskId,
    this.wfPrcsTaskDscp,
    this.seq,
    this.wfPrcsId,
    this.recId,
    this.asgnToGrp,
    this.asgnToUser,
    this.note,
    this.taskId,
    this.taskSts,
    this.taskStsDscp,
    this.wfCd,
    this.crRiskCd,
    this.crCtgryCd,
    this.appvlSp,
    this.rtnSp,
    this.rejSp,
  });

  factory Taskqueitems.fromJson(Map<String, dynamic> json) {
    return _$TaskqueitemsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TaskqueitemsToJson(this);

  static List<Taskqueitems> fromJsonList(List list) {
    return list.map((item) => Taskqueitems.fromJson(item)).toList();
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      wfPrcsDscp,
      refTo,
      refNo,
      refNote,
      finDate,
      prgDscp,
      reqCrLimit,
      proposedCrLimit,
      crRiskDscp,
      crCtgryDscp,
      crtionDate,
      crtBy,
      actDate,
      actBy,
      actStsDscp,
      actSts,
      wfPrcsTaskId,
      wfTaskId,
      wfPrcsTaskDscp,
      seq,
      wfPrcsId,
      recId,
      asgnToGrp,
      asgnToUser,
      note,
      taskId,
      taskSts,
      taskStsDscp,
      wfCd,
      crRiskCd,
      crCtgryCd,
      appvlSp,
      rtnSp,
      rejSp,
    ];
  }
}
