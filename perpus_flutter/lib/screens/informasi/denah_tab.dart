import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DenahTab extends StatelessWidget {
  const DenahTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Denah & Peta',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Alamat:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Jl. Mt Haryono No.49, Penganjang, Sindang, Kabupaten Indramayu, Jawa Barat 45222.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final Uri url = Uri.parse(
                  'https://maps.app.goo.gl/HaDmQQVSLqS4JM81A',
                );
                print("Coba buka: $url");
                if (await canLaunchUrl(url)) {
                  print("Bisa dibuka");
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  print("Tidak bisa membuka URL");
                }
              },

              child: const Text('Buka di Google Maps'),
            ),
          ],
        ),
      ),
    );
  }
}
