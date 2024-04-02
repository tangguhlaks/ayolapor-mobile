import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
            child: Row(
              children: [
                Icon(
                  Icons.account_circle,
                  color: Colors.black,
                  size: 40,
                ),
                SizedBox(width: 10), // Spasi antara ikon dan teks
                Text(
                  'Tangguh Laksana',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
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
    final double pelecehanSweepAngle = totalSweepAngle / 2; // Sudut setengah lingkaran
    final double kekerasanSweepAngle = totalSweepAngle / 2; // Sudut setengah lingkaran

    // Gambar bagian laporan pelecehan
    canvas.drawArc(Rect.fromCircle(center: Offset(center, center), radius: radius), startAngle, pelecehanSweepAngle, true, bluePaint);

    // Gambar bagian laporan kekerasan
    canvas.drawArc(Rect.fromCircle(center: Offset(center, center), radius: radius), startAngle + pelecehanSweepAngle, kekerasanSweepAngle, true, redPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

void main() {
  runApp(MaterialApp(home: HomePage()));
}
