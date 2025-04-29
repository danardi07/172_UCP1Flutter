import 'package:flutter/material.dart';

class DetailBarang extends StatelessWidget {
  final String tanggal;
  final String jenisTransaksi;
  final String jenisBarang;
  final int jumlahBarang;
  final int hargaSatuan;

  const DetailBarang({
    super.key,
    required this.tanggal,
    required this.jenisTransaksi,
    required this.jenisBarang,
    required this.jumlahBarang,
    required this.hargaSatuan,
  });

  @override
  Widget build(BuildContext context) {
    final int totalHarga = jumlahBarang * hargaSatuan;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF4F1),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 16),
            const Text(
              'Data Berhasil Disimpan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            buildRow('Tanggal', tanggal),
            buildRow('Jenis Transaksi', jenisTransaksi),
            buildRow('Jenis Barang', jenisBarang),
            buildRow('Jumlah Barang', jumlahBarang.toString()),
            buildRow('Harga Satuan', 'Rp. ${hargaSatuan.toString()}'),
            buildRow('Total Harga', 'Rp. ${totalHarga.toString()}'),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Selesai'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
