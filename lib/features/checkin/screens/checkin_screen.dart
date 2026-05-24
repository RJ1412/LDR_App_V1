import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../shared/widgets/custom_textfield.dart';
import '../../../shared/widgets/glass_card.dart';
import '../providers/checkin_provider.dart';

class CheckinScreen extends ConsumerStatefulWidget {
  const CheckinScreen({super.key});

  @override
  ConsumerState<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends ConsumerState<CheckinScreen> {
  int _affectionScore = 5;
  int _stressScore = 5;
  int _energyScore = 5;
  String _selectedEmoji = '😊';
  String _moodLabel = 'Content';
  final _noteController = TextEditingController();

  final List<Map<String, String>> _moods = [
    {'emoji': '💖', 'label': 'Loved'},
    {'emoji': '😊', 'label': 'Content'},
    {'emoji': '😴', 'label': 'Tired'},
    {'emoji': '😢', 'label': 'Sad'},
    {'emoji': '⚡', 'label': 'Energetic'},
    {'emoji': '😤', 'label': 'Frustrated'},
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submit() async {
    await ref.read(todayCheckinProvider.notifier).submitCheckin(
      moodEmoji: _selectedEmoji,
      moodLabel: _moodLabel,
      affectionScore: _affectionScore,
      stressScore: _stressScore,
      energyScore: _energyScore,
      journalNote: _noteController.text.trim(),
    );
    if (mounted) context.pop();
  }

  Widget _buildSlider(String title, int value, ValueChanged<double> onChanged, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTypography.bodyMedium),
            Text(value.toString(), style: AppTypography.bodyMedium.copyWith(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        Slider(
          value: value.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          activeColor: color,
          inactiveColor: color.withValues(alpha: 0.2),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final checkinState = ref.watch(todayCheckinProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Daily Check-in'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: GlassCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('How are you feeling today?', style: AppTypography.h2),
                const SizedBox(height: 8),
                Text('Be honest, your partner is here for you.', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 32),
                
                // Emoji Selector
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _moods.map((mood) {
                    final isSelected = _selectedEmoji == mood['emoji'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedEmoji = mood['emoji']!;
                          _moodLabel = mood['label']!;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary.withValues(alpha: 0.2) : AppColors.surface,
                          border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text('${mood['emoji']} ${mood['label']}', style: TextStyle(fontSize: 16, color: isSelected ? AppColors.textPrimary : AppColors.textMuted)),
                      ),
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 32),
                
                // Sliders
                _buildSlider('Affection (Connection)', _affectionScore, (v) => setState(() => _affectionScore = v.toInt()), AppColors.primary),
                const SizedBox(height: 16),
                _buildSlider('Stress Level', _stressScore, (v) => setState(() => _stressScore = v.toInt()), Colors.orangeAccent),
                const SizedBox(height: 16),
                _buildSlider('Energy Level', _energyScore, (v) => setState(() => _energyScore = v.toInt()), Colors.greenAccent),
                
                const SizedBox(height: 32),
                
                CustomTextField(
                  controller: _noteController,
                  labelText: 'Journal Note (Optional)',
                  hintText: 'Anything else on your mind?',
                  maxLines: 3,
                ),
                
                const SizedBox(height: 32),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: checkinState.isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      backgroundColor: AppColors.primary,
                    ),
                    child: checkinState.isLoading
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Text('Share with Partner', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
