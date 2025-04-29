import 'package:flutter/material.dart';
import 'package:ucp1_flutter/barangpage.dart';
import 'package:ucp1_flutter/data_pelanggan.dart';
import 'package:ucp1_flutter/data_piket.dart';
import 'package:ucp1_flutter/homepage.dart';
import 'package:ucp1_flutter/loginpage.dart';
import 'package:ucp1_flutter/registerpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UCP Flutter 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterPage());
          case '/home':
            final email = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => HomePage(email: email),
            );
          case '/piket':
            return MaterialPageRoute(builder: (_) => const DataPiketPage());
          case '/pelanggan':
            return MaterialPageRoute(builder: (_) => const DataPelangganPage());
          case '/barang':
            return MaterialPageRoute(builder: (_) => const BarangPage());
          default:
            return null;
        }
      },
    );
  }
}
