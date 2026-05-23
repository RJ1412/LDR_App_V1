import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blur;
  final Color? borderGradientColor;
  final Color? fillGradientColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 24.0,
    this.blur = 12.0,
    this.borderGradientColor,
    this.fillGradientColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderGradientColor ?? AppColors.border.withValues(alpha: 0.4),
              width: 1.2,
            ),
            gradient: LinearGradient(
              colors: [
                (fillGradientColor ?? AppColors.surface).withValues(alpha: 0.6),
                (fillGradientColor ?? AppColors.surface).withValues(alpha: 0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
