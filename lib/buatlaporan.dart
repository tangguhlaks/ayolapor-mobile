import 'package:flutter/material.dart';

class BuatLaporan extends StatefulWidget {
  @override
  _BuatLaporanState createState() => _BuatLaporanState();
}

class _BuatLaporanState extends State<BuatLaporan> {
  List<String> items = ['Pelecehan', 'Seksual', 'Bullying'];
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buat Laporan',
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.announcement,
              color: Colors.red,
              size: 24,
            ),
            onPressed: () {},
          )
        ],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Jenis Laporan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              iconEnabledColor: Colors.red,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(width: 3, color: Colors.grey),
                ),
              ),
              value: selectedItem,
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (item) {
                setState(() {
                  selectedItem = item;
                });
              },
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Implement your button action here
                },
                icon: Icon(Icons.add, color: Colors.white),
                label:
                    Text('Upload Bukti', style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(148, 31)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.red,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Upload File Kamu',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Keterangan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement your first button action here
              },
              child: Text(
                'Save As Draft',
                style: TextStyle(color: Colors.red),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(541, 41)),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement your second button action here
              },
              child: Text(
                'Simpan & Laporkan',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(541, 41)),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
