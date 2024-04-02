import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TambahLaporanPage()));
}

class TambahLaporanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Laporan',
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
      body: TambahLaporanForm(),
    );
  }
}

class TambahLaporanForm extends StatefulWidget {
  @override
  _TambahLaporanFormState createState() => _TambahLaporanFormState();
}

class _TambahLaporanFormState extends State<TambahLaporanForm> {
  TextEditingController _buktiController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upload Bukti',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _buktiController,
            decoration: InputDecoration(
              hintText: 'Upload Bukti',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Deskripsi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _deskripsiController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Deskripsi Kasus',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Add your submit logic here
            },
            child: Text('Kirim'),
          ),
        ],
      ),
    );
  }
}
