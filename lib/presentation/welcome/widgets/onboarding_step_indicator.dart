import 'package:flutter/material.dart';

/// Indicador de pasos tipo puntos para flujos de onboarding:
/// el punto activo es más ancho y tiene el color principal,
/// los inactivos son círculos pequeños en gris claro.
class OnboardingStepIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep; // 0-indexed
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double activeDotWidth;

  const OnboardingStepIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.activeColor = const Color(0xFF2962FF),
    this.inactiveColor = const Color(0xFFD0D3DF),
    this.dotSize = 8,
    this.activeDotWidth = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps, (index) {
        final bool isActive = index == currentStep;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? activeDotWidth : dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(dotSize / 2),
          ),
        );
      }),
    );
  }
}
