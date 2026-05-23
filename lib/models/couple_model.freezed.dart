// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'couple_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CoupleModel _$CoupleModelFromJson(Map<String, dynamic> json) {
  return _CoupleModel.fromJson(json);
}

/// @nodoc
mixin _$CoupleModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'invite_code')
  String get inviteCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'partner_1_id')
  String? get partner1Id => throw _privateConstructorUsedError;
  @JsonKey(name: 'partner_2_id')
  String? get partner2Id => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this CoupleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CoupleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoupleModelCopyWith<CoupleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoupleModelCopyWith<$Res> {
  factory $CoupleModelCopyWith(
          CoupleModel value, $Res Function(CoupleModel) then) =
      _$CoupleModelCopyWithImpl<$Res, CoupleModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'invite_code') String inviteCode,
      @JsonKey(name: 'partner_1_id') String? partner1Id,
      @JsonKey(name: 'partner_2_id') String? partner2Id,
      @JsonKey(name: 'is_active') bool isActive});
}

/// @nodoc
class _$CoupleModelCopyWithImpl<$Res, $Val extends CoupleModel>
    implements $CoupleModelCopyWith<$Res> {
  _$CoupleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoupleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? inviteCode = null,
    Object? partner1Id = freezed,
    Object? partner2Id = freezed,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      partner1Id: freezed == partner1Id
          ? _value.partner1Id
          : partner1Id // ignore: cast_nullable_to_non_nullable
              as String?,
      partner2Id: freezed == partner2Id
          ? _value.partner2Id
          : partner2Id // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CoupleModelImplCopyWith<$Res>
    implements $CoupleModelCopyWith<$Res> {
  factory _$$CoupleModelImplCopyWith(
          _$CoupleModelImpl value, $Res Function(_$CoupleModelImpl) then) =
      __$$CoupleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'invite_code') String inviteCode,
      @JsonKey(name: 'partner_1_id') String? partner1Id,
      @JsonKey(name: 'partner_2_id') String? partner2Id,
      @JsonKey(name: 'is_active') bool isActive});
}

/// @nodoc
class __$$CoupleModelImplCopyWithImpl<$Res>
    extends _$CoupleModelCopyWithImpl<$Res, _$CoupleModelImpl>
    implements _$$CoupleModelImplCopyWith<$Res> {
  __$$CoupleModelImplCopyWithImpl(
      _$CoupleModelImpl _value, $Res Function(_$CoupleModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CoupleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? inviteCode = null,
    Object? partner1Id = freezed,
    Object? partner2Id = freezed,
    Object? isActive = null,
  }) {
    return _then(_$CoupleModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      partner1Id: freezed == partner1Id
          ? _value.partner1Id
          : partner1Id // ignore: cast_nullable_to_non_nullable
              as String?,
      partner2Id: freezed == partner2Id
          ? _value.partner2Id
          : partner2Id // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CoupleModelImpl implements _CoupleModel {
  const _$CoupleModelImpl(
      {required this.id,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'invite_code') required this.inviteCode,
      @JsonKey(name: 'partner_1_id') this.partner1Id,
      @JsonKey(name: 'partner_2_id') this.partner2Id,
      @JsonKey(name: 'is_active') required this.isActive});

  factory _$CoupleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoupleModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'invite_code')
  final String inviteCode;
  @override
  @JsonKey(name: 'partner_1_id')
  final String? partner1Id;
  @override
  @JsonKey(name: 'partner_2_id')
  final String? partner2Id;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'CoupleModel(id: $id, createdAt: $createdAt, inviteCode: $inviteCode, partner1Id: $partner1Id, partner2Id: $partner2Id, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoupleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.partner1Id, partner1Id) ||
                other.partner1Id == partner1Id) &&
            (identical(other.partner2Id, partner2Id) ||
                other.partner2Id == partner2Id) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, createdAt, inviteCode, partner1Id, partner2Id, isActive);

  /// Create a copy of CoupleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoupleModelImplCopyWith<_$CoupleModelImpl> get copyWith =>
      __$$CoupleModelImplCopyWithImpl<_$CoupleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoupleModelImplToJson(
      this,
    );
  }
}

abstract class _CoupleModel implements CoupleModel {
  const factory _CoupleModel(
          {required final String id,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'invite_code') required final String inviteCode,
          @JsonKey(name: 'partner_1_id') final String? partner1Id,
          @JsonKey(name: 'partner_2_id') final String? partner2Id,
          @JsonKey(name: 'is_active') required final bool isActive}) =
      _$CoupleModelImpl;

  factory _CoupleModel.fromJson(Map<String, dynamic> json) =
      _$CoupleModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'invite_code')
  String get inviteCode;
  @override
  @JsonKey(name: 'partner_1_id')
  String? get partner1Id;
  @override
  @JsonKey(name: 'partner_2_id')
  String? get partner2Id;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of CoupleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoupleModelImplCopyWith<_$CoupleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
