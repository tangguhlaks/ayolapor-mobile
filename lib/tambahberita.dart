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
        title: const Text(
          'Tambah Berita',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.red,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context); // Kembali ke tampilan sebelumnya
          },
        ),
        elevation: 4,
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
    SnackBar(
      content: Text(
        'Berita Berhasil Dibuat',
        style: TextStyle(color: Colors.white), // Mengatur warna teks menjadi putih
      ),
      backgroundColor: Colors.green, // Mengatur warna latar belakang menjadi merah
    ),
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
        // Upload Image
        InkWell(
          onTap: () {
            // Tindakan ketika gambar diupload
          },
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              Icons.add_a_photo,
              size: 48,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 16.0), // Spasi antara field
        // Input judul
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            controller: _judulController,
            decoration: InputDecoration(
              labelText: 'Judul',
              contentPadding: EdgeInsets.all(8.0),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 16.0), // Spasi antara field
        // Input isi berita
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            controller: _isiController,
            maxLines: null, // Maksimum baris tidak terbatas
            decoration: InputDecoration(
              labelText: 'Isi Berita',
              contentPadding: EdgeInsets.all(8.0),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 16.0), // Spasi antara field
        // Tombol untuk submit
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Tambah Berita', style: TextStyle(color: Colors.white)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
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
