import 'package:flutter/material.dart';

class DetailTugasPage extends StatelessWidget {
  final String nama;
  final String tanggal;
  final String tugas;

  const DetailTugasPage({
    super.key,
    required this.nama,
    required this.tanggal,
    required this.tugas,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Detail Menyapu', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      backgroundColor: const Color(0xFFFDF4F1),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tanggal, style: const TextStyle(fontSize: 16, color: Colors.deepOrange)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Text(nama, style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                tugas,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
