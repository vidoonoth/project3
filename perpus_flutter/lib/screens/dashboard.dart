import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:perpus_flutter/components/bottom_nav_screen.dart';
import 'package:perpus_flutter/components/info_card.dart';
import 'package:perpus_flutter/components/book_card.dart';
import 'package:perpus_flutter/components/app_bar.dart';
import 'package:perpus_flutter/components/search_custom.dart';
import 'package:perpus_flutter/components/category_chips.dart';
import 'package:perpus_flutter/screens/usulan.dart';
import 'package:perpus_flutter/models/book.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

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
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: CustomAppBar(),
          body: RefreshIndicator(
            onRefresh: () async => setState(() {}),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeText(),
                  InfoCard(
                    title: 'Selamat datang',
                    description:
                        'Di Perpustakaan Indramayu. Mari ajukan usulan buku!',
                    iconPath: 'assets/welcome.svg',
                  ),
                  InfoCard(
                    title: 'Pengusulan',
                    description:
                        'Saatnya mengusulkan buku agar koleksi perpustakaan semakin menarik!',
                    iconPath: 'assets/pengusulan_login.svg',
                    buttonText: "Sampaikan Judulmu!",
                    onButtonPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Usulan()),
                      );
                    },
                    iconOnLeft: true,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Koleksi Buku',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SearchBarCustom(),
                      const SizedBox(height: 16),
                      CategoryChipsCustom(),
                      const SizedBox(height: 16),
                      FutureBuilder<List<Book>>(
                        future: fetchBooks(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(child: Text('Tidak ada buku.'));
                          } else {
                            final books = snapshot.data!;
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children:
                                    books.map((book) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10.0,
                                        ),
                                        child: BookCard(
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
                                      );
                                    }).toList(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavComponent(
            selectedIndex: 0,
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
      },
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Hi, Alfin',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Ayo mulai mengusulkan buku.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
