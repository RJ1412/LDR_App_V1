// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'couple_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CoupleModelImpl _$$CoupleModelImplFromJson(Map<String, dynamic> json) =>
    _$CoupleModelImpl(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      inviteCode: json['invite_code'] as String,
      partner1Id: json['partner_1_id'] as String?,
      partner2Id: json['partner_2_id'] as String?,
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$$CoupleModelImplToJson(_$CoupleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'invite_code': instance.inviteCode,
      'partner_1_id': instance.partner1Id,
      'partner_2_id': instance.partner2Id,
      'is_active': instance.isActive,
    };
