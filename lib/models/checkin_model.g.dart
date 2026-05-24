// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CheckinModelImpl _$$CheckinModelImplFromJson(Map<String, dynamic> json) =>
    _$CheckinModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      coupleId: json['couple_id'] as String,
      moodEmoji: json['mood_emoji'] as String,
      moodLabel: json['mood_label'] as String,
      affectionScore: (json['affection_score'] as num).toInt(),
      stressScore: (json['stress_score'] as num).toInt(),
      energyScore: (json['energy_score'] as num).toInt(),
      journalNote: json['journal_note'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      sharedAt: DateTime.parse(json['shared_at'] as String),
    );

Map<String, dynamic> _$$CheckinModelImplToJson(_$CheckinModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'couple_id': instance.coupleId,
      'mood_emoji': instance.moodEmoji,
      'mood_label': instance.moodLabel,
      'affection_score': instance.affectionScore,
      'stress_score': instance.stressScore,
      'energy_score': instance.energyScore,
      'journal_note': instance.journalNote,
      'created_at': instance.createdAt.toIso8601String(),
      'shared_at': instance.sharedAt.toIso8601String(),
    };
