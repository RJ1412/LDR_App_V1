// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CheckinModel _$CheckinModelFromJson(Map<String, dynamic> json) {
  return _CheckinModel.fromJson(json);
}

/// @nodoc
mixin _$CheckinModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'couple_id')
  String get coupleId => throw _privateConstructorUsedError;
  @JsonKey(name: 'mood_emoji')
  String get moodEmoji => throw _privateConstructorUsedError;
  @JsonKey(name: 'mood_label')
  String get moodLabel => throw _privateConstructorUsedError;
  @JsonKey(name: 'affection_score')
  int get affectionScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'stress_score')
  int get stressScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'energy_score')
  int get energyScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'journal_note')
  String? get journalNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'shared_at')
  DateTime get sharedAt => throw _privateConstructorUsedError;

  /// Serializes this CheckinModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CheckinModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckinModelCopyWith<CheckinModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckinModelCopyWith<$Res> {
  factory $CheckinModelCopyWith(
          CheckinModel value, $Res Function(CheckinModel) then) =
      _$CheckinModelCopyWithImpl<$Res, CheckinModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'couple_id') String coupleId,
      @JsonKey(name: 'mood_emoji') String moodEmoji,
      @JsonKey(name: 'mood_label') String moodLabel,
      @JsonKey(name: 'affection_score') int affectionScore,
      @JsonKey(name: 'stress_score') int stressScore,
      @JsonKey(name: 'energy_score') int energyScore,
      @JsonKey(name: 'journal_note') String? journalNote,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'shared_at') DateTime sharedAt});
}

/// @nodoc
class _$CheckinModelCopyWithImpl<$Res, $Val extends CheckinModel>
    implements $CheckinModelCopyWith<$Res> {
  _$CheckinModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckinModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? coupleId = null,
    Object? moodEmoji = null,
    Object? moodLabel = null,
    Object? affectionScore = null,
    Object? stressScore = null,
    Object? energyScore = null,
    Object? journalNote = freezed,
    Object? createdAt = null,
    Object? sharedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      coupleId: null == coupleId
          ? _value.coupleId
          : coupleId // ignore: cast_nullable_to_non_nullable
              as String,
      moodEmoji: null == moodEmoji
          ? _value.moodEmoji
          : moodEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      moodLabel: null == moodLabel
          ? _value.moodLabel
          : moodLabel // ignore: cast_nullable_to_non_nullable
              as String,
      affectionScore: null == affectionScore
          ? _value.affectionScore
          : affectionScore // ignore: cast_nullable_to_non_nullable
              as int,
      stressScore: null == stressScore
          ? _value.stressScore
          : stressScore // ignore: cast_nullable_to_non_nullable
              as int,
      energyScore: null == energyScore
          ? _value.energyScore
          : energyScore // ignore: cast_nullable_to_non_nullable
              as int,
      journalNote: freezed == journalNote
          ? _value.journalNote
          : journalNote // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sharedAt: null == sharedAt
          ? _value.sharedAt
          : sharedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckinModelImplCopyWith<$Res>
    implements $CheckinModelCopyWith<$Res> {
  factory _$$CheckinModelImplCopyWith(
          _$CheckinModelImpl value, $Res Function(_$CheckinModelImpl) then) =
      __$$CheckinModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'couple_id') String coupleId,
      @JsonKey(name: 'mood_emoji') String moodEmoji,
      @JsonKey(name: 'mood_label') String moodLabel,
      @JsonKey(name: 'affection_score') int affectionScore,
      @JsonKey(name: 'stress_score') int stressScore,
      @JsonKey(name: 'energy_score') int energyScore,
      @JsonKey(name: 'journal_note') String? journalNote,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'shared_at') DateTime sharedAt});
}

/// @nodoc
class __$$CheckinModelImplCopyWithImpl<$Res>
    extends _$CheckinModelCopyWithImpl<$Res, _$CheckinModelImpl>
    implements _$$CheckinModelImplCopyWith<$Res> {
  __$$CheckinModelImplCopyWithImpl(
      _$CheckinModelImpl _value, $Res Function(_$CheckinModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckinModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? coupleId = null,
    Object? moodEmoji = null,
    Object? moodLabel = null,
    Object? affectionScore = null,
    Object? stressScore = null,
    Object? energyScore = null,
    Object? journalNote = freezed,
    Object? createdAt = null,
    Object? sharedAt = null,
  }) {
    return _then(_$CheckinModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      coupleId: null == coupleId
          ? _value.coupleId
          : coupleId // ignore: cast_nullable_to_non_nullable
              as String,
      moodEmoji: null == moodEmoji
          ? _value.moodEmoji
          : moodEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      moodLabel: null == moodLabel
          ? _value.moodLabel
          : moodLabel // ignore: cast_nullable_to_non_nullable
              as String,
      affectionScore: null == affectionScore
          ? _value.affectionScore
          : affectionScore // ignore: cast_nullable_to_non_nullable
              as int,
      stressScore: null == stressScore
          ? _value.stressScore
          : stressScore // ignore: cast_nullable_to_non_nullable
              as int,
      energyScore: null == energyScore
          ? _value.energyScore
          : energyScore // ignore: cast_nullable_to_non_nullable
              as int,
      journalNote: freezed == journalNote
          ? _value.journalNote
          : journalNote // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sharedAt: null == sharedAt
          ? _value.sharedAt
          : sharedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckinModelImpl implements _CheckinModel {
  const _$CheckinModelImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'couple_id') required this.coupleId,
      @JsonKey(name: 'mood_emoji') required this.moodEmoji,
      @JsonKey(name: 'mood_label') required this.moodLabel,
      @JsonKey(name: 'affection_score') required this.affectionScore,
      @JsonKey(name: 'stress_score') required this.stressScore,
      @JsonKey(name: 'energy_score') required this.energyScore,
      @JsonKey(name: 'journal_note') this.journalNote,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'shared_at') required this.sharedAt});

  factory _$CheckinModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckinModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'couple_id')
  final String coupleId;
  @override
  @JsonKey(name: 'mood_emoji')
  final String moodEmoji;
  @override
  @JsonKey(name: 'mood_label')
  final String moodLabel;
  @override
  @JsonKey(name: 'affection_score')
  final int affectionScore;
  @override
  @JsonKey(name: 'stress_score')
  final int stressScore;
  @override
  @JsonKey(name: 'energy_score')
  final int energyScore;
  @override
  @JsonKey(name: 'journal_note')
  final String? journalNote;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'shared_at')
  final DateTime sharedAt;

  @override
  String toString() {
    return 'CheckinModel(id: $id, userId: $userId, coupleId: $coupleId, moodEmoji: $moodEmoji, moodLabel: $moodLabel, affectionScore: $affectionScore, stressScore: $stressScore, energyScore: $energyScore, journalNote: $journalNote, createdAt: $createdAt, sharedAt: $sharedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckinModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.coupleId, coupleId) ||
                other.coupleId == coupleId) &&
            (identical(other.moodEmoji, moodEmoji) ||
                other.moodEmoji == moodEmoji) &&
            (identical(other.moodLabel, moodLabel) ||
                other.moodLabel == moodLabel) &&
            (identical(other.affectionScore, affectionScore) ||
                other.affectionScore == affectionScore) &&
            (identical(other.stressScore, stressScore) ||
                other.stressScore == stressScore) &&
            (identical(other.energyScore, energyScore) ||
                other.energyScore == energyScore) &&
            (identical(other.journalNote, journalNote) ||
                other.journalNote == journalNote) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.sharedAt, sharedAt) ||
                other.sharedAt == sharedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      coupleId,
      moodEmoji,
      moodLabel,
      affectionScore,
      stressScore,
      energyScore,
      journalNote,
      createdAt,
      sharedAt);

  /// Create a copy of CheckinModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckinModelImplCopyWith<_$CheckinModelImpl> get copyWith =>
      __$$CheckinModelImplCopyWithImpl<_$CheckinModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckinModelImplToJson(
      this,
    );
  }
}

abstract class _CheckinModel implements CheckinModel {
  const factory _CheckinModel(
          {required final String id,
          @JsonKey(name: 'user_id') required final String userId,
          @JsonKey(name: 'couple_id') required final String coupleId,
          @JsonKey(name: 'mood_emoji') required final String moodEmoji,
          @JsonKey(name: 'mood_label') required final String moodLabel,
          @JsonKey(name: 'affection_score') required final int affectionScore,
          @JsonKey(name: 'stress_score') required final int stressScore,
          @JsonKey(name: 'energy_score') required final int energyScore,
          @JsonKey(name: 'journal_note') final String? journalNote,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'shared_at') required final DateTime sharedAt}) =
      _$CheckinModelImpl;

  factory _CheckinModel.fromJson(Map<String, dynamic> json) =
      _$CheckinModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'couple_id')
  String get coupleId;
  @override
  @JsonKey(name: 'mood_emoji')
  String get moodEmoji;
  @override
  @JsonKey(name: 'mood_label')
  String get moodLabel;
  @override
  @JsonKey(name: 'affection_score')
  int get affectionScore;
  @override
  @JsonKey(name: 'stress_score')
  int get stressScore;
  @override
  @JsonKey(name: 'energy_score')
  int get energyScore;
  @override
  @JsonKey(name: 'journal_note')
  String? get journalNote;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'shared_at')
  DateTime get sharedAt;

  /// Create a copy of CheckinModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckinModelImplCopyWith<_$CheckinModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
