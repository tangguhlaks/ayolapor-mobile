import 'package:ayolapor/buatlaporan.dart';
import 'package:ayolapor/detaillaporan.dart';
//import 'package:ayolapor/detaillaporankemahasiswaan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'GlobalConfig.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<dynamic> reports = [];

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  Future<void> fetchReports() async {
    var headers = {
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6ImhjekZVVFREM1k3QVkwUCtZUkVpc0E9PSIsInZhbHVlIjoibGJ6VjBDc3BIdVBLSHc4TXZabCtsaTFBOHp3RDYxSzdmZmpYdGtzY3NqVUFDeTdiZ05RbXF5UXI2TDhRdXNsT0dURGZFU3R5dnI0eVRsNTd0K0JIWmVsSTNmNHRNSmRjMUpjVDg3MnFScjFHNEw4T3ZYNzBadGdnZHk2RlUwdTIiLCJtYWMiOiI1ZTIxNGFkZDg0ZjBkYjg0NDI4NWJiZDYwMzhmZTQyYTQwMzZmNWI0MDllODVjOWZmZGViN2RmZTBhY2IzNTM1IiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ik1vakRIS2Jxb2dwWmVrL2FYdUQ4c1E9PSIsInZhbHVlIjoiaW8wR2xlMTFaUk8rVnEvZ0tLalJCN2lSd1NVUXZtbFJFeFR3b3p5MjNyYmxmcEJKRy85SVR2Y1AxWUVqWUdoT2s4UE5rM3ZTQjVhTWQrRnlRRy9HWldFQUdvcllwZ1FnanJJdVUvcjljdWkvemdMNE5ieEczOEtXYUMrQ1oyczUiLCJtYWMiOiJmYTA4NzAxYmRiYTBkYmI2NzM4ZmI2MTQwMDBlZTc3MTZkMmUzMzAzNWIyOTM0NGMwY2YyNmVjYjIxYjg4NzEwIiwidGFnIjoiIn0%3D'
    };
    var request = http.MultipartRequest('GET',
        Uri.parse('https://ayolapor-api.evolve-innovation.com/api/report'));
    request.fields.addAll({
      // 'status':  json.encode(['Need Approve By Kemahasiswaan', 'Report Process By Kemahasiswaan','Report Rejected By Kemahasiswaan']),
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      Map<String, dynamic> decodedBody = json.decode(responseBody);

      setState(() {
        reports = decodedBody['data'];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
            Navigator.pop(context);
          },
        ),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 50, // Mengatur tinggi tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BuatLaporanPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text(
                  'Tambah Laporan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16.0), // Tambahkan jarak antara tombol dan list
            Expanded(
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (BuildContext context, int index) {
                  var report = reports[index];
                  return buildOption(
                    context,
                    report['title'] +
                        ' - ' +
                        report['first_name'] +
                        ' ' +
                        report['last_name'],
                    Icons.more_vert,
                    report['created_at'],
                    report['status'],
                    report['id'].toString(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOption(BuildContext context, String text, IconData icon,
      String date, String status, String id) {
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
            SizedBox(
              height: 10,
            ),
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
        trailing: GestureDetector(
          child: Icon(
            icon,
            color: Colors.red,
            size: 24,
          ),
          onTap: () => {_showOptions(context, id)},
        ),
      ),
    );
  }

  void _showOptions(BuildContext context, String id) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.search),
                title: Text('Detail'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailLaporan("Detail", id),
                    ),
                  ).then((value) {
                    // Reload data after returning from the detail page
                    fetchReports();
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  _deleteReport(id);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteReport(String id) async {
  try {
      var url = Uri.parse('${GlobalsConfig.url_api}report/$id');
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        // Handle success, maybe show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Laporan deleted successfully'),
          ),
        );
        // Optionally, you can refresh the list after deletion
        fetchReports();
      } else {
        // Handle error, maybe show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete laporan'),
          ),
        );
      }
    } catch (error) {
      // Handle error, maybe show an error message
      print('Error deleting laporan: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
}

}
