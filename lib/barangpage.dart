import 'package:flutter/material.dart';
import 'package:ucp1_flutter/detail_barang.dart';

class BarangPage extends StatefulWidget {
  const BarangPage({super.key});

  @override
  State<BarangPage> createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  String? jenisTransaksi;
  String? jenisBarang;
  final List<String> listJenisTransaksi = ['Barang Masuk', 'Barang Keluar'];
  final List<String> listJenisBarang = ['Elektronik', 'Pakaian', 'Makanan'];
  bool _tanggalError = false;

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        tanggalController.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
        _tanggalError = false;
      });
    }
  }

  void _submitData() {
    final isValid = _formKey.currentState?.validate() ?? false;
    setState(() {
      _tanggalError = tanggalController.text.isEmpty;
    });

    if (!isValid || _tanggalError) return;

    final jumlah = int.tryParse(jumlahController.text);
    final harga = int.tryParse(hargaController.text);

    if (jumlah == null || harga == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Jumlah dan Harga harus berupa angka yang valid")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailBarang(
          tanggal: tanggalController.text,
          jenisTransaksi: jenisTransaksi!,
          jenisBarang: jenisBarang!,
          jumlahBarang: jumlah,
          hargaSatuan: harga,
        ),
      ),
    );

    setState(() {
      tanggalController.clear();
      jumlahController.clear();
      hargaController.clear();
      jenisTransaksi = null;
      jenisBarang = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendataan Barang', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFFDF4F1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tanggal Transaksi'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _selectDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: tanggalController,
                    decoration: InputDecoration(
                      hintText: 'Tanggal Transaksi',
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      errorText: _tanggalError ? 'Tanggal tidak boleh kosong' : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: jenisTransaksi,
                items: listJenisTransaksi
                    .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                    .toList(),
                onChanged: (value) => setState(() => jenisTransaksi = value),
                decoration: InputDecoration(
                  hintText: 'Jenis Transaksi',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
                validator: (value) => value == null ? 'Pilih jenis transaksi' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: jenisBarang,
                items: listJenisBarang
                    .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                    .toList(),
                onChanged: (value) => setState(() => jenisBarang = value),
                decoration: InputDecoration(
                  hintText: 'Jenis Barang',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
                validator: (value) => value == null ? 'Pilih jenis barang' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Jumlah Barang'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: jumlahController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Jumlah Barang',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Jumlah barang tidak boleh kosong' : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Harga Satuan'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: hargaController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: 'Rp. ',
                            hintText: 'Harga Satuan',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Harga satuan tidak boleh kosong' : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
