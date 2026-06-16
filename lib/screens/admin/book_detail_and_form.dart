import 'package:flutter/material.dart';

// =========================================================================
// 1. DETAIL SCREEN & MODAL DELETE BOOK (ANTI-GAGAL)
// =========================================================================
class AdminBookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> bookData;
  const AdminBookDetailScreen({super.key, required this.bookData});

  // Modal Bottom Sheet Khusus Konfirmasi Hapus Buku
  void _showDeleteConfirmation(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      useRootNavigator: true, // Dipaksa muncul di atas komponen layar apa pun tanpa bentrok
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      builder: (BuildContext ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Gambar Lingkaran Ikon Sampah Merah Sesuai Desain
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 95, height: 95, decoration: const BoxDecoration(color: Color(0xFFFFEAEA), shape: BoxShape.circle)),
                  Container(
                    width: 74,
                    height: 74,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFFFF4D4D), Color(0xFFFF2222)]),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 36),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.warning_amber_rounded, color: Color(0xFFFF9800), size: 20),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Delete Book',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              // Kotak Nama Buku Yang Mau Dihapus
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.book_outlined, color: Color(0xFFEF4444), size: 18),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Are you sure you want to delete this book from the library? This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
              ),
              const SizedBox(height: 32),
              // Tombol Cancel & Delete
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Cancel', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx); // Tutup bottom sheet
                        Navigator.pop(context); // Balik ke halaman dashboard utama
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: const Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'All borrowing history for this book will be preserved',
                style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500),
              ),
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black87), onPressed: () => Navigator.pop(context)),
        title: const Text('Book Details', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    width: 140,
                    height: 190,
                    decoration: BoxDecoration(color: bookData['color'] ?? Colors.blue, borderRadius: BorderRadius.circular(16)),
                    child: const Center(child: Icon(Icons.menu_book_rounded, color: Colors.white, size: 65)),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(bookData['title'] ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('by ${bookData['author'] ?? ''}', style: const TextStyle(color: Colors.grey)),
                        const Divider(height: 32),
                        _row('Category', bookData['category'] ?? '-'),
                        _row('Publisher', bookData['publisher'] ?? '-'),
                        _row('Year', bookData['year'] ?? '-'),
                        _row('ISBN', bookData['isbn'] ?? '-'),
                        _row('Status', bookData['status'] ?? 'Available', isStatus: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AdminBookFormScreen(bookData: bookData)));
                    },
                    icon: const Icon(Icons.edit_document, color: Colors.white),
                    label: const Text('Edit Book', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4F46E5), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Builder(
                    builder: (buttonContext) { // Digunakan agar Context tidak bentrok saat menumpuk dialog
                      return ElevatedButton.icon(
                        onPressed: () => _showDeleteConfirmation(buttonContext, bookData['title'] ?? 'Selected Book'),
                        icon: const Icon(Icons.delete_outline, color: Colors.white),
                        label: const Text('Delete Book', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                      );
                    }
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          isStatus 
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: value == 'Available' ? const Color(0xFFE6F9F0) : const Color(0xFFFFF2EC), borderRadius: BorderRadius.circular(12)),
                child: Text(value, style: TextStyle(color: value == 'Available' ? const Color(0xFF00C569) : const Color(0xFFFF6B2C), fontWeight: FontWeight.bold, fontSize: 13)),
              )
            : Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }
}

// =========================================================================
// 2. ADAPTIVE ADD & EDIT FORM SCREEN
// =========================================================================
class AdminBookFormScreen extends StatefulWidget {
  final Map<String, dynamic>? bookData;
  const AdminBookFormScreen({super.key, this.bookData});

  @override
  State<AdminBookFormScreen> createState() => _AdminBookFormScreenState();
}

class _AdminBookFormScreenState extends State<AdminBookFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditMode = false;
  String _selectedStatus = 'Available';

  final _titleCtrl = TextEditingController();
  final _authorCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();
  final _publisherCtrl = TextEditingController();
  final _isbnCtrl = TextEditingController();
  final _summaryCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.bookData != null) {
      _isEditMode = true;
      _titleCtrl.text = widget.bookData!['title'] ?? '';
      _authorCtrl.text = widget.bookData!['author'] ?? '';
      _categoryCtrl.text = widget.bookData!['category'] ?? '';
      _yearCtrl.text = widget.bookData!['year'] ?? '';
      _publisherCtrl.text = widget.bookData!['publisher'] ?? '';
      _isbnCtrl.text = widget.bookData!['isbn'] ?? '';
      _summaryCtrl.text = widget.bookData!['summary'] ?? '';
      _selectedStatus = widget.bookData!['status'] ?? 'Available';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black87), onPressed: () => Navigator.pop(context)),
        title: Text(_isEditMode ? 'Edit Book' : 'Add Book', style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Book Title', isReq: true),
                      _field(_titleCtrl, 'Enter book title', val: (v) => v!.isEmpty ? 'Required' : null),
                      const SizedBox(height: 16),
                      _label('Author', isReq: true),
                      _field(_authorCtrl, 'Enter author name', val: (v) => v!.isEmpty ? 'Required' : null),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_label('Category'), _field(_categoryCtrl, 'e.g. Fiction')])),
                          const SizedBox(width: 14),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_label('Year'), _field(_yearCtrl, '2024', keyType: TextInputType.number)])),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_label('Publisher'), _field(_publisherCtrl, 'Enter publisher')])),
                          const SizedBox(width: 14),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_label('ISBN'), _field(_isbnCtrl, '978-0-00...')])),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _label('Summary'),
                      _field(_summaryCtrl, 'Brief description...', maxLines: 4),
                      const SizedBox(height: 16),
                      if (_isEditMode) ...[
                        _label('Availability Status'),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedStatus = 'Available'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(color: _selectedStatus == 'Available' ? Colors.white : const Color(0xFFF1F3F6), borderRadius: BorderRadius.circular(12)),
                                  child: Center(child: Text('Available', style: TextStyle(color: _selectedStatus == 'Available' ? const Color(0xFF00A86B) : Colors.grey, fontWeight: FontWeight.bold))),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedStatus = 'Borrowed'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(color: _selectedStatus == 'Borrowed' ? Colors.white : const Color(0xFFF1F3F6), borderRadius: BorderRadius.circular(12)),
                                  child: Center(child: Text('Borrowed', style: TextStyle(color: _selectedStatus == 'Borrowed' ? const Color(0xFFFF6B2C) : Colors.grey, fontWeight: FontWeight.bold))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) Navigator.pop(context);
                    },
                    icon: Icon(_isEditMode ? Icons.edit_document : Icons.save_outlined, color: Colors.white),
                    label: Text(_isEditMode ? 'Update Book' : 'Save Book', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isEditMode ? const Color(0xFF4F46E5) : const Color(0xFF00A86B),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text, {bool isReq = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text.rich(TextSpan(text: text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold), children: [if (isReq) const TextSpan(text: ' *', style: TextStyle(color: Colors.red))])),
    );
  }

  Widget _field(TextEditingController ctrl, String hint, {int maxLines = 1, TextInputType keyType = TextInputType.text, String? Function(String?)? val}) {
    return TextFormField(
      controller: ctrl, maxLines: maxLines, keyboardType: keyType, validator: val,
      decoration: InputDecoration(
        hintText: hint, filled: true, fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B59FF), width: 1.5)),
      ),
    );
  }
}