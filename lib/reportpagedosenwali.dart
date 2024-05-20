import 'package:ayolapor/detaillaporandosenwali.dart';
import 'package:flutter/material.dart';
import 'package:ayolapor/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ReportPageDosenWali extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReportPageDosenWaliState();
}

class Report {
  String reporter;
  String date;
  String status;

  Report({required this.reporter, required this.date, required this.status});

  Map<String, String> toMap() {
    return {
      'reporter': reporter,
      'date': date,
      'status': status,
    };
  }

  static Report fromMap(Map<String, String> map) {
    return Report(
      reporter: map['reporter']!,
      date: map['date']!,
      status: map['status']!,
    );
  }
}

class ReportPageDosenWaliState extends State<ReportPageDosenWali> {
  List<Report> listReport = [];

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  void _loadReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedReports = prefs.getStringList('reports');
    if (savedReports != null) {
      setState(() {
        listReport = savedReports
            .map((reportStr) => Report.fromMap(Map<String, String>.from(
                json.decode(reportStr))))
            .toList();
      });
    } else {
      setState(() {
        listReport = [
          Report(
              reporter: 'Tangguh Laksana',
              date: '17 Mei 2023',
              status: 'Menunggu Tindak Lanjut Dosen Wali'),
          Report(
              reporter: 'Tangguh Laksana',
              date: '12 Mei 2023',
              status: 'Menunggu Tindak Lanjut Dosen Wali'),
          Report(
              reporter: 'Tangguh Laksana',
              date: '20 Mei 2023',
              status: 'Menunggu Tindak Lanjut Dosen Wali'),
          Report(
              reporter: 'Tangguh Laksana',
              date: '15 Mei 2023',
              status: 'Menunggu Tindak Lanjut Dosen Wali'),
          Report(
              reporter: 'Tangguh Laksana',
              date: '21 Mei 2023',
              status: 'Menunggu Tindak Lanjut Dosen Wali'),
        ];
      });
    }
  }

  void _saveReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> reportsToSave =
        listReport.map((report) => json.encode(report.toMap())).toList();
    await prefs.setStringList('reports', reportsToSave);
  }

  void updateReportStatus(int index, String newStatus) {
    setState(() {
      listReport[index].status = newStatus;
    });
    _saveReports();
  }

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
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.red,
            size: 24,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),
        elevation: 4,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: listReport.length,
          itemBuilder: (context, index) {
            return buildOption(
              context,
              listReport[index].reporter,
              Icons.more_vert,
              listReport[index].date,
              listReport[index].status,
              index,
            );
          },
        ),
      ),
    );
  }

  Widget buildOption(BuildContext context, String text, IconData icon,
      String date, String status, int index) {
    Color statusColor = Colors.red;
    if (status == 'Selesai') {
      statusColor = Colors.green;
    } else if (status == 'Tolak Laporan') {
      statusColor = Colors.red;
    } else if (status == 'Tindak Lanjuti') {
      statusColor = Color.fromARGB(255, 151, 136, 3);
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
                    offset: Offset(0, 1),
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
          onTap: () {
            _showOptions(context, index);
          },
        ),
      ),
    );
  }

  void _showOptions(BuildContext context, int index) {
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
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailLaporanDosenWali(
                        type: "Tinjauan Laporan MHS",
                        reportIndex: index,
                        onStatusChanged: (newStatus) {
                          updateReportStatus(index, newStatus);
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
