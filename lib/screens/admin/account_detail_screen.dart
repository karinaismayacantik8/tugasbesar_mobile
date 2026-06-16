import 'package:flutter/material.dart';

class AdminAccountDetailScreen extends StatelessWidget {
  const AdminAccountDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Background abu-abu sangat muda/bersih sesuai image_f8d3f1.png
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Account',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              
              // =========================================================================
              // BAGIAN PROFIL UTAMA (FOTO & BADGE ADMINISTRATOR)
              // =========================================================================
              Center(
                child: Column(
                  children: [
                    // Avatar Lingkaran Biru Besar dengan Bayangan Lembut
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF1A68FF),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1A68FF).withAlpha(50),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Nama Lengkap
                    const Text(
                      'Alya Rahmawati',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // Admin ID
                    const Text(
                      'Admin ID: ADM-2024-001',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    // Badge Lencana Administrator
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFDBEAFE), width: 1),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            size: 15,
                            color: Color(0xFF2563EB),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Administrator',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Email di bawah Badge
                    const Text(
                      'alya.rahma@library.edu',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // =========================================================================
              // SEKSI DAFTAR DATA INFORMASI AKUN
              // =========================================================================
              const Text(
                'ACCOUNT INFORMATION',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF475569),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              
              // 1. Card Full Name
              _buildInfoCard(
                icon: Icons.person_outline_rounded,
                iconColor: const Color(0xFF3B82F6),
                iconBg: const Color(0xFFEFF6FF),
                label: 'Full Name',
                value: 'Alya Rahmawati',
              ),
              const SizedBox(height: 12),
              
              // 2. Card Email Address
              _buildInfoCard(
                icon: Icons.mail_outline_rounded,
                iconColor: const Color(0xFF3B82F6),
                iconBg: const Color(0xFFEFF6FF),
                label: 'Email Address',
                value: 'alya.rahma@library.edu',
              ),
              const SizedBox(height: 12),
              
              // 3. Card Phone Number
              _buildInfoCard(
                icon: Icons.phone_outlined,
                iconColor: const Color(0xFF3B82F6),
                iconBg: const Color(0xFFEFF6FF),
                label: 'Phone Number',
                value: '+1 (555) 123-4567',
              ),
              const SizedBox(height: 12),
              
              // 4. Card Password
              _buildInfoCard(
                icon: Icons.lock_open_rounded,
                iconColor: const Color(0xFF3B82F6),
                iconBg: const Color(0xFFEFF6FF),
                label: 'Password',
                value: '••••••••••',
              ),
              
              const SizedBox(height: 36),
              
              // =========================================================================
              // TOMBOL EDIT PROFILE (BIRU GRADASI DENGAN EFFECT SHADOW)
              // =========================================================================
              SizedBox(
                width: double.infinity,
                height: 52,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2563EB).withAlpha(50),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Fungsi aksi tombol edit profile nanti di sini
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget membuat desain Card Informasi sesuai mockup image_f8d3f1.png
  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Row(
        children: [
          // Icon Container Kotak tumpul melengkung (Rounded)
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          // Label Teks dan Isinya
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}