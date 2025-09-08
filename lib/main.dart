import 'package:flutter/material.dart';
import 'routes.dart';

// Onboarding
import 'onboarding/onboarding_welcome.dart';
import 'onboarding/onboarding_features.dart';
import 'onboarding/onboarding_get_started.dart';

// Auth
import 'auth/login_page.dart';
import 'auth/signup_page.dart';

// Pages
import 'pages/home_page.dart';
import 'pages/progress_page.dart';
import 'pages/nutrition_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';
import 'pages/workout_session_page.dart';
import 'pages/workouts_page.dart';

void main() {
  runApp(const FitForgeApp());
}

class FitForgeApp extends StatelessWidget {
  const FitForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitForge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
      ),
      initialRoute: Routes.onboardingWelcome,
      routes: {
        // Onboarding
        Routes.onboardingWelcome: (_) => const OnboardingWelcome(),
        Routes.onboardingFeatures: (_) => const OnboardingFeatures(),
        Routes.onboardingGetStarted: (_) => const OnboardingGetStarted(),

        // Auth
        Routes.login: (_) => const LoginPage(),
        Routes.signup: (_) => const SignupPage(),

        // Main Pages
        Routes.home: (_) => const HomePage(),
        Routes.progress: (_) => const ProgressPage(),
        Routes.nutrition: (_) => const NutritionPage(),
        Routes.profile: (_) => const ProfilePage(),
        Routes.settings: (_) => const SettingsPage(),

        // Workouts
        Routes.workoutSession: (_) => const WorkoutsPage(),
        // 🔑 use WorkoutsPage as entry — from here you push WorkoutSessionPage with data
      },
    );
  }
}
