import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // 1. Bungkus dengan GestureDetector agar seluruh area layar bisa diklik
      body: GestureDetector(
        onTap: () {
          // 2. Berpindah ke halaman login saat layar diklik/ditekan
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: Container(
          // Memastikan container memakan seluruh ruang layar agar area klik maksimal
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Icon Campuran Smartphone & Open Book
              const Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.smartphone, size: 100, color: AppColors.textSecondary),
                  Positioned(
                    top: 25,
                    child: Icon(Icons.menu_book, size: 45, color: AppColors.primaryBlue),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Pocket Library',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              const Text(
                'Portable Digital Library',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
              
              // Spasi dinamis untuk mendorong instruksi klik ke bagian bawah
              const SizedBox(height: 64),
              
              // 3. Teks Instruksi Pengganti Loading Bar
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Tap Anywhere to Start',
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 16, color: AppColors.primaryBlue),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}