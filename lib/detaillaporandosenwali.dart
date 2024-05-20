import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailLaporanDosenWali extends StatelessWidget {
  final String type;
  final int reportIndex;
  final Function(String) onStatusChanged;

  DetailLaporanDosenWali({
    required this.type,
    required this.reportIndex,
    required this.onStatusChanged,
    Key? key,
  }) : super(key: key);

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
            Navigator.pop(context);
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
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Pelecehan',
                    border: InputBorder.none,
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
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  minLines: 5,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Saya dilecehkan di toilet TULT',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
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
              height: 50,
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
              height: 50,
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
      var url = Uri.parse('https://ayolapor-api.evolve-innovation.com/api/report/4');
      var response = await http.put(
        url,
        body: {
          "title": "asdf",
          "type": "Bullying",
          "prove": "1715237496_p-removebg.png",
          "description": "Tes dari aplikasi",
          "status": newStatus,
          "mahasiswa": "1",
          "dosen_wali": "3",
        },
      );

      if (response.statusCode == 200) {
        onStatusChanged(newStatus);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Berhasil'),
              content: Text('Berhasil mengirim permintaan ke server.'),
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
      } else {
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
