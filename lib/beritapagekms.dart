import 'package:flutter/material.dart';
import 'tambahberita.dart'; // Impor file tambahberita.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BeritaPageKms(),
    );
  }
}

class BeritaPageKms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Berita',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman TambahBeritaPage saat tombol ditekan
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahBeritaPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor:
            Colors.red, // Atur warna latar belakang tombol menjadi merah
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 150,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Judul Berita ${index + 1}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
