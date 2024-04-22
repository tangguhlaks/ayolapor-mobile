import 'package:flutter/material.dart';
import 'buatlaporan.dart'; // Import file BuatLaporanPage

class HomePage extends StatelessWidget {
  // Fungsi untuk navigasi ke halaman BuatLaporanPage
  void _navigateToBuatLaporan(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BuatLaporan()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white, // Mengubah warna latar belakang menjadi putih
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.assignment_turned_in,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '2 Laporan Ditanggapi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Tangguh Laksana'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Tutup'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    color: Colors.black,
                    size: 40,
                  ),
                  SizedBox(width: 10), // Spasi antara ikon dan teks
                ],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 300, // Lebar diagram
              height: 300, // Tinggi diagram
              child: CustomPaint(
                painter: MyChartPainter(),
              ),
            ),
          ),
          Positioned(
            top: 130, // Atur posisi tombol di atas diagram
            left: 30,
            child: ElevatedButton.icon(
              onPressed: () {
                // Tambahkan logika ketika tombol "Riwayat" ditekan
              },
              icon: Icon(Icons.history), // Icon untuk tombol "Riwayat"
              label: Text('Riwayat'), // Label untuk tombol "Riwayat"
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: 50), // Atur padding tombol
                textStyle: TextStyle(fontSize: 16), // Atur ukuran teks tombol
              ),
            ),
          ),
          Positioned(
            top: 130, // Atur posisi tombol di atas diagram
            right: 30,
            child: ElevatedButton.icon(
              onPressed: () {
                _navigateToBuatLaporan(
                    context); // Navigasi ke halaman Buat Laporan
              },
              icon: Icon(Icons.add_circle), // Icon untuk tombol "Tambah Lapor"
              label: Text('Tambah Lapor'), // Label untuk tombol "Tambah Lapor"
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 50), // Atur padding tombol
                textStyle: TextStyle(fontSize: 16), // Atur ukuran teks tombol
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.assignment_turned_in,
                      color: Colors.red,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Pelecehan: 1',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.assignment_turned_in,
                      color: Colors.red,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Kekerasan: 1',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bluePaint = Paint()
      ..color = Colors.blue // Warna untuk laporan pelecehan
      ..style = PaintingStyle.fill;

    final Paint redPaint = Paint()
      ..color = Colors.red // Warna untuk laporan kekerasan
      ..style = PaintingStyle.fill;

    final double center = size.width / 2;
    final double radius = size.width / 2;
    final double startAngle = 0;

    // Sudut yang menunjukkan proporsi dari masing-masing laporan
    final double totalSweepAngle = 2 * 3.14; // 360 derajat
    final double pelecehanSweepAngle =
        totalSweepAngle / 2; // Sudut setengah lingkaran
    final double kekerasanSweepAngle =
        totalSweepAngle / 2; // Sudut setengah lingkaran

    // Gambar bagian laporan pelecehan
    canvas.drawArc(
        Rect.fromCircle(center: Offset(center, center), radius: radius),
        startAngle,
        pelecehanSweepAngle,
        true,
        bluePaint);

    // Gambar bagian laporan kekerasan
    canvas.drawArc(
        Rect.fromCircle(center: Offset(center, center), radius: radius),
        startAngle + pelecehanSweepAngle,
        kekerasanSweepAngle,
        true,
        redPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

void main() {
  runApp(MaterialApp(home: HomePage()));
}
