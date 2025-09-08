import 'package:flutter/material.dart';
import '../routes.dart';

class OnboardingFeatures extends StatelessWidget { // Renamed class from OnboardingGetStarted to OnboardingFeatures
  const OnboardingFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFFA726), Color(0xFFFF6F00)],
    );
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme; // Added text theme for consistency

    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: const BoxDecoration(gradient: gradient)),
          SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Discover Key Features', // Changed title for features page
                      style: text.headlineMedium?.copyWith(color: scheme.onPrimary)),
                  const SizedBox(height: 12),
                  Text(
                    "Explore what FitForge has to offer to help you reach your fitness goals.", // Changed description
                    style: text.bodyMedium?.copyWith(color: scheme.onPrimary.withOpacity(0.95)),
                  ),
                  const SizedBox(height: 32),
                  // Example features list (can be expanded)
                  _FeatureItem(
                    icon: Icons.fitness_center,
                    title: 'Personalized Workouts',
                    description: 'Access tailored workout plans for all levels.',
                    scheme: scheme,
                    text: text,
                  ),
                  const SizedBox(height: 16),
                  _FeatureItem(
                    icon: Icons.track_changes,
                    title: 'Progress Tracking',
                    description: 'Monitor your strength, weight, and nutrition over time.',
                    scheme: scheme,
                    text: text,
                  ),
                  const SizedBox(height: 16),
                  _FeatureItem(
                    icon: Icons.restaurant_menu,
                    title: 'Nutrition Logging',
                    description: 'Log your meals and track your macro intake.',
                    scheme: scheme,
                    text: text,
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text('Continue'),
                      onPressed: () {
                        // Navigate to the Get Started Page using named routes
                        Navigator.pushReplacementNamed(context, Routes.onboardingGetStarted);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: scheme.onPrimary,
                        foregroundColor: scheme.primary,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for feature items
class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final ColorScheme scheme;
  final TextTheme text;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.scheme,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 30, color: scheme.onPrimary),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: text.titleMedium?.copyWith(color: scheme.onPrimary)),
              const SizedBox(height: 4),
              Text(description,
                  style: text.bodyMedium?.copyWith(color: scheme.onPrimary.withOpacity(0.8))),
            ],
          ),
        ),
      ],
    );
  }
}