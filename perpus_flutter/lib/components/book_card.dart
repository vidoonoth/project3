import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String image;

  const BookCard({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          isScrollControlled: true,
          builder: (_) => BookDetailModal(title: title, image: image),
        );
      },
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
          
        ),
        width: 120,
        
        child: Column(
          mainAxisSize:
              MainAxisSize.min, 
          children: [
            SizedBox(
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(image, fit: BoxFit.cover, height: 300),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),            
          ],
        ),
      ),
    );
  }
}

class BookDetailModal extends StatelessWidget {
  final String title;
  final String image;

  const BookDetailModal({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    onPressed: () {
                      Navigator.pop(context); // Menutup modal
                    },
                  ),
                  const Text(
                    "detail buku",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.favorite_border),
                ],
              ),
              const SizedBox(height: 16),

              // Book cover
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(image, height: 200),
              ),
              const SizedBox(height: 12),

              // Title & author
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Tere Liye",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Penerbit & Tahun
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Column(
                    children: [
                      Text(
                        "Penerbit",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text("Gramedia"),
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      Text(
                        "Tahun",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text("2016"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Sinopsis
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sinopsis",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Lorem ipsum dolor sit amet.dadsadadav dsnbsncijs cscss sskdskdhk ahdakh dkah dkas fsfs skdk sbjs "
                "dada eqefe vdkcsad wcqwqwq r4rbrewq fvkcej mnhhkkjdsjadjd dw d wdwdw dwdw dwdwdw "
                "wecewdww dwwdwefgewf werwvweew wewwecw",
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // Kategori Chips
              Wrap(
                spacing: 12,
                children: const [
                  Chip(label: Text("Fiksi")),
                  Chip(label: Text("Novel")),
                  Chip(label: Text("Drama")),
                  Chip(label: Text("non-fiksi")),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
