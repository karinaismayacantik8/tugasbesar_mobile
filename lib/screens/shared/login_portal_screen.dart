import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/colors.dart';

class LoginPortalScreen extends StatefulWidget {
  const LoginPortalScreen({super.key});

  @override
  State<LoginPortalScreen> createState() => _LoginPortalScreenState();
}

class _LoginPortalScreenState extends State<LoginPortalScreen> {
  int _selectedRole = 0; // 0: Admin, 1: Student
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Simulasi autentikasi & validasi role
      if (_selectedRole == 0) {
        // Masuk sebagai Admin
        Navigator.pushReplacementNamed(context, '/admin-dashboard');
      } else {
        // Masuk sebagai Student
        Navigator.pushReplacementNamed(context, '/student-dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(32.0),
            margin: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.account_balance, size: 64, color: AppColors.primaryBlue),
                  const SizedBox(height: 16),
                  const Text('Pocket Library', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 24),
                  
                  // Segmented Control iOS Style
                  CupertinoSlidingSegmentedControl<int>(
                    groupValue: _selectedRole,
                    backgroundColor: AppColors.background,
                    thumbColor: Colors.white,
                    children: {
                      0: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text('Admin', style: TextStyle(fontWeight: _selectedRole == 0 ? FontWeight.bold : FontWeight.normal, color: AppColors.textPrimary))),
                      1: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text('Student', style: TextStyle(fontWeight: _selectedRole == 1 ? FontWeight.bold : FontWeight.normal, color: AppColors.textPrimary))),
                    },
                    onValueChanged: (val) => setState(() => _selectedRole = val ?? 0),
                  ),
                  const SizedBox(height: 24),

                  // Input Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (val) => val!.isEmpty ? 'Please enter your email' : null,
                  ),
                  const SizedBox(height: 16),

                  // Input Password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (val) => val!.length < 6 ? 'Password must be min 6 characters' : null,
                  ),
                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Button Sign In
                  ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}