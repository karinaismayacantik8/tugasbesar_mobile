import 'package:flutter/material.dart';
import 'book_detail_and_form.dart'; 
import 'account_detail_screen.dart'; // Menuju ke halaman info akun Anda (image_f8d3f1.png)
import 'library_setting_screen.dart'; // Menuju ke halaman library setting Anda (image_f8c59e.png)
import 'system_information_screen.dart'; // Menuju ke halaman info sistem Anda (image_f86ab1.png)

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _currentNavIndex = 0;

  // Data Dummy Koleksi Buku Utama
  final List<Map<String, dynamic>> _dummyBooks = [
    {
      'title': 'The Great Gatsby', 
      'author': 'F. Scott Fitzgerald',
      'category': 'Classic Fiction',
      'publisher': 'Scribner',
      'year': '1925',
      'isbn': '978-0743273565',
      'status': 'Available', 
      'color': Colors.orange
    },
    {
      'title': 'To Kill a Mockingbird', 
      'author': 'Harper Lee',
      'category': 'Classic Fiction',
      'publisher': 'J.B. Lippincott & Co.',
      'year': '1960',
      'isbn': '978-0446310789',
      'status': 'Borrowed', 
      'color': const Color(0xFF6495ED)
    }, 
    {
      'title': '1984', 
      'author': 'George Orwell',
      'category': 'Dystopian Fiction',
      'publisher': 'Secker & Warburg',
      'year': '1949',
      'isbn': '978-0451524935',
      'status': 'Available', 
      'color': Colors.pinkAccent
    },
    {
      'title': 'Pride and Prejudice', 
      'author': 'Jane Austen',
      'category': 'Romance Classic',
      'publisher': 'T. Egerton',
      'year': '1813',
      'isbn': '978-0141439518',
      'status': 'Available', 
      'color': Colors.purpleAccent
    },
  ];

  // =========================================================================
  // MODAL SUKSES ADD TO LIBRARY (image_f8df51.png)
  // =========================================================================
  void _showSuccessDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32), 
          topRight: Radius.circular(32)
        ),
      ),
      builder: (BuildContext ctx) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF9FBFC), Colors.white],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), 
              topRight: Radius.circular(32)
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2F9EE),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00C569).withValues(alpha: 0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        )
                      ]
                    ),
                  ),
                  Container(
                    width: 84,
                    height: 84,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF00DE7A), Color(0xFF00B35F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 48),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00B35F),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                      ),
                      child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 16),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Book Added Successfully',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 12),
              const Text(
                'The book has been added to the library\nand is now available.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B66FF), Color(0xFF4A49FF)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3B66FF).withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      )
                    ]
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx); 
                      setState(() => _currentNavIndex = 0); 
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text(
                      'Back to Dashboard', 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Students can now borrow this book',
                style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      body: IndexedStack(
        index: _currentNavIndex,
        children: [
          _buildDashboardTab(),
          _buildGoogleBooksSearchTab(),
          _buildProfileTab(),
        ],
      ),
      floatingActionButton: _currentNavIndex == 0 
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminBookFormScreen()));
              },
              backgroundColor: const Color(0xFF3B59FF),
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        onTap: (index) => setState(() => _currentNavIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF3B59FF),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  // ==================== TAB 1: DASHBOARD MAIN COLLECTION ====================
  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 180,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF297BFF), Color(0xFF3B59FF)]),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
                ),
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 26, 
                      backgroundColor: Colors.white24,
                      child: Text('AR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Admin Dashboard', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        Text('Alya Rahmawati', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: 145,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    const Expanded(child: _StatCard(value: '1247', label: 'Total Books', icon: Icons.book_outlined, iconColor: Colors.blue)),
                    const SizedBox(width: 8),
                    const Expanded(child: _StatCard(value: '892', label: 'Available', icon: Icons.assignment_turned_in_outlined, iconColor: Colors.green)),
                    const SizedBox(width: 8),
                    const Expanded(child: _StatCard(value: '355', label: 'Borrowed', icon: Icons.bookmark_outline, iconColor: Colors.orange)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 110),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Library Collection', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _dummyBooks.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final book = _dummyBooks[index];
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminBookDetailScreen(bookData: book)));
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: book['color'], borderRadius: BorderRadius.circular(12)),
                          child: const Center(child: Icon(Icons.menu_book, color: Colors.white, size: 40)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(book['title'], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _buildStatusBadge(book['status']),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ==================== TAB 2: GOOGLE BOOKS SEARCH (image_f9a6e0.png) ====================
  Widget _buildGoogleBooksSearchTab() {
    final List<Map<String, dynamic>> searchResultBooks = [
      {'title': 'The Psychology of Money', 'author': 'Morgan Housel', 'year': '2020', 'publisher': 'Harriman House', 'color': const Color(0xFF00C569)},
      {'title': 'Atomic Habits', 'author': 'James Clear', 'year': '2018', 'publisher': 'Penguin Random House', 'color': const Color(0xFF4F70FF)},
      {'title': 'Thinking, Fast and Slow', 'author': 'Daniel Kahneman', 'year': '2011', 'publisher': 'Farrar, Straus and Giroux', 'color': const Color(0xFFE243CD)},
      {'title': 'The Lean Startup', 'author': 'Eric Ries', 'year': '2011', 'publisher': 'Crown Business', 'color': const Color(0xFFFF6B2C)},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => setState(() => _currentNavIndex = 0),
        ),
        title: const Text('Google Books Search', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search books, authors, or ISBN...',
                hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.6), fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF1F3F6),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B59FF), width: 1.5)),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text('Enter a search term to find books', style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: searchResultBooks.length,
              itemBuilder: (context, index) {
                final book = searchResultBooks[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.withValues(alpha: 0.1))),
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 52,
                        height: 72,
                        decoration: BoxDecoration(color: book['color'], borderRadius: BorderRadius.circular(8)),
                        child: const Center(child: Icon(Icons.menu_book_rounded, color: Colors.white, size: 24)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(book['title'], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                            const SizedBox(height: 2),
                            Text(book['author'], style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 2),
                            Text('${book['year']}  •  ${book['publisher']}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, color: Colors.grey.withValues(alpha: 0.8))),
                            const SizedBox(height: 10),
                            Builder(
                              builder: (buttonContext) {
                                return SizedBox(
                                  width: double.infinity,
                                  height: 34,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      _showSuccessDialog(buttonContext); 
                                    },
                                    icon: const Icon(Icons.add, color: Colors.white, size: 16),
                                    label: const Text('Add to Library', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4F46E5), 
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), 
                                      elevation: 0,
                                    ),
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE0E7FF))),
            child: const Center(child: Text('📚 Powered by Google Books API', style: TextStyle(fontSize: 12, color: Color(0xFF4F46E5), fontWeight: FontWeight.w600))),
          ),
        ],
      ),
    );
  }

  // ==================== TAB 3: PROFILE SCREEN ====================
  Widget _buildProfileTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 60, 24, 20),
            child: Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF4E6AFF), Color(0xFF2B47FC)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                  ),
                  child: const Center(
                    child: Text('AR', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Alya Rahmawati', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 4),
                const Text('Admin ID: ADM-2024-001', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
                const Text('alya.rahma@library.edu', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(child: _StatCard(value: '1247', label: 'Total Books', icon: Icons.book_outlined, iconColor: Colors.blue)),
                SizedBox(width: 8),
                Expanded(child: _StatCard(value: '892', label: 'Available', icon: Icons.assignment_turned_in_outlined, iconColor: Colors.green)),
                SizedBox(width: 8),
                Expanded(child: _StatCard(value: '355', label: 'Borrowed', icon: Icons.bookmark_outline, iconColor: Colors.orange)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text('Settings', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
            ),
            child: Column(
              children: [
                // 1. ACCOUNT INFORMATION (image_f8d3f1.png)
                _buildSettingTile(
                  icon: Icons.person_outline, 
                  iconBg: const Color(0xFFEFF6FF), 
                  iconColor: const Color(0xFF3B82F6), 
                  title: 'Account Information',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminAccountDetailScreen()),
                    );
                  },
                ),
                const Divider(height: 1, indent: 60, color: Color(0xFFF3F4F6)),
                
                // 2. LIBRARY SETTINGS (image_f8c59e.png)
                _buildSettingTile(
                  icon: Icons.settings_outlined, 
                  iconBg: const Color(0xFFF5F3FF), 
                  iconColor: const Color(0xFF8B5CF6), 
                  title: 'Library Settings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminLibrarySettingsScreen()),
                    );
                  },
                ),
                const Divider(height: 1, indent: 60, color: Color(0xFFF3F4F6)),

                // 3. SYSTEM INFORMATION (image_f86ab1.png)
                _buildSettingTile(
                  icon: Icons.info_outline, 
                  iconBg: const Color(0xFFF3F4F6), 
                  iconColor: const Color(0xFF6B7280), 
                  title: 'System Information',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminSystemInformationScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showLogoutConfirmation(context),
                icon: const Icon(Icons.logout, color: Colors.white, size: 18),
                label: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE11D48),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon, 
    required Color iconBg, 
    required Color iconColor, 
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
      onTap: onTap,
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28))),
      builder: (BuildContext ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 90, height: 90, decoration: const BoxDecoration(color: Color(0xFFFFEAEA), shape: BoxShape.circle)),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFFF5252), Color(0xFFFF2A2A)]), shape: BoxShape.circle),
                    child: const Icon(Icons.logout, color: Colors.white, size: 32),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Logout', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text('Are you sure you want to sign out from Pocket Library?', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                      child: const Text('Cancel', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
                      child: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusBadge(String status) {
    bool isAvailable = status == 'Available';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isAvailable ? const Color(0xFFE6F9F0) : const Color(0xFFFFF2EC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isAvailable ? const Color(0xFF00C569) : const Color(0xFFFF6B2C)),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value; final String label; final IconData icon; final Color iconColor;
  const _StatCard({required this.value, required this.label, required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.withValues(alpha: 0.05))),
      child: Column(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}