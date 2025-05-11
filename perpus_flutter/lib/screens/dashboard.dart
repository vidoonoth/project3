import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:perpus_flutter/components/bottom_nav_screen.dart';
import 'package:perpus_flutter/components/info_card.dart';
import 'package:perpus_flutter/components/book_card.dart';
import 'package:perpus_flutter/components/app_bar.dart';
import 'package:perpus_flutter/components/search_custom.dart';
import 'package:perpus_flutter/components/category_chips.dart';
import 'package:perpus_flutter/screens/usulan.dart';

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

  // Future<void> logout() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');

  //   if (token == null) return;

  //   final response = await http.post(
  //     Uri.parse('http://192.168.1.39:8000/api/logout'),
  //     headers: {'Authorization': 'Bearer $token'},
  //   );

  //   if (response.statusCode == 200) {
  //     await prefs.remove('token');
  //     if (mounted) {
  //       Navigator.pushReplacementNamed(context, '/login');
  //     }
  //   }
  // }

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
              padding: EdgeInsets.all(16.0),
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
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Koleksi Buku',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 16),
                      SearchBarCustom(),
                      SizedBox(height: 16),
                      CategoryChipsCustom(),
                      SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Row(
                          spacing: 10,
                          children: [
                            BookCard(
                              title: 'Bintang',
                              image: 'assets/book_images/bintang.jpeg',
                            ),
                            BookCard(
                              title: 'Hujan',
                              image: 'assets/book_images/hujan.jpeg',
                            ),
                            BookCard(
                              title: 'Laut Bercerita',
                              image: 'assets/book_images/laut_bercerita.jpg',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavComponent(
            selectedIndex:
                0, // Pastikan ini sesuai dengan indeks halaman Dashboard
            onItemTapped: (index) {
              if (index == 0) {
                Navigator.pushReplacementNamed(context, '/dashboard');
              } else if (index == 1) {
                Navigator.pushReplacementNamed(context, '/buku');
              } else if (index == 2) {
                Navigator.pushReplacementNamed(context, '/riwayatUsulan');
              } else if (index == 3) {
                Navigator.pushReplacementNamed(context, '/informasi');
              } else if (index == 4) {
                Navigator.pushReplacementNamed(context, '/profil');
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
