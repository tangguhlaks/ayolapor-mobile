import 'package:flutter/material.dart';

class ReportPageDosenWali extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Report',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildOption('Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                'Menunggu Tindak Lanjut Kemahasiswaan'),
            buildOption('Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                'Menunggu Tindak Lanjut Dosen Wali'),
            buildOption('Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                'Sudah Ditindak Lanjut Dosen Wali'),
            buildOption('Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                'Laporan Ditolak'),
            buildOption('Lord Tangguh', Icons.more_vert, '21 Mei 2023',
                'Selesai'),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget buildOption(String text, IconData icon, String date, String status) {
    Color statusColor = Colors.red;
    if (status == 'Selesai' || status == 'Sudah Ditindak Lanjut Dosen Wali') {
      statusColor = Colors.green;
    } else if (status == 'Save Draft') {
      statusColor = Colors.yellow;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        title: Text(text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: TextStyle(fontWeight: FontWeight.w100)),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                status,
                style: TextStyle(color: statusColor),
              ),
            ),
          ],
        ),
        trailing: Icon(icon, color: Colors.red, size: 24),
      ),
    );
  }
}


