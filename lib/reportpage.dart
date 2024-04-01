import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Laporan',
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
          onPressed: () {},
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
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Implement your button action here
              },
              icon: Icon(Icons.add, color: Colors.white),
              label:
                  Text('Tambah Laporan', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(148, 31)),
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 229, 75, 75),
                ),
              ),
            ),
            SizedBox(height: 8),
            Column(
              children: [
                buildOption('Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                    'Menunggu Tindak Lanjut Kemahasiswaan'),
                buildOption('Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                    'Menunggu Tindak Lanjut Dosen Wali'),
                buildOption('Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                    'Sudah Ditindak Lanjut Dosen Wali'),
                buildOption('Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                    'Save Draft'),
                buildOption(
                    'Lord Tangguh', Icons.more_vert, '20 Mei 2023', 'Selesai'),
                buildOption('Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                    'Laporan Dibatalkan'),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
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
