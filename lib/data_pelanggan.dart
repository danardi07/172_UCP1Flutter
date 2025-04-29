import 'package:flutter/material.dart';
import 'package:ucp1_flutter/detail_pelanggan.dart';

class DataPelangganPage extends StatefulWidget {
  const DataPelangganPage({super.key});

  @override
  State<DataPelangganPage> createState() => _DataPelangganPageState();
}


class _DataPelangganPageState extends State<DataPelangganPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _provinsiController = TextEditingController();
  final TextEditingController _kodePosController = TextEditingController();

  void _resetForm() {
    _formKey.currentState?.reset();
    _namaController.clear();
    _emailController.clear();
    _noHpController.clear();
    _alamatController.clear();
    _provinsiController.clear();
    _kodePosController.clear();
  }

  void _simpanData() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailPelangganPage(
            nama: _namaController.text,
            email: _emailController.text,
            noHp: _noHpController.text,
            alamat: _alamatController.text,
            provinsi: _provinsiController.text,
            kodePos: _kodePosController.text,
          ),
        ),
      );
    }
  }

  Widget _buildInput(String label, TextEditingController controller, String errorText,
      {TextInputType inputType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
      ),
      validator: (value) => value!.isEmpty ? errorText : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pelanggan'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildInput('Nama Cust', _namaController, 'Cust tidak boleh kosong'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildInput('Email', _emailController, 'Email tidak boleh kosong',
                        inputType: TextInputType.emailAddress),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildInput('No Hp', _noHpController, 'No Hp tidak boleh kosong',
                        inputType: TextInputType.phone),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInput('Alamat', _alamatController, 'Alamat tidak boleh kosong'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildInput('Provinsi', _provinsiController, 'Provinsi tidak boleh kosong'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildInput('Kode Pos', _kodePosController, 'Pos tidak boleh kosong',
                        inputType: TextInputType.number),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _simpanData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Simpan'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: _resetForm,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
