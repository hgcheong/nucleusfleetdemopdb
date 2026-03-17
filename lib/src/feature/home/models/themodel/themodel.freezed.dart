// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'themodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Themodel {
  @JsonKey(name: 'CmpyName')
  String? get cmpyName;
  @JsonKey(name: 'AgrmtNo')
  String? get agrmtNo;
  @JsonKey(name: 'AgrmtDate')
  String? get agrmtDate;
  @JsonKey(name: 'CmpyType')
  String? get cmpyType;
  @JsonKey(name: 'RgstionName')
  String? get rgstionName;
  @JsonKey(name: 'RgstionNo')
  String? get rgstionNo;
  @JsonKey(name: 'RgstionDate')
  String? get rgstionDate;
  @JsonKey(name: 'BusnType')
  String? get busnType;
  @JsonKey(name: 'SegmtType')
  dynamic get segmtType;
  @JsonKey(name: 'ApplRef')
  String? get applRef;
  @JsonKey(name: 'ApplSrc')
  String? get applSrc;
  @JsonKey(name: 'SubmtDate')
  String? get submtDate;
  @JsonKey(name: 'AcctMgrName')
  String? get acctMgrName;
  @JsonKey(name: 'TaxCtgry')
  String? get taxCtgry;
  @JsonKey(name: 'TaxNo')
  String? get taxNo;
  @JsonKey(name: 'CmpySize')
  dynamic get cmpySize;
  @JsonKey(name: 'DedupInd')
  String? get dedupInd;
  @JsonKey(name: 'MchtSts')
  dynamic get mchtSts;

  /// Create a copy of Themodel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ThemodelCopyWith<Themodel> get copyWith =>
      _$ThemodelCopyWithImpl<Themodel>(this as Themodel, _$identity);

  /// Serializes this Themodel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Themodel &&
            (identical(other.cmpyName, cmpyName) ||
                other.cmpyName == cmpyName) &&
            (identical(other.agrmtNo, agrmtNo) || other.agrmtNo == agrmtNo) &&
            (identical(other.agrmtDate, agrmtDate) ||
                other.agrmtDate == agrmtDate) &&
            (identical(other.cmpyType, cmpyType) ||
                other.cmpyType == cmpyType) &&
            (identical(other.rgstionName, rgstionName) ||
                other.rgstionName == rgstionName) &&
            (identical(other.rgstionNo, rgstionNo) ||
                other.rgstionNo == rgstionNo) &&
            (identical(other.rgstionDate, rgstionDate) ||
                other.rgstionDate == rgstionDate) &&
            (identical(other.busnType, busnType) ||
                other.busnType == busnType) &&
            const DeepCollectionEquality().equals(other.segmtType, segmtType) &&
            (identical(other.applRef, applRef) || other.applRef == applRef) &&
            (identical(other.applSrc, applSrc) || other.applSrc == applSrc) &&
            (identical(other.submtDate, submtDate) ||
                other.submtDate == submtDate) &&
            (identical(other.acctMgrName, acctMgrName) ||
                other.acctMgrName == acctMgrName) &&
            (identical(other.taxCtgry, taxCtgry) ||
                other.taxCtgry == taxCtgry) &&
            (identical(other.taxNo, taxNo) || other.taxNo == taxNo) &&
            const DeepCollectionEquality().equals(other.cmpySize, cmpySize) &&
            (identical(other.dedupInd, dedupInd) ||
                other.dedupInd == dedupInd) &&
            const DeepCollectionEquality().equals(other.mchtSts, mchtSts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      cmpyName,
      agrmtNo,
      agrmtDate,
      cmpyType,
      rgstionName,
      rgstionNo,
      rgstionDate,
      busnType,
      const DeepCollectionEquality().hash(segmtType),
      applRef,
      applSrc,
      submtDate,
      acctMgrName,
      taxCtgry,
      taxNo,
      const DeepCollectionEquality().hash(cmpySize),
      dedupInd,
      const DeepCollectionEquality().hash(mchtSts));

  @override
  String toString() {
    return 'Themodel(cmpyName: $cmpyName, agrmtNo: $agrmtNo, agrmtDate: $agrmtDate, cmpyType: $cmpyType, rgstionName: $rgstionName, rgstionNo: $rgstionNo, rgstionDate: $rgstionDate, busnType: $busnType, segmtType: $segmtType, applRef: $applRef, applSrc: $applSrc, submtDate: $submtDate, acctMgrName: $acctMgrName, taxCtgry: $taxCtgry, taxNo: $taxNo, cmpySize: $cmpySize, dedupInd: $dedupInd, mchtSts: $mchtSts)';
  }
}

/// @nodoc
abstract mixin class $ThemodelCopyWith<$Res> {
  factory $ThemodelCopyWith(Themodel value, $Res Function(Themodel) _then) =
      _$ThemodelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'CmpyName') String? cmpyName,
      @JsonKey(name: 'AgrmtNo') String? agrmtNo,
      @JsonKey(name: 'AgrmtDate') String? agrmtDate,
      @JsonKey(name: 'CmpyType') String? cmpyType,
      @JsonKey(name: 'RgstionName') String? rgstionName,
      @JsonKey(name: 'RgstionNo') String? rgstionNo,
      @JsonKey(name: 'RgstionDate') String? rgstionDate,
      @JsonKey(name: 'BusnType') String? busnType,
      @JsonKey(name: 'SegmtType') dynamic segmtType,
      @JsonKey(name: 'ApplRef') String? applRef,
      @JsonKey(name: 'ApplSrc') String? applSrc,
      @JsonKey(name: 'SubmtDate') String? submtDate,
      @JsonKey(name: 'AcctMgrName') String? acctMgrName,
      @JsonKey(name: 'TaxCtgry') String? taxCtgry,
      @JsonKey(name: 'TaxNo') String? taxNo,
      @JsonKey(name: 'CmpySize') dynamic cmpySize,
      @JsonKey(name: 'DedupInd') String? dedupInd,
      @JsonKey(name: 'MchtSts') dynamic mchtSts});
}

/// @nodoc
class _$ThemodelCopyWithImpl<$Res> implements $ThemodelCopyWith<$Res> {
  _$ThemodelCopyWithImpl(this._self, this._then);

  final Themodel _self;
  final $Res Function(Themodel) _then;

  /// Create a copy of Themodel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cmpyName = freezed,
    Object? agrmtNo = freezed,
    Object? agrmtDate = freezed,
    Object? cmpyType = freezed,
    Object? rgstionName = freezed,
    Object? rgstionNo = freezed,
    Object? rgstionDate = freezed,
    Object? busnType = freezed,
    Object? segmtType = freezed,
    Object? applRef = freezed,
    Object? applSrc = freezed,
    Object? submtDate = freezed,
    Object? acctMgrName = freezed,
    Object? taxCtgry = freezed,
    Object? taxNo = freezed,
    Object? cmpySize = freezed,
    Object? dedupInd = freezed,
    Object? mchtSts = freezed,
  }) {
    return _then(_self.copyWith(
      cmpyName: freezed == cmpyName
          ? _self.cmpyName
          : cmpyName // ignore: cast_nullable_to_non_nullable
              as String?,
      agrmtNo: freezed == agrmtNo
          ? _self.agrmtNo
          : agrmtNo // ignore: cast_nullable_to_non_nullable
              as String?,
      agrmtDate: freezed == agrmtDate
          ? _self.agrmtDate
          : agrmtDate // ignore: cast_nullable_to_non_nullable
              as String?,
      cmpyType: freezed == cmpyType
          ? _self.cmpyType
          : cmpyType // ignore: cast_nullable_to_non_nullable
              as String?,
      rgstionName: freezed == rgstionName
          ? _self.rgstionName
          : rgstionName // ignore: cast_nullable_to_non_nullable
              as String?,
      rgstionNo: freezed == rgstionNo
          ? _self.rgstionNo
          : rgstionNo // ignore: cast_nullable_to_non_nullable
              as String?,
      rgstionDate: freezed == rgstionDate
          ? _self.rgstionDate
          : rgstionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      busnType: freezed == busnType
          ? _self.busnType
          : busnType // ignore: cast_nullable_to_non_nullable
              as String?,
      segmtType: freezed == segmtType
          ? _self.segmtType
          : segmtType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      applRef: freezed == applRef
          ? _self.applRef
          : applRef // ignore: cast_nullable_to_non_nullable
              as String?,
      applSrc: freezed == applSrc
          ? _self.applSrc
          : applSrc // ignore: cast_nullable_to_non_nullable
              as String?,
      submtDate: freezed == submtDate
          ? _self.submtDate
          : submtDate // ignore: cast_nullable_to_non_nullable
              as String?,
      acctMgrName: freezed == acctMgrName
          ? _self.acctMgrName
          : acctMgrName // ignore: cast_nullable_to_non_nullable
              as String?,
      taxCtgry: freezed == taxCtgry
          ? _self.taxCtgry
          : taxCtgry // ignore: cast_nullable_to_non_nullable
              as String?,
      taxNo: freezed == taxNo
          ? _self.taxNo
          : taxNo // ignore: cast_nullable_to_non_nullable
              as String?,
      cmpySize: freezed == cmpySize
          ? _self.cmpySize
          : cmpySize // ignore: cast_nullable_to_non_nullable
              as dynamic,
      dedupInd: freezed == dedupInd
          ? _self.dedupInd
          : dedupInd // ignore: cast_nullable_to_non_nullable
              as String?,
      mchtSts: freezed == mchtSts
          ? _self.mchtSts
          : mchtSts // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Themodel implements Themodel {
  _Themodel(
      {@JsonKey(name: 'CmpyName') this.cmpyName,
      @JsonKey(name: 'AgrmtNo') this.agrmtNo,
      @JsonKey(name: 'AgrmtDate') this.agrmtDate,
      @JsonKey(name: 'CmpyType') this.cmpyType,
      @JsonKey(name: 'RgstionName') this.rgstionName,
      @JsonKey(name: 'RgstionNo') this.rgstionNo,
      @JsonKey(name: 'RgstionDate') this.rgstionDate,
      @JsonKey(name: 'BusnType') this.busnType,
      @JsonKey(name: 'SegmtType') this.segmtType,
      @JsonKey(name: 'ApplRef') this.applRef,
      @JsonKey(name: 'ApplSrc') this.applSrc,
      @JsonKey(name: 'SubmtDate') this.submtDate,
      @JsonKey(name: 'AcctMgrName') this.acctMgrName,
      @JsonKey(name: 'TaxCtgry') this.taxCtgry,
      @JsonKey(name: 'TaxNo') this.taxNo,
      @JsonKey(name: 'CmpySize') this.cmpySize,
      @JsonKey(name: 'DedupInd') this.dedupInd,
      @JsonKey(name: 'MchtSts') this.mchtSts});
  factory _Themodel.fromJson(Map<String, dynamic> json) =>
      _$ThemodelFromJson(json);

  @override
  @JsonKey(name: 'CmpyName')
  final String? cmpyName;
  @override
  @JsonKey(name: 'AgrmtNo')
  final String? agrmtNo;
  @override
  @JsonKey(name: 'AgrmtDate')
  final String? agrmtDate;
  @override
  @JsonKey(name: 'CmpyType')
  final String? cmpyType;
  @override
  @JsonKey(name: 'RgstionName')
  final String? rgstionName;
  @override
  @JsonKey(name: 'RgstionNo')
  final String? rgstionNo;
  @override
  @JsonKey(name: 'RgstionDate')
  final String? rgstionDate;
  @override
  @JsonKey(name: 'BusnType')
  final String? busnType;
  @override
  @JsonKey(name: 'SegmtType')
  final dynamic segmtType;
  @override
  @JsonKey(name: 'ApplRef')
  final String? applRef;
  @override
  @JsonKey(name: 'ApplSrc')
  final String? applSrc;
  @override
  @JsonKey(name: 'SubmtDate')
  final String? submtDate;
  @override
  @JsonKey(name: 'AcctMgrName')
  final String? acctMgrName;
  @override
  @JsonKey(name: 'TaxCtgry')
  final String? taxCtgry;
  @override
  @JsonKey(name: 'TaxNo')
  final String? taxNo;
  @override
  @JsonKey(name: 'CmpySize')
  final dynamic cmpySize;
  @override
  @JsonKey(name: 'DedupInd')
  final String? dedupInd;
  @override
  @JsonKey(name: 'MchtSts')
  final dynamic mchtSts;

  /// Create a copy of Themodel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ThemodelCopyWith<_Themodel> get copyWith =>
      __$ThemodelCopyWithImpl<_Themodel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ThemodelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Themodel &&
            (identical(other.cmpyName, cmpyName) ||
                other.cmpyName == cmpyName) &&
            (identical(other.agrmtNo, agrmtNo) || other.agrmtNo == agrmtNo) &&
            (identical(other.agrmtDate, agrmtDate) ||
                other.agrmtDate == agrmtDate) &&
            (identical(other.cmpyType, cmpyType) ||
                other.cmpyType == cmpyType) &&
            (identical(other.rgstionName, rgstionName) ||
                other.rgstionName == rgstionName) &&
            (identical(other.rgstionNo, rgstionNo) ||
                other.rgstionNo == rgstionNo) &&
            (identical(other.rgstionDate, rgstionDate) ||
                other.rgstionDate == rgstionDate) &&
            (identical(other.busnType, busnType) ||
                other.busnType == busnType) &&
            const DeepCollectionEquality().equals(other.segmtType, segmtType) &&
            (identical(other.applRef, applRef) || other.applRef == applRef) &&
            (identical(other.applSrc, applSrc) || other.applSrc == applSrc) &&
            (identical(other.submtDate, submtDate) ||
                other.submtDate == submtDate) &&
            (identical(other.acctMgrName, acctMgrName) ||
                other.acctMgrName == acctMgrName) &&
            (identical(other.taxCtgry, taxCtgry) ||
                other.taxCtgry == taxCtgry) &&
            (identical(other.taxNo, taxNo) || other.taxNo == taxNo) &&
            const DeepCollectionEquality().equals(other.cmpySize, cmpySize) &&
            (identical(other.dedupInd, dedupInd) ||
                other.dedupInd == dedupInd) &&
            const DeepCollectionEquality().equals(other.mchtSts, mchtSts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      cmpyName,
      agrmtNo,
      agrmtDate,
      cmpyType,
      rgstionName,
      rgstionNo,
      rgstionDate,
      busnType,
      const DeepCollectionEquality().hash(segmtType),
      applRef,
      applSrc,
      submtDate,
      acctMgrName,
      taxCtgry,
      taxNo,
      const DeepCollectionEquality().hash(cmpySize),
      dedupInd,
      const DeepCollectionEquality().hash(mchtSts));

  @override
  String toString() {
    return 'Themodel(cmpyName: $cmpyName, agrmtNo: $agrmtNo, agrmtDate: $agrmtDate, cmpyType: $cmpyType, rgstionName: $rgstionName, rgstionNo: $rgstionNo, rgstionDate: $rgstionDate, busnType: $busnType, segmtType: $segmtType, applRef: $applRef, applSrc: $applSrc, submtDate: $submtDate, acctMgrName: $acctMgrName, taxCtgry: $taxCtgry, taxNo: $taxNo, cmpySize: $cmpySize, dedupInd: $dedupInd, mchtSts: $mchtSts)';
  }
}

/// @nodoc
abstract mixin class _$ThemodelCopyWith<$Res>
    implements $ThemodelCopyWith<$Res> {
  factory _$ThemodelCopyWith(_Themodel value, $Res Function(_Themodel) _then) =
      __$ThemodelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'CmpyName') String? cmpyName,
      @JsonKey(name: 'AgrmtNo') String? agrmtNo,
      @JsonKey(name: 'AgrmtDate') String? agrmtDate,
      @JsonKey(name: 'CmpyType') String? cmpyType,
      @JsonKey(name: 'RgstionName') String? rgstionName,
      @JsonKey(name: 'RgstionNo') String? rgstionNo,
      @JsonKey(name: 'RgstionDate') String? rgstionDate,
      @JsonKey(name: 'BusnType') String? busnType,
      @JsonKey(name: 'SegmtType') dynamic segmtType,
      @JsonKey(name: 'ApplRef') String? applRef,
      @JsonKey(name: 'ApplSrc') String? applSrc,
      @JsonKey(name: 'SubmtDate') String? submtDate,
      @JsonKey(name: 'AcctMgrName') String? acctMgrName,
      @JsonKey(name: 'TaxCtgry') String? taxCtgry,
      @JsonKey(name: 'TaxNo') String? taxNo,
      @JsonKey(name: 'CmpySize') dynamic cmpySize,
      @JsonKey(name: 'DedupInd') String? dedupInd,
      @JsonKey(name: 'MchtSts') dynamic mchtSts});
}

/// @nodoc
class __$ThemodelCopyWithImpl<$Res> implements _$ThemodelCopyWith<$Res> {
  __$ThemodelCopyWithImpl(this._self, this._then);

  final _Themodel _self;
  final $Res Function(_Themodel) _then;

  /// Create a copy of Themodel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cmpyName = freezed,
    Object? agrmtNo = freezed,
    Object? agrmtDate = freezed,
    Object? cmpyType = freezed,
    Object? rgstionName = freezed,
    Object? rgstionNo = freezed,
    Object? rgstionDate = freezed,
    Object? busnType = freezed,
    Object? segmtType = freezed,
    Object? applRef = freezed,
    Object? applSrc = freezed,
    Object? submtDate = freezed,
    Object? acctMgrName = freezed,
    Object? taxCtgry = freezed,
    Object? taxNo = freezed,
    Object? cmpySize = freezed,
    Object? dedupInd = freezed,
    Object? mchtSts = freezed,
  }) {
    return _then(_Themodel(
      cmpyName: freezed == cmpyName
          ? _self.cmpyName
          : cmpyName // ignore: cast_nullable_to_non_nullable
              as String?,
      agrmtNo: freezed == agrmtNo
          ? _self.agrmtNo
          : agrmtNo // ignore: cast_nullable_to_non_nullable
              as String?,
      agrmtDate: freezed == agrmtDate
          ? _self.agrmtDate
          : agrmtDate // ignore: cast_nullable_to_non_nullable
              as String?,
      cmpyType: freezed == cmpyType
          ? _self.cmpyType
          : cmpyType // ignore: cast_nullable_to_non_nullable
              as String?,
      rgstionName: freezed == rgstionName
          ? _self.rgstionName
          : rgstionName // ignore: cast_nullable_to_non_nullable
              as String?,
      rgstionNo: freezed == rgstionNo
          ? _self.rgstionNo
          : rgstionNo // ignore: cast_nullable_to_non_nullable
              as String?,
      rgstionDate: freezed == rgstionDate
          ? _self.rgstionDate
          : rgstionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      busnType: freezed == busnType
          ? _self.busnType
          : busnType // ignore: cast_nullable_to_non_nullable
              as String?,
      segmtType: freezed == segmtType
          ? _self.segmtType
          : segmtType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      applRef: freezed == applRef
          ? _self.applRef
          : applRef // ignore: cast_nullable_to_non_nullable
              as String?,
      applSrc: freezed == applSrc
          ? _self.applSrc
          : applSrc // ignore: cast_nullable_to_non_nullable
              as String?,
      submtDate: freezed == submtDate
          ? _self.submtDate
          : submtDate // ignore: cast_nullable_to_non_nullable
              as String?,
      acctMgrName: freezed == acctMgrName
          ? _self.acctMgrName
          : acctMgrName // ignore: cast_nullable_to_non_nullable
              as String?,
      taxCtgry: freezed == taxCtgry
          ? _self.taxCtgry
          : taxCtgry // ignore: cast_nullable_to_non_nullable
              as String?,
      taxNo: freezed == taxNo
          ? _self.taxNo
          : taxNo // ignore: cast_nullable_to_non_nullable
              as String?,
      cmpySize: freezed == cmpySize
          ? _self.cmpySize
          : cmpySize // ignore: cast_nullable_to_non_nullable
              as dynamic,
      dedupInd: freezed == dedupInd
          ? _self.dedupInd
          : dedupInd // ignore: cast_nullable_to_non_nullable
              as String?,
      mchtSts: freezed == mchtSts
          ? _self.mchtSts
          : mchtSts // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

// dart format on
