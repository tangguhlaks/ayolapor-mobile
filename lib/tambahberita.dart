import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambah Berita',
      theme: ThemeData(
        primaryColor: Colors.red, // Menggunakan primary color merah
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TambahBeritaPage(),
    );
  }
}

class TambahBeritaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Berita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TambahBeritaForm(),
      ),
    );
  }
}

class TambahBeritaForm extends StatefulWidget {
  @override
  _TambahBeritaFormState createState() => _TambahBeritaFormState();
}

class _TambahBeritaFormState extends State<TambahBeritaForm> {
  // Controllers untuk field input
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();

  // Method untuk menghandle submit form
  void _submitForm() {
    // Mendapatkan nilai dari controller dan menyimpannya dalam variabel lokal
    String judul = _judulController.text;
    String isi = _isiController.text;

    // Lakukan sesuatu dengan data yang di-input
    // Misalnya, menampilkan nilai judul dan isi dalam pesan Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Judul: $judul, Isi: $isi')),
    );

    // Setelah submit, kosongkan field input
    _judulController.clear();
    _isiController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Input judul
        TextField(
          controller: _judulController,
          decoration: InputDecoration(
            labelText: 'Judul',
          ),
        ),
        SizedBox(height: 16.0), // Spasi antara field
        // Input isi berita
        TextField(
          controller: _isiController,
          maxLines: null, // Maksimum baris tidak terbatas
          decoration: InputDecoration(
            labelText: 'Isi Berita',
          ),
        ),
        SizedBox(height: 16.0), // Spasi antara field
        // Tombol untuk submit
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Tambah Berita'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Clean up controller ketika widget di-dispose
    _judulController.dispose();
    _isiController.dispose();
    super.dispose();
  }
}
