import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../network/supabase_client.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import '../../shared/widgets/glass_card.dart';

part 'app_router.g.dart';

// Key router paths
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

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final supabase = ref.watch(supabaseClientProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (BuildContext context, GoRouterState state) {
      final session = supabase.auth.currentSession;
      final isLoggedIn = session != null;
      final isGoingToLogin = state.matchedLocation == AppRoutes.login;
      
      // 1. If not logged in, redirect to login unless already going there
      if (!isLoggedIn) {
        return isGoingToLogin ? null : AppRoutes.login;
      }

      // 2. If logged in and on login/splash, redirect to check onboarding/pairing state
      if (isGoingToLogin || state.matchedLocation == AppRoutes.splash) {
        // User is logged in. In subsequent tickets we will check their database profile.
        // For now, redirect to dashboard as fallback.
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
        builder: (context, state) => const LoginPlaceholderScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPlaceholderScreen(),
      ),
      GoRoute(
        path: AppRoutes.invite,
        builder: (context, state) => const InvitePlaceholderScreen(),
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

// --- Temp Placeholder Screens to prevent routing errors in Ticket 1 ---

class PremiumPlaceholderScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Widget>? actions;

  const PremiumPlaceholderScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Elegant glow backgrounds
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.15),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon wrapper with nice outline & glow
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.surfaceElevated,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          icon,
                          size: 40,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        title,
                        style: AppTypography.h2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        subtitle,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (actions != null && actions!.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        ...actions!,
                      ],
                    ],
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
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class LoginPlaceholderScreen extends StatelessWidget {
  const LoginPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PremiumPlaceholderScreen(
      title: 'Welcome to LDR Sync',
      subtitle: 'Reconnect daily and nurture your long-distance bond with shared rituals.',
      icon: Icons.favorite_rounded,
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Get Started'),
        ),
      ],
    );
  }
}

class OnboardingPlaceholderScreen extends StatelessWidget {
  const OnboardingPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PremiumPlaceholderScreen(
      title: 'Setup Your Ritual',
      subtitle: 'Configure check-in triggers, choose custom notification hours, and personalize your theme.',
      icon: Icons.tune_rounded,
    );
  }
}

class InvitePlaceholderScreen extends StatelessWidget {
  const InvitePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PremiumPlaceholderScreen(
      title: 'Connect with Partner',
      subtitle: 'Share your unique invite code or enter your partner\'s code to sync your daily journeys.',
      icon: Icons.people_rounded,
    );
  }
}

class DashboardPlaceholderScreen extends StatelessWidget {
  const DashboardPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PremiumPlaceholderScreen(
      title: 'Partner Dashboard',
      subtitle: 'View real-time connection status, today\'s daily check-in prompt, and streak progress.',
      icon: Icons.dashboard_rounded,
    );
  }
}

class CheckInPlaceholderScreen extends StatelessWidget {
  const CheckInPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PremiumPlaceholderScreen(
      title: 'Daily Check-In',
      subtitle: 'How is your heart feeling today? Rate affection, stress, energy, and log your emotions.',
      icon: Icons.edit_note_rounded,
    );
  }
}

class HistoryPlaceholderScreen extends StatelessWidget {
  const HistoryPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PremiumPlaceholderScreen(
      title: 'Relationship Timeline',
      subtitle: 'Explore past check-ins, joint mood trends, and monthly AI insights.',
      icon: Icons.history_rounded,
    );
  }
}

class SettingsPlaceholderScreen extends StatelessWidget {
  const SettingsPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PremiumPlaceholderScreen(
      title: 'Account & Settings',
      subtitle: 'Manage your profile, partner link, daily reminders, and subscription status.',
      icon: Icons.settings_rounded,
    );
  }
}
