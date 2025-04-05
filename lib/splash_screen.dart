// File ini adalah layar splash untuk aplikasi kuis D4 Manajemen Informatika.
// Layar ini akan menampilkan teks pembuka dan indikator loading sebelum
// berpindah ke layar kuis utama setelah 5 detik.

import 'dart:async'; // Untuk menggunakan Timer
import 'package:flutter/material.dart'; // Untuk widget Material Design
import 'quiz_screen.dart'; // Mengimpor layar kuis untuk navigasi

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer untuk menunggu selama 5 detik sebelum berpindah ke layar kuis
    Timer(Duration(seconds: 5), () {
      if (mounted) { // Mengecek apakah widget masih ada di widget tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => QuizScreen()), // Navigasi ke layar kuis
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash.jpg"), // Gambar latar belakang
            fit: BoxFit.cover, // Menyesuaikan gambar agar memenuhi layar
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Menempatkan elemen secara vertikal di tengah
            children: [
              // Menampilkan teks pembuka
              Text(
                "Selamat Datang di Kuis D4 Manajemen Informatika", // Teks pembuka
                style: TextStyle(
                  fontSize: 24, // Ukuran font
                  fontWeight: FontWeight.bold, // Teks tebal
                  color: Colors.blueAccent, // Warna teks
                ),
                textAlign: TextAlign.center, // Teks rata tengah
              ),
              SizedBox(height: 20), // Memberikan jarak antara teks dan indikator loading
              // Menampilkan indikator loading
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Warna indikator loading
              ),
              SizedBox(height: 20), // Memberikan jarak antara indikator loading dan teks "Memuat..."
              // Menampilkan teks "Memuat..."
              Text(
                "Memuat...", // Teks untuk menunjukkan proses loading
                style: TextStyle(
                  fontSize: 16, // Ukuran font
                  color: Colors.white, // Warna teks
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
