import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../services/auth_service.dart';
import 'current_user_provider.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      await authService.signInWithEmail(email: email, password: password);
      ref.invalidate(currentUserProvider);
    });
  }

  Future<void> signUp({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      await authService.signUpWithEmail(email: email, password: password);
      // Wait a moment for the DB trigger to create the user profile
      await Future.delayed(const Duration(seconds: 1));
      ref.invalidate(currentUserProvider);
    });
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      await authService.signOut();
      ref.invalidate(currentUserProvider);
    });
  }
}
