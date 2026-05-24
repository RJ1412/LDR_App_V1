import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkin_model.freezed.dart';
part 'checkin_model.g.dart';

@freezed
class CheckinModel with _$CheckinModel {
  const factory CheckinModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'couple_id') required String coupleId,
    @JsonKey(name: 'mood_emoji') required String moodEmoji,
    @JsonKey(name: 'mood_label') required String moodLabel,
    @JsonKey(name: 'affection_score') required int affectionScore,
    @JsonKey(name: 'stress_score') required int stressScore,
    @JsonKey(name: 'energy_score') required int energyScore,
    @JsonKey(name: 'journal_note') String? journalNote,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'shared_at') required DateTime sharedAt,
  }) = _CheckinModel;

  factory CheckinModel.fromJson(Map<String, dynamic> json) =>
      _$CheckinModelFromJson(json);
}
