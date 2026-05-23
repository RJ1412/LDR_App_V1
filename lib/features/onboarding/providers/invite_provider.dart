import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/couple_model.dart';
import '../../../services/couple_service.dart';
import '../../auth/providers/current_user_provider.dart';

part 'invite_provider.g.dart';

@riverpod
class InviteController extends _$InviteController {
  @override
  FutureOr<CoupleModel?> build() {
    return null; // Holds the generated couple if user chooses to create
  }

  Future<void> generateInvite() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final coupleService = ref.read(coupleServiceProvider);
      final couple = await coupleService.createCouple();
      await ref.read(currentUserProvider.notifier).refresh();
      return couple;
    });
  }

  Future<void> joinCouple(String inviteCode) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final coupleService = ref.read(coupleServiceProvider);
      final couple = await coupleService.joinCouple(inviteCode);
      await ref.read(currentUserProvider.notifier).refresh();
      return couple;
    });
  }
}
