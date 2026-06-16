class BookModel {
  final String id;
  final String title;
  final String author;
  final String category;
  final String publisher;
  final String year;
  final String isbn;
  final String summary;
  final String coverUrl;
  final String status;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.publisher,
    required this.year,
    required this.isbn,
    required this.summary,
    required this.coverUrl,
    required this.status,
  });

  // Konversi dari Google Books API JSON
  factory BookModel.fromGoogleBooks(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};
    final imageLinks = volumeInfo['imageLinks'] ?? {};
    final industryIdentifiers = volumeInfo['industryIdentifiers'] as List?;
    
    String fetchedIsbn = 'N/A';
    if (industryIdentifiers != null && industryIdentifiers.isNotEmpty) {
      fetchedIsbn = industryIdentifiers.first['identifier'] ?? 'N/A';
    }

    return BookModel(
      id: json['id'] ?? '',
      title: volumeInfo['title'] ?? 'Unknown Title',
      author: (volumeInfo['authors'] as List?)?.join(', ') ?? 'Unknown Author',
      category: (volumeInfo['categories'] as List?)?.join(', ') ?? 'General',
      publisher: volumeInfo['publisher'] ?? 'Unknown Publisher',
      year: volumeInfo['publishedDate']?.toString().split('-').first ?? 'N/A',
      isbn: fetchedIsbn,
      summary: volumeInfo['description'] ?? 'No description available.',
      coverUrl: imageLinks['thumbnail'] ?? 'https://via.placeholder.com/150',
      status: 'available',
    );
  }

  // Konversi ke Map untuk Firebase Firestore
  Map<String, dynamic> toMap() {
    return {
      'book_id': id,
      'title': title,
      'author': author,
      'category': category,
      'publisher': publisher,
      'year': year,
      'isbn': isbn,
      'summary': summary,
      'cover_url': coverUrl,
      'status': status,
    };
  }
}