import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perpus_flutter/components/bottom_nav_screen.dart';
import 'package:perpus_flutter/components/book_card.dart';
import 'package:perpus_flutter/components/app_bar.dart';
import 'package:perpus_flutter/models/book.dart';

class BukuScreen extends StatefulWidget {
  const BukuScreen({super.key});

  @override
  State<BukuScreen> createState() => _BukuScreenState();
}

class _BukuScreenState extends State<BukuScreen> {
  late Future<List<Book>> _futureBooks;

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.10:8000/api/koleksi'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception(
        'Gagal memuat buku: ${response.statusCode}\n${response.body}',
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _futureBooks = fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 8),
                child: const Text(
                  'Koleksi Buku',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: FutureBuilder<List<Book>>(
                  future: _futureBooks,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('Tidak ada buku tersedia.'),
                      );
                    } else {
                      final books = snapshot.data!;
                      return GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 20,
                        children:
                            books
                                .map(
                                  (book) => BookCard(
                                    title: book.title,
                                    image: book.image,
                                    isbn: book.isbn,
                                    description: book.description,
                                    author: book.author,
                                    publisher: book.publisher,
                                    publicationYear: book.publicationYear,
                                    synopsis: book.synopsis,
                                    genre: book.genre,
                                  ),
                                )
                                .toList(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavComponent(
        selectedIndex: 1,
        onItemTapped: (index) {
          final routes = [
            '/dashboard',
            '/buku',
            '/riwayatUsulan',
            '/informasi',
            '/profil',
          ];
          Navigator.pushReplacementNamed(context, routes[index]);
        },
      ),
    );
  }
}
