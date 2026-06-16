import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/book_card.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({Key? key}) : super(key: key);

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  int _currentNavIndex = 0;

  final List<Map<String, String>> _catalogBooks = [
    {'title': 'Introduction to Flutter', 'author': 'Google Team', 'cover_url': 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=400'},
    {'title': 'Firebase Architecture', 'author': 'John Doe', 'cover_url': 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?w=400'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Pocket Library Student', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: AppColors.textPrimary))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Selamat Datang
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.primaryBlue, Color(0xFF1D4ED8)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Halo, Selamat Belajar 👋', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('Temukan ribuan referensi buku digital dalam genggaman Anda.', style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Sektor Status Peminjaman (Active Loans)
            const Text('Active Loans', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 12),
            _buildActiveLoanCard(),
            const SizedBox(height: 28),

            // Sektor Katalog Buku
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Available Book Catalog', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                TextButton(onPressed: () {}, child: const Text('View All', style: TextStyle(color: AppColors.primaryBlue))),
              ],
            ),
            const SizedBox(height: 12),
            BookGridWidget(books: _catalogBooks),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) => setState(() => _currentNavIndex = index),
      ),
    );
  }

  Widget _buildActiveLoanCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.bookmark_added, color: AppColors.primaryBlue, size: 36),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('UI/UX Design Mobile', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                SizedBox(height: 4),
                Text('Due Date: June 25, 2026', style: TextStyle(fontSize: 12, color: AppColors.dangerRed, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Trigger Layar Konfirmasi Pengembalian (Layar 25)
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.background, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('Return', style: TextStyle(color: AppColors.primaryBlue, fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}