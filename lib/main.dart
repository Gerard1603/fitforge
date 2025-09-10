import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const FitForgeApp());
}

class FitForgeApp extends StatelessWidget {
  const FitForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitForge',
      debugShowCheckedModeBanner: false,

      // 👇 Start with onboarding welcome
      initialRoute: Routes.onboardingWelcome,

      routes: {
        // Onboarding
        Routes.onboardingWelcome: (_) => const OnboardingWelcome(),
        Routes.onboardingFeatures: (_) => const OnboardingFeatures(),
        Routes.onboardingGetStarted: (_) => const OnboardingGetStarted(),

        // Auth
        Routes.login: (_) => const LoginPage(),
        Routes.signup: (_) => const SignupPage(),

        // Home
        Routes.home: (_) => const HomePage(),
      },
    );
  }
}
