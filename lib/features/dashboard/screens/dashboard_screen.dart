import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../checkin/providers/checkin_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../models/checkin_model.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayCheckinAsync = ref.watch(todayCheckinProvider);
    final partnerCheckinAsync = ref.watch(partnerCheckinStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Your Space', style: AppTypography.h2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: AppColors.textMuted),
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
          )
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // ignore: unused_result
            ref.refresh(todayCheckinProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text('Today', style: AppTypography.h1),
              const SizedBox(height: 24),
              
              // My Status Card
              _buildMyStatusSection(context, todayCheckinAsync),
              
              const SizedBox(height: 32),
              
              // Partner Status Card
              Text('Partner\'s Status', style: AppTypography.h2),
              const SizedBox(height: 16),
              _buildPartnerStatusSection(partnerCheckinAsync),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyStatusSection(BuildContext context, AsyncValue<CheckinModel?> checkinAsync) {
    return checkinAsync.when(
      data: (checkin) {
        if (checkin == null) {
          return GlassCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.favorite_border_rounded, size: 48, color: AppColors.primary),
                const SizedBox(height: 16),
                Text('How are you feeling?', style: AppTypography.h2),
                const SizedBox(height: 8),
                Text('Check in to let your partner know.', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.push('/checkin'),
                    child: const Text('Complete Daily Check-in'),
                  ),
                ),
              ],
            ),
          );
        }

        return _buildCheckinCard(checkin, isPartner: false);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Error loading checkin: $e', style: const TextStyle(color: Colors.red)),
    );
  }

  Widget _buildPartnerStatusSection(AsyncValue<CheckinModel?> checkinAsync) {
    return checkinAsync.when(
      data: (checkin) {
        if (checkin == null) {
          return GlassCard(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.hourglass_empty_rounded, size: 48, color: AppColors.textMuted),
                  const SizedBox(height: 16),
                  Text('Waiting for partner...', style: AppTypography.bodyMedium),
                ],
              ),
            ),
          );
        }

        return _buildCheckinCard(checkin, isPartner: true);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Error loading partner checkin: $e', style: const TextStyle(color: Colors.red)),
    );
  }

  Widget _buildCheckinCard(CheckinModel checkin, {required bool isPartner}) {
    final timeFormatted = DateFormat.jm().format(checkin.createdAt.toLocal());
    
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(checkin.moodEmoji, style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(checkin.moodLabel, style: AppTypography.h3),
                      Text(timeFormatted, style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
                    ],
                  ),
                ],
              ),
              if (isPartner) const Icon(Icons.favorite_rounded, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildScoreCircle('Affection', checkin.affectionScore, AppColors.primary),
              _buildScoreCircle('Stress', checkin.stressScore, Colors.orangeAccent),
              _buildScoreCircle('Energy', checkin.energyScore, Colors.greenAccent),
            ],
          ),
          if (checkin.journalNote != null && checkin.journalNote!.isNotEmpty) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Text(
                '"${checkin.journalNote!}"',
                style: AppTypography.bodyMedium.copyWith(fontStyle: FontStyle.italic, color: AppColors.textSecondary),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildScoreCircle(String label, int score, Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                value: score / 10,
                backgroundColor: color.withValues(alpha: 0.2),
                color: color,
                strokeWidth: 4,
              ),
            ),
            Text(score.toString(), style: AppTypography.h3.copyWith(color: color)),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
      ],
    );
  }
}
