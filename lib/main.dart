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
import 'pages/workouts_page.dart';

void main() {
  runApp(const FitForgeApp());
}

class FitForgeApp extends StatelessWidget {
  const FitForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = Colors.deepOrange;

    return MaterialApp(
      title: 'FitForge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),

        cardColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.08),

        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          centerTitle: true,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),

        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
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

        // Pages
        Routes.home: (_) => const HomePage(),
        Routes.progress: (_) => const ProgressPage(),
        Routes.nutrition: (_) => const NutritionPage(),
        Routes.profile: (_) => const ProfilePage(),
        Routes.settings: (_) => const SettingsPage(),

        // Workouts
        Routes.workouts: (_) => const WorkoutsPage(),
      },
    );
  }
}
