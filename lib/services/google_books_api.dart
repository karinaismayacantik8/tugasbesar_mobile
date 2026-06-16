import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

class GoogleBooksApiService {
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  Future<List<BookModel>> searchBooks(String keyword) async {
    if (keyword.isEmpty) return [];
    
    final url = Uri.parse('$_baseUrl?q=${Uri.encodeComponent(keyword)}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['items'] as List?;
        if (items != null) {
          return items.map((item) => BookModel.fromGoogleBooks(item)).toList();
        }
      }
      return [];
    } catch (e) {
      print('Error fetching Google Books: $e');
      return [];
    }
  }
}