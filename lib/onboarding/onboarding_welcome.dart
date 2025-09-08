import 'package:flutter/material.dart';
import '../routes.dart';

class OnboardingWelcome extends StatelessWidget {
  const OnboardingWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFFA726), Color(0xFFFF6F00)],
    );

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(decoration: const BoxDecoration(gradient: gradient)),

          // Main content on top of the gradient
          const _OnboardingContent(),
        ],
      ),
    );
  }
}

class _OnboardingContent extends StatelessWidget {
  const _OnboardingContent();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand Badge
            const _BrandBadge(),
            const SizedBox(height: 24),

            // Hero Icon
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scheme.onPrimary.withOpacity(0.2),
                ),
                child: Icon(
                  Icons.favorite_rounded,
                  size: 80,
                  color: scheme.onPrimary,
                ),
              ),
            ),
            const SizedBox(height: 48),

            // Title and Description
            Text(
              'Welcome to FitForge',
              style: text.headlineMedium?.copyWith(
                color: scheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Your personalized fitness companion. Track progress, discover workouts, and achieve your goals with ease.",
              style: text.bodyLarge?.copyWith(
                color: scheme.onPrimary.withOpacity(0.9),
              ),
            ),

            const Spacer(),

            // Next Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the features screen using named routes
                  Navigator.pushReplacementNamed(context, Routes.onboardingFeatures);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.onPrimary,
                  foregroundColor: scheme.primary,
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Next', style: text.titleMedium),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandBadge extends StatelessWidget {
  const _BrandBadge();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.onPrimary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.onPrimary.withOpacity(0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.fitness_center_rounded,
              color: scheme.onPrimary, size: 20),
          const SizedBox(width: 8),
          Text('FitForge',
              style: TextStyle(
                color: scheme.onPrimary,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              )),
        ],
      ),
    );
  }
}
