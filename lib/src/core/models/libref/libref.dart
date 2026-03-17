import 'package:json_annotation/json_annotation.dart';

part 'libref.g.dart';

@JsonSerializable()
class Libref {
  @JsonKey(name: 'RefType')
  String? refType;
  @JsonKey(name: 'RefCd')
  String? refCd;
  @JsonKey(name: 'Dscp')
  String? dscp;
  @JsonKey(name: 'BitInd')
  int? bitInd;
  @JsonKey(name: 'Sts')
  String? sts;

  Libref({this.refType, this.refCd, this.dscp, this.bitInd, this.sts});

  @override
  String toString() {
    //   return 'Libref(refType: $refType, refCd: $refCd, //dscp: $dscp, bitInd: $bitInd, sts: $sts)';
    return '$dscp';
  }

  factory Libref.fromJson(Map<String, dynamic> json) {
    return _$LibrefFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LibrefToJson(this);

  static List<Libref> fromJsonList(List list) {
    return list.map((item) => Libref.fromJson(item)).toList();
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(other, this)) return true;
  //   if (other is! Libref) return false;
  //   final mapEquals = const DeepCollectionEquality().equals;
  //   return mapEquals(other.toJson(), toJson());
  // }
  @override
  bool operator ==(Object other) {
    return refCd == (other as Libref).refCd;
  }

  //   bool isEqual(Libref? model) {
  //   return refCd == model?.refCd;
  // }

  @override
  int get hashCode =>
      refType.hashCode ^
      refCd.hashCode ^
      dscp.hashCode ^
      bitInd.hashCode ^
      sts.hashCode;
}
