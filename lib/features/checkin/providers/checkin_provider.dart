import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/checkin_model.dart';
import '../../../services/checkin_service.dart';
import '../../auth/providers/current_user_provider.dart';
import '../../auth/providers/current_couple_provider.dart';
import '../../../core/network/supabase_client.dart';

part 'checkin_provider.g.dart';

@riverpod
class TodayCheckin extends _$TodayCheckin {
  @override
  FutureOr<CheckinModel?> build() async {
    final profile = await ref.watch(currentUserProvider.future);
    if (profile?.coupleId == null) return null;
    
    final service = ref.watch(checkinServiceProvider);
    return service.getTodayCheckin(profile!.coupleId!);
  }

  Future<void> submitCheckin({
    required String moodEmoji,
    required String moodLabel,
    required int affectionScore,
    required int stressScore,
    required int energyScore,
    String? journalNote,
  }) async {
    final profile = await ref.watch(currentUserProvider.future);
    if (profile?.coupleId == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(checkinServiceProvider);
      return service.submitCheckin(
        coupleId: profile!.coupleId!,
        moodEmoji: moodEmoji,
        moodLabel: moodLabel,
        affectionScore: affectionScore,
        stressScore: stressScore,
        energyScore: energyScore,
        journalNote: journalNote,
      );
    });
  }
}

@riverpod
Stream<CheckinModel?> partnerCheckinStream(PartnerCheckinStreamRef ref) async* {
  final profile = await ref.watch(currentUserProvider.future);
  final couple = await ref.watch(currentCoupleStreamProvider.future);
  
  if (profile?.coupleId == null || couple == null) {
    yield null;
    return;
  }

  // Find partner's ID
  final partnerId = profile!.id == couple.partner1Id ? couple.partner2Id : couple.partner1Id;
  if (partnerId == null) {
    yield null;
    return;
  }

  final supabase = ref.watch(supabaseClientProvider);
  
  // Realtime stream of partner's checkins
  yield* supabase
      .from('daily_checkins')
      .stream(primaryKey: ['id'])
      .eq('couple_id', profile.coupleId!)
      .order('created_at', ascending: false)
      .map((events) {
        final partnerEvents = events.where((e) => e['user_id'] == partnerId).toList();
        if (partnerEvents.isEmpty) return null;
        return CheckinModel.fromJson(partnerEvents.first);
      });
}
