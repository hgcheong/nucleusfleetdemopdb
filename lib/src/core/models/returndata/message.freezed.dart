// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Message {
  int? get msgId;
  String? get dscp;
  int? get msgSeverity;
  int? get bitInd;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageCopyWith<Message> get copyWith =>
      _$MessageCopyWithImpl<Message>(this as Message, _$identity);

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Message &&
            (identical(other.msgId, msgId) || other.msgId == msgId) &&
            (identical(other.dscp, dscp) || other.dscp == dscp) &&
            (identical(other.msgSeverity, msgSeverity) ||
                other.msgSeverity == msgSeverity) &&
            (identical(other.bitInd, bitInd) || other.bitInd == bitInd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, msgId, dscp, msgSeverity, bitInd);

  @override
  String toString() {
    return 'Message(msgId: $msgId, dscp: $dscp, msgSeverity: $msgSeverity, bitInd: $bitInd)';
  }
}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) =
      _$MessageCopyWithImpl;
  @useResult
  $Res call({int? msgId, String? dscp, int? msgSeverity, int? bitInd});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res> implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message _self;
  final $Res Function(Message) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msgId = freezed,
    Object? dscp = freezed,
    Object? msgSeverity = freezed,
    Object? bitInd = freezed,
  }) {
    return _then(_self.copyWith(
      msgId: freezed == msgId
          ? _self.msgId
          : msgId // ignore: cast_nullable_to_non_nullable
              as int?,
      dscp: freezed == dscp
          ? _self.dscp
          : dscp // ignore: cast_nullable_to_non_nullable
              as String?,
      msgSeverity: freezed == msgSeverity
          ? _self.msgSeverity
          : msgSeverity // ignore: cast_nullable_to_non_nullable
              as int?,
      bitInd: freezed == bitInd
          ? _self.bitInd
          : bitInd // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Message implements Message {
  _Message({this.msgId, this.dscp, this.msgSeverity, this.bitInd});
  factory _Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  @override
  final int? msgId;
  @override
  final String? dscp;
  @override
  final int? msgSeverity;
  @override
  final int? bitInd;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageCopyWith<_Message> get copyWith =>
      __$MessageCopyWithImpl<_Message>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Message &&
            (identical(other.msgId, msgId) || other.msgId == msgId) &&
            (identical(other.dscp, dscp) || other.dscp == dscp) &&
            (identical(other.msgSeverity, msgSeverity) ||
                other.msgSeverity == msgSeverity) &&
            (identical(other.bitInd, bitInd) || other.bitInd == bitInd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, msgId, dscp, msgSeverity, bitInd);

  @override
  String toString() {
    return 'Message(msgId: $msgId, dscp: $dscp, msgSeverity: $msgSeverity, bitInd: $bitInd)';
  }
}

/// @nodoc
abstract mixin class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) _then) =
      __$MessageCopyWithImpl;
  @override
  @useResult
  $Res call({int? msgId, String? dscp, int? msgSeverity, int? bitInd});
}

/// @nodoc
class __$MessageCopyWithImpl<$Res> implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(this._self, this._then);

  final _Message _self;
  final $Res Function(_Message) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? msgId = freezed,
    Object? dscp = freezed,
    Object? msgSeverity = freezed,
    Object? bitInd = freezed,
  }) {
    return _then(_Message(
      msgId: freezed == msgId
          ? _self.msgId
          : msgId // ignore: cast_nullable_to_non_nullable
              as int?,
      dscp: freezed == dscp
          ? _self.dscp
          : dscp // ignore: cast_nullable_to_non_nullable
              as String?,
      msgSeverity: freezed == msgSeverity
          ? _self.msgSeverity
          : msgSeverity // ignore: cast_nullable_to_non_nullable
              as int?,
      bitInd: freezed == bitInd
          ? _self.bitInd
          : bitInd // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
