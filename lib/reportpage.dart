import 'package:ayolapor/buatlaporan.dart';
import 'package:ayolapor/detaillaporan.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
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
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuatLaporan()),
                );// Implement your button action here
              },
              icon: Icon(Icons.add, color: Colors.white),
              label:
                  Text('Tambah Laporan', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(148, 31)),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.red,
                ),
              ),
            ),
            SizedBox(height: 8),
            buildOption(context,'Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                'Menunggu Tindak Lanjut Kemahasiswaan'),
            buildOption(context,'Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                'Menunggu Tindak Lanjut Dosen Wali'),
            buildOption(context,'Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                'Sudah Ditindak Lanjut Dosen Wali'),
            buildOption(context,
                'Lord Tangguh', Icons.more_vert, '20 Mei 2023', 'Save Draft'),
            buildOption(context,
                'Lord Tangguh', Icons.more_vert, '20 Mei 2023', 'Selesai'),
            buildOption(context,'Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                'Laporan Dibatalkan'),
            buildOption(context,'Lord Tangguh', Icons.more_vert, '20 Mei 2023',
                'Menunggu Tindak Lanjut Kemahasiswaan'),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget buildOption(BuildContext context,String text, IconData icon, String date, String status) {
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
        trailing:GestureDetector(
          child:  Icon(icon, color: Colors.red, size: 24,),
          onTap: () => {
            _showOptions(context,)
          },
        ),
      ),
    );
  }

void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children:[
              ListTile(
                leading: Icon(Icons.search),
                title: Text('Detail'),
                onTap: () {
                  // Handle delete option
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailLaporan("Detail")),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailLaporan("Edit")),
                  );
                },
                
              ),
              ListTile(
                leading: Icon(Icons.close),
                title: Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                },
                
              ),
            ],
          ),
        );
      },
    );
  }

}



