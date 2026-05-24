import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../network/supabase_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/providers/current_user_provider.dart';
import '../../features/auth/providers/auth_state_provider.dart';
import '../../features/auth/providers/current_couple_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/onboarding/screens/invite_screen.dart';
import '../../features/onboarding/screens/solo_onboarding_screen.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import '../../shared/widgets/glass_card.dart';

part 'app_router.g.dart';

class AppRoutes {
  AppRoutes._();
  
  static const String splash = '/';
  static const String login = '/login';
  static const String onboarding = '/onboarding';
  static const String invite = '/invite';
  static const String dashboard = '/dashboard';
  static const String checkin = '/checkin';
  static const String history = '/history';
  static const String settings = '/settings';
}

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(authStateChangesProvider, (_, __) => notifyListeners());
    _ref.listen(currentUserProvider, (_, __) => notifyListeners());
    _ref.listen(currentCoupleStreamProvider, (_, __) => notifyListeners());
  }
}

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  final notifier = RouterNotifier(ref);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: notifier,
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggedIn = supabase.auth.currentSession != null;
      final isGoingToLogin = state.matchedLocation == AppRoutes.login;
      
      if (!isLoggedIn) {
        return isGoingToLogin ? null : AppRoutes.login;
      }

      // Read instead of watch so we don't recreate the GoRouter
      final currentUserAsync = ref.read(currentUserProvider);
      final coupleAsync = ref.read(currentCoupleStreamProvider);

      // If logged in, wait for profile to load
      if (currentUserAsync is AsyncLoading) {
        return AppRoutes.splash;
      }

      final profile = currentUserAsync.value;
      final couple = coupleAsync.value;
      final hasCoupleId = profile?.coupleId != null;
      final isGoingToInvite = state.matchedLocation == AppRoutes.invite;
      final isGoingToOnboarding = state.matchedLocation == AppRoutes.onboarding;

      if (!hasCoupleId) {
        if (isGoingToInvite || isGoingToOnboarding) return null;
        return AppRoutes.invite;
      }

      // Has couple ID. Check if couple is fully formed.
      final isCoupleComplete = couple != null && couple.partnerAId != null && couple.partnerBId != null;

      if (!isCoupleComplete) {
        // Pending partner. Must stay on Invite screen to see the code or go to onboarding to recreate.
        if (isGoingToInvite || isGoingToOnboarding) return null;
        return AppRoutes.invite;
      }

      // Couple is complete
      if (isGoingToLogin || isGoingToInvite || state.matchedLocation == AppRoutes.splash) {
        return AppRoutes.dashboard;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const SoloOnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.invite,
        builder: (context, state) => const InviteScreen(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardPlaceholderScreen(),
      ),
      GoRoute(
        path: AppRoutes.checkin,
        builder: (context, state) => const CheckInPlaceholderScreen(),
      ),
      GoRoute(
        path: AppRoutes.history,
        builder: (context, state) => const HistoryPlaceholderScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsPlaceholderScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.error}'),
      ),
    ),
  );
}

// --- Placeholders for remaining screens ---

class PremiumPlaceholderScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const PremiumPlaceholderScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: -100, right: -100,
            child: Container(
              width: 300, height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withValues(alpha: 0.15), blurRadius: 100, spreadRadius: 50),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -100, left: -100,
            child: Container(
              width: 300, height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: AppColors.secondary.withValues(alpha: 0.15), blurRadius: 100, spreadRadius: 50),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GlassCard(
                  padding: const EdgeInsets.all(32),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.surfaceElevated,
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1.5),
                        ),
                        child: Icon(icon, size: 40, color: AppColors.primary),
                      ),
                      const SizedBox(height: 24),
                      Text(title, style: AppTypography.h2, textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      Text(subtitle, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }
}

class OnboardingPlaceholderScreen extends StatelessWidget {
  const OnboardingPlaceholderScreen({super.key});
  @override
  Widget build(BuildContext context) => const PremiumPlaceholderScreen(
    title: 'Setup Your Ritual',
    subtitle: 'Configure check-in triggers, choose custom notification hours, and personalize your theme.',
    icon: Icons.tune_rounded,
  );
}

class DashboardPlaceholderScreen extends StatelessWidget {
  const DashboardPlaceholderScreen({super.key});
  @override
  Widget build(BuildContext context) => const PremiumPlaceholderScreen(
    title: 'Partner Dashboard',
    subtitle: 'View real-time connection status, today\'s daily check-in prompt, and streak progress.',
    icon: Icons.dashboard_rounded,
  );
}

class CheckInPlaceholderScreen extends StatelessWidget {
  const CheckInPlaceholderScreen({super.key});
  @override
  Widget build(BuildContext context) => const PremiumPlaceholderScreen(
    title: 'Daily Check-In',
    subtitle: 'How is your heart feeling today? Rate affection, stress, energy, and log your emotions.',
    icon: Icons.edit_note_rounded,
  );
}

class HistoryPlaceholderScreen extends StatelessWidget {
  const HistoryPlaceholderScreen({super.key});
  @override
  Widget build(BuildContext context) => const PremiumPlaceholderScreen(
    title: 'Relationship Timeline',
    subtitle: 'Explore past check-ins, joint mood trends, and monthly AI insights.',
    icon: Icons.history_rounded,
  );
}

class SettingsPlaceholderScreen extends StatelessWidget {
  const SettingsPlaceholderScreen({super.key});
  @override
  Widget build(BuildContext context) => const PremiumPlaceholderScreen(
    title: 'Account & Settings',
    subtitle: 'Manage your profile, partner link, daily reminders, and subscription status.',
    icon: Icons.settings_rounded,
  );
}
