import 'package:flutter/material.dart';
import 'package:ucp1_flutter/detail_piket.dart';

class DataPiketPage extends StatefulWidget {
  const DataPiketPage({super.key});

  @override
  State<DataPiketPage> createState() => _DataPiketPageState();
}


class _DataPiketPageState extends State<DataPiketPage> {
  final _formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final tugasController = TextEditingController();
  DateTime? selectedDate;
  final List<Map<String, String>> tugasList = [];
  bool _tanggalError = false;

  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _tanggalError = false;
      });
    }
  }

  void _tambahTugas() {
    final isValid = _formKey.currentState?.validate() ?? false;
    setState(() {
      _tanggalError = selectedDate == null;
    });

    if (isValid && !_tanggalError) {
      setState(() {
        tugasList.add({
          'nama': namaController.text,
          'tanggal': "${selectedDate!.day.toString().padLeft(2, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.year}",
          'tugas': tugasController.text,
        });
        tugasController.clear();
        selectedDate = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Piket Gudang', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      backgroundColor: const Color(0xFFFDF4F1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nama Anggota'),
              const SizedBox(height: 4),
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
                validator: (value) =>
                          value == null || value.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              const Text('Pilih Tanggal'),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: _selectDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: selectedDate == null
                          ? 'Pilih Tanggal'
                          : "${selectedDate!.day.toString().padLeft(2, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.year}",

                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      errorText: _tanggalError ? 'Tanggal tidak boleh kosong' : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Tugas Piket'),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: tugasController,
                      decoration: InputDecoration(
                        hintText: 'Tugas Piket',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Tugas tidak boleh kosong' : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: _tambahTugas,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('Tambah'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Daftar Tugas Piket',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: tugasList.isEmpty
                    ? const Center(child: Text('Belum ada Data'))
                    : ListView.builder(
                        itemCount: tugasList.length,
                        itemBuilder: (context, index) {
                          final item = tugasList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailTugasPage(
                                      nama: item['nama']!,
                                      tanggal: item['tanggal']!,
                                      tugas: item['tugas']!,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item['tugas']!, style: const TextStyle(fontSize: 16)),
                                  const Icon(Icons.arrow_forward, color: Colors.white),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
