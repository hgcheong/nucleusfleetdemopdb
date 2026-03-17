// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {
  int get id;
  @JsonKey(defaultValue: "")
  String get uuid;
  String? get email;
  @JsonKey(defaultValue: "")
  String get name;
  @JsonKey(defaultValue: "")
  String get username;
  @JsonKey(name: 'phone_number', defaultValue: "")
  String get phoneNumber;
  @JsonKey(defaultValue: "en")
  String get language;
  @JsonKey(name: 'is_email_confirmed', defaultValue: false)
  bool get isEmailConfirmed;
  @JsonKey(name: 'is_phone_number_confirmed', defaultValue: false)
  bool get isPhoneNumberConfirmed;
  @JsonKey(name: 'is_2fa_enabled', defaultValue: false)
  bool get is2faEnabled;
  DateTime? get createdAt;
  String? get password;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserCopyWith<User> get copyWith =>
      _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is User &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.isEmailConfirmed, isEmailConfirmed) ||
                other.isEmailConfirmed == isEmailConfirmed) &&
            (identical(other.isPhoneNumberConfirmed, isPhoneNumberConfirmed) ||
                other.isPhoneNumberConfirmed == isPhoneNumberConfirmed) &&
            (identical(other.is2faEnabled, is2faEnabled) ||
                other.is2faEnabled == is2faEnabled) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      uuid,
      email,
      name,
      username,
      phoneNumber,
      language,
      isEmailConfirmed,
      isPhoneNumberConfirmed,
      is2faEnabled,
      createdAt,
      password);

  @override
  String toString() {
    return 'User(id: $id, uuid: $uuid, email: $email, name: $name, username: $username, phoneNumber: $phoneNumber, language: $language, isEmailConfirmed: $isEmailConfirmed, isPhoneNumberConfirmed: $isPhoneNumberConfirmed, is2faEnabled: $is2faEnabled, createdAt: $createdAt, password: $password)';
  }
}

/// @nodoc
abstract mixin class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) _then) =
      _$UserCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      @JsonKey(defaultValue: "") String uuid,
      String? email,
      @JsonKey(defaultValue: "") String name,
      @JsonKey(defaultValue: "") String username,
      @JsonKey(name: 'phone_number', defaultValue: "") String phoneNumber,
      @JsonKey(defaultValue: "en") String language,
      @JsonKey(name: 'is_email_confirmed', defaultValue: false)
      bool isEmailConfirmed,
      @JsonKey(name: 'is_phone_number_confirmed', defaultValue: false)
      bool isPhoneNumberConfirmed,
      @JsonKey(name: 'is_2fa_enabled', defaultValue: false) bool is2faEnabled,
      DateTime? createdAt,
      String? password});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uuid = null,
    Object? email = freezed,
    Object? name = null,
    Object? username = null,
    Object? phoneNumber = null,
    Object? language = null,
    Object? isEmailConfirmed = null,
    Object? isPhoneNumberConfirmed = null,
    Object? is2faEnabled = null,
    Object? createdAt = freezed,
    Object? password = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      uuid: null == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      isEmailConfirmed: null == isEmailConfirmed
          ? _self.isEmailConfirmed
          : isEmailConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      isPhoneNumberConfirmed: null == isPhoneNumberConfirmed
          ? _self.isPhoneNumberConfirmed
          : isPhoneNumberConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      is2faEnabled: null == is2faEnabled
          ? _self.is2faEnabled
          : is2faEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      password: freezed == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _User extends User {
  _User(
      {required this.id,
      @JsonKey(defaultValue: "") required this.uuid,
      this.email,
      @JsonKey(defaultValue: "") required this.name,
      @JsonKey(defaultValue: "") required this.username,
      @JsonKey(name: 'phone_number', defaultValue: "")
      required this.phoneNumber,
      @JsonKey(defaultValue: "en") required this.language,
      @JsonKey(name: 'is_email_confirmed', defaultValue: false)
      required this.isEmailConfirmed,
      @JsonKey(name: 'is_phone_number_confirmed', defaultValue: false)
      required this.isPhoneNumberConfirmed,
      @JsonKey(name: 'is_2fa_enabled', defaultValue: false)
      required this.is2faEnabled,
      this.createdAt,
      this.password})
      : super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(defaultValue: "")
  final String uuid;
  @override
  final String? email;
  @override
  @JsonKey(defaultValue: "")
  final String name;
  @override
  @JsonKey(defaultValue: "")
  final String username;
  @override
  @JsonKey(name: 'phone_number', defaultValue: "")
  final String phoneNumber;
  @override
  @JsonKey(defaultValue: "en")
  final String language;
  @override
  @JsonKey(name: 'is_email_confirmed', defaultValue: false)
  final bool isEmailConfirmed;
  @override
  @JsonKey(name: 'is_phone_number_confirmed', defaultValue: false)
  final bool isPhoneNumberConfirmed;
  @override
  @JsonKey(name: 'is_2fa_enabled', defaultValue: false)
  final bool is2faEnabled;
  @override
  final DateTime? createdAt;
  @override
  final String? password;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.isEmailConfirmed, isEmailConfirmed) ||
                other.isEmailConfirmed == isEmailConfirmed) &&
            (identical(other.isPhoneNumberConfirmed, isPhoneNumberConfirmed) ||
                other.isPhoneNumberConfirmed == isPhoneNumberConfirmed) &&
            (identical(other.is2faEnabled, is2faEnabled) ||
                other.is2faEnabled == is2faEnabled) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      uuid,
      email,
      name,
      username,
      phoneNumber,
      language,
      isEmailConfirmed,
      isPhoneNumberConfirmed,
      is2faEnabled,
      createdAt,
      password);

  @override
  String toString() {
    return 'User(id: $id, uuid: $uuid, email: $email, name: $name, username: $username, phoneNumber: $phoneNumber, language: $language, isEmailConfirmed: $isEmailConfirmed, isPhoneNumberConfirmed: $isPhoneNumberConfirmed, is2faEnabled: $is2faEnabled, createdAt: $createdAt, password: $password)';
  }
}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) =
      __$UserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(defaultValue: "") String uuid,
      String? email,
      @JsonKey(defaultValue: "") String name,
      @JsonKey(defaultValue: "") String username,
      @JsonKey(name: 'phone_number', defaultValue: "") String phoneNumber,
      @JsonKey(defaultValue: "en") String language,
      @JsonKey(name: 'is_email_confirmed', defaultValue: false)
      bool isEmailConfirmed,
      @JsonKey(name: 'is_phone_number_confirmed', defaultValue: false)
      bool isPhoneNumberConfirmed,
      @JsonKey(name: 'is_2fa_enabled', defaultValue: false) bool is2faEnabled,
      DateTime? createdAt,
      String? password});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? uuid = null,
    Object? email = freezed,
    Object? name = null,
    Object? username = null,
    Object? phoneNumber = null,
    Object? language = null,
    Object? isEmailConfirmed = null,
    Object? isPhoneNumberConfirmed = null,
    Object? is2faEnabled = null,
    Object? createdAt = freezed,
    Object? password = freezed,
  }) {
    return _then(_User(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      uuid: null == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      isEmailConfirmed: null == isEmailConfirmed
          ? _self.isEmailConfirmed
          : isEmailConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      isPhoneNumberConfirmed: null == isPhoneNumberConfirmed
          ? _self.isPhoneNumberConfirmed
          : isPhoneNumberConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      is2faEnabled: null == is2faEnabled
          ? _self.is2faEnabled
          : is2faEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      password: freezed == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
