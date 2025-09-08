import 'package:flutter/material.dart';
import '../routes.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  void _signup() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    const gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFFA726), Color(0xFFFF6F00)],
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: gradient),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person_add, size: 80, color: scheme.primary),
                      const SizedBox(height: 16),
                      Text("Create Account",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 32),

                      // Name
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: "Full Name",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Enter your name";
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Enter email";
                          if (!value.contains("@")) return "Enter valid email";
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Enter password";
                          if (value.length < 6) return "Min 6 characters";
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Confirm Password
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirm,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                                _obscureConfirm ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() => _obscureConfirm = !_obscureConfirm);
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Re-enter password";
                          if (value != _passwordController.text) return "Passwords don't match";
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Signup Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _signup,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: scheme.primary,
                            foregroundColor: scheme.onPrimary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Sign Up", style: TextStyle(fontSize: 18)),
                        ),
                      ),

                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.login);
                        },
                        child: const Text("Already have an account? Login"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
