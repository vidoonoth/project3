import 'package:flutter/material.dart';
import 'package:perpus_flutter/components/bottom_nav_screen.dart';
import 'package:perpus_flutter/components/book_card.dart';
import 'package:perpus_flutter/components/app_bar.dart';

class BukuScreen extends StatelessWidget {
  const BukuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: const Color(0xFFF8FAFC),
      // ✅ Gunakan SafeArea agar tidak terjadi overflow karena notch atau bottom nav
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
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  children: const [
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
                    BookCard(
                      title: 'Laskar Pelangi',
                      image: 'assets/book_images/bintang.jpeg',
                    ),
                    BookCard(
                      title: 'Filosofi Kopi',
                      image: 'assets/book_images/bintang.jpeg',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // ✅ Bottom Navigation tetap
      bottomNavigationBar: BottomNavComponent(
        selectedIndex: 1,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/buku');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/usulan');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/informasi');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/profil');
          }
        },
      ),
    );
  }
}
