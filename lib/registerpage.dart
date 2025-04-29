import 'package:flutter/material.dart';
import 'package:ucp1_flutter/loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController konfirmasiController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;


  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Icon(Icons.arrow_drop_up, size: 200, color: Colors.black),
                  const Text(
                    'DAFTAR AKUN BARU',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF2A2424)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Nama Lengkap', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: namaController,
                    decoration: _inputDecoration('Nama Lengkap', Icons.person),
                    validator: (value) =>
                        value!.isEmpty ? 'Nama lengkap tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: emailController,
                              decoration: _inputDecoration('Email', Icons.email),
                              validator: (value) =>
                                  value!.isEmpty ? 'Email tidak boleh kosong' : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('No HP', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: hpController,
                              decoration: _inputDecoration('No HP', Icons.phone),
                              validator: (value) =>
                                  value!.isEmpty ? 'No HP tidak boleh kosong' : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Password', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: passwordController,
                              obscureText: _obscurePassword,
                              decoration: _passwordDecoration(
                                hintText: 'Password',
                                icon: Icons.lock,
                                obscure: _obscurePassword,
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              validator: (value) =>
                                  value!.isEmpty ? 'Password tidak boleh kosong' : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Konfirmasi Password', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: konfirmasiController,
                              obscureText: _obscureConfirm,
                              decoration: _passwordDecoration(
                                hintText: 'Konfirmasi Password',
                                icon: Icons.lock,
                                obscure: _obscureConfirm,
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirm = !_obscureConfirm;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Konfirmasi password tidak boleh kosong';
                                }
                                if (value != passwordController.text) {
                                  return 'Password tidak sama';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF3D00),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 4,
                      ),
                      child: const Text('Daftar', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah memiliki akun? Silahkan '),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          'Login disini!',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF5C4033)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }

  InputDecoration _passwordDecoration({
    required String hintText,
    required IconData icon,
    required bool obscure,
    required VoidCallback onPressed,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon, color: const Color(0xFF5C4033)),
      suffixIcon: IconButton(
        icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
        onPressed: onPressed,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }
}
