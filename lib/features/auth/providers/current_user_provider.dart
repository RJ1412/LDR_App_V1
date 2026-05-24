import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/user_model.dart';
import '../../../services/couple_service.dart';

part 'current_user_provider.g.dart';

@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  FutureOr<UserModel?> build() async {
    return _fetchProfile();
  }

  Future<UserModel?> _fetchProfile() async {
    final coupleService = ref.read(coupleServiceProvider);
    return await coupleService.getCurrentUserProfile();
  }
}
