import 'package:fitforge_onboarding_professional/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'pages/workout_session_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions
          .currentPlatform); // 🔥 must have firebase_options if generated
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
      ),
      initialRoute: Routes.login, // Start at login
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
        Routes.workouts: (_) => const WorkoutsPage(),
        Routes.workoutSession: (_) => const WorkoutSessionPage(
              planName: "Sample Plan",
              exerciseNames: ["Push Ups", "Squats", "Sit Ups"],
            ),
      },
    );
  }
}
