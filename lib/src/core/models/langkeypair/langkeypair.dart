import 'package:json_annotation/json_annotation.dart';

part 'langkeypair.g.dart';

@JsonSerializable()
class Langkeypair {
  @JsonKey(name: 'KeyVal')
  String? keyVal;
  @JsonKey(name: 'FieldNm')
  String? fieldNm;

  Langkeypair({this.keyVal, this.fieldNm});

  factory Langkeypair.fromJson(Map<String, dynamic> json) {
    return _$LangkeypairFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LangkeypairToJson(this);

  static List<Langkeypair> fromJsonList(List list) {
    return list.map((item) => Langkeypair.fromJson(item)).toList();
  }
}
