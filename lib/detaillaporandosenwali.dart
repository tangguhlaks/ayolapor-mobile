import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailLaporanDosenWali extends StatelessWidget {
  //final Function(String) onStatusChanged;
  final String type;

  DetailLaporanDosenWali({required this.type,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          type,
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
      body: DetailLaporanBody(context),
    );
  }

  Widget DetailLaporanBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text("Jenis Laporan", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0), // Optional: rounded corners
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                ), // Padding inside the container
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Pelecehan',
                    border: InputBorder.none, // Optional: remove border
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Bukti", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Image(image: AssetImage("assets/berita.jpg")),
            SizedBox(height: 10),
            Text("Keterangan", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0), // Optional: rounded corners
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                ), // Padding inside the container
                child: TextField(
                  minLines: 5, // Jumlah minimal baris
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Saya dilecehkan di toilet TULT',
                    border: InputBorder.none, // Optional: remove border
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50, // Mengatur tinggi tombol
              child: ElevatedButton(
                onPressed: () => _updateStatus('Tolak Laporan', context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                ),
                child: Text(
                  'Tolak Laporan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 50, // Mengatur tinggi tombol
              child: ElevatedButton(
                onPressed: () => _updateStatus('Tindak Lanjuti', context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text(
                  'Tindak Lanjuti',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 50, // Mengatur tinggi tombol
              child: ElevatedButton(
                onPressed: () => _updateStatus('Selesai', context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  'Selesai',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateStatus(String newStatus, BuildContext context) async {
    try {
      var url = Uri.parse('https://ayolapor-api.evolve-innovation.com/api/report');
      var response = await http.post(
        url,
        body: {
          'status': newStatus,
          // Mungkin Anda perlu menambahkan lebih banyak data di sini sesuai dengan kebutuhan API
        },
      );

      if (response.statusCode == 200) {
        // Berhasil mengirim permintaan, Anda mungkin ingin menangani respons API di sini
        // onStatusChanged(newStatus);
      } else {
        // Gagal mengirim permintaan, tangani kesalahan di sini
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Gagal mengirim permintaan ke server.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Tangani kesalahan jaringan atau kesalahan lainnya di sini
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
