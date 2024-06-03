import 'package:ayolapor/detaillaporankemahasiswaan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportPageKemahasiswaan extends StatefulWidget {
  @override
  _ReportPageKemahasiswaanState createState() =>
      _ReportPageKemahasiswaanState();
}

class _ReportPageKemahasiswaanState extends State<ReportPageKemahasiswaan> {
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
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://ayolapor-api.evolve-innovation.com/api/report-by-status'));
    request.fields.addAll({
      'status':  json.encode(['Submitted to Kemahasiswaan', 'Processed by Kemahasiswaan','Rejected by Kemahasiswaan','Finish']),
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
          'Report',
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
        child: ListView.builder(
          itemCount: reports.length,
          itemBuilder: (BuildContext context, int index) {
            var report = reports[index];
            return buildOption(
              context,
              report['title']+' - '+report['first_name']+' '+report['last_name'],
              Icons.more_vert,
              report['created_at'],
              report['status'],
              report['id'].toString()
            );
          },
        ),
      ),
    );
  }

  Widget buildOption(BuildContext context, String text, IconData icon,
      String date, String status,String id) {
    Color statusColor = Colors.red;
    if (status == 'Selesai' ||
        status == 'Sudah Ditindak Lanjut Dosen Wali') {
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
          onTap: () => {_showOptions(context,id,status)},
        ),
      ),
    );
  }

  void _showOptions(BuildContext context,String id,String status) {
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
                      builder: (context) => DetailLaporanKemahasiswan("Detail", id,status),
                    ),
                  ).then((value) {
                    // Reload data after returning from the detail page
                    fetchReports();
                    Navigator.pop(context);
                  });
                }
              ),
            ],
          ),
        );
      },
    );
  }
}
