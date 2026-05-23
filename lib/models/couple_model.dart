import 'package:freezed_annotation/freezed_annotation.dart';

part 'couple_model.freezed.dart';
part 'couple_model.g.dart';

@freezed
class CoupleModel with _$CoupleModel {
  const factory CoupleModel({
    required String id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'invite_code') required String inviteCode,
    @JsonKey(name: 'partner_1_id') String? partner1Id,
    @JsonKey(name: 'partner_2_id') String? partner2Id,
    @JsonKey(name: 'is_active') required bool isActive,
  }) = _CoupleModel;

  factory CoupleModel.fromJson(Map<String, dynamic> json) => _$CoupleModelFromJson(json);
}
