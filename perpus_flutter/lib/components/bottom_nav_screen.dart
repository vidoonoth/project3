import 'package:flutter/material.dart';

class BottomNavComponent extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavComponent({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFF8FAFC),
      type: BottomNavigationBarType.fixed, // Mencegah perubahan ukuran
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Buku'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Usulan'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Informasi'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    );
  }
}
