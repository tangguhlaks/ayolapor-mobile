import 'dart:convert';

import 'package:ayolapor/GlobalConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailLaporanKemahasiswan extends StatefulWidget {
  final String type;
  final String id;
  final String status;

  DetailLaporanKemahasiswan(this.type,this.id,this.status);

  @override
  _DetailLaporanKemahasiswanState createState() =>
      _DetailLaporanKemahasiswanState();
}

class _DetailLaporanKemahasiswanState extends State<DetailLaporanKemahasiswan> {
  Map<String, dynamic> detailData = {};

  @override
  void initState() {
    fetchData();
  }
  Future<void> fetchData() async {
    var headers = {
      'Cookie': 'XSRF-TOKEN=eyJpdiI6ImhjekZVVFREM1k3QVkwUCtZUkVpc0E9PSIsInZhbHVlIjoibGJ6VjBDc3BIdVBLSHc4TXZabCtsaTFBOHp3RDYxSzdmZmpYdGtzY3NqVUFDeTdiZ05RbXF5UXI2TDhRdXNsT0dURGZFU3R5dnI0eVRsNTd0K0JIWmVsSTNmNHRNSmRjMUpjVDg3MnFScjFHNEw4T3ZYNzBadGdnZHk2RlUwdTIiLCJtYWMiOiI1ZTIxNGFkZDg0ZjBkYjg0NDI4NWJiZDYwMzhmZTQyYTQwMzZmNWI0MDllODVjOWZmZGViN2RmZTBhY2IzNTM1IiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ik1vakRIS2Jxb2dwWmVrL2FYdUQ4c1E9PSIsInZhbHVlIjoiaW8wR2xlMTFaUk8rVnEvZ0tLalJCN2lSd1NVUXZtbFJFeFR3b3p5MjNyYmxmcEJKRy85SVR2Y1AxWUVqWUdoT2s4UE5rM3ZTQjVhTWQrRnlRRy9HWldFQUdvcllwZ1FnanJJdVUvcjljdWkvemdMNE5ieEczOEtXYUMrQ1oyczUiLCJtYWMiOiJmYTA4NzAxYmRiYTBkYmI2NzM4ZmI2MTQwMDBlZTc3MTZkMmUzMzAzNWIyOTM0NGMwY2YyNmVjYjIxYjg4NzEwIiwidGFnIjoiIn0%3D'
    };
    var request = http.MultipartRequest('GET', Uri.parse(GlobalsConfig.url_api+'report/'+widget.id));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      Map<String, dynamic> decodedBody = json.decode(responseBody);

      setState(() {
        detailData = decodedBody['data'];
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

  void updateStatus(String status) async {
    var headers = {
      'Cookie': 'XSRF-TOKEN=eyJpdiI6Ind1dHpicmgxZ2lSaGp0MjZTZ0hUWEE9PSIsInZhbHVlIjoiKzNoTE95WVFtaUhSVVRQakMwUDdUVmpUaHYrOTJsVEhGaTlmYVY5bmlncWVJZjJRYUNGN2szWlF1MFBaa080S3NFUytVZlduSzZPeXprRjU2U0VZVDJTTHBKcW4wMHArdHE5MlJWRWYrUkN6NlF4Uzl0UDBIRW5PaWFOQkFzWUwiLCJtYWMiOiJhN2JmZjYzZjc5OTRiNGU5ZGQ1NzdjM2QyNTM1ZjBkMTE1MjNjN2UyMTU0NmE5NjdkYTZlNDA3ZTM2MjNiZjRhIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6ImdkM0k4MWJPbEYvYzJLNUt2dWN4Ync9PSIsInZhbHVlIjoiOThGU21wZld6THdLMTZQVnNyVURVOTZzUjV0U29OelJudmxHWVJyUHM1OUR0WUhOZURRQ2Z3YS9CNDNhS1NybUZiS2l2QTF3eFM1bjlkWnBCQ2V0Vkg2VlE5a21mcTVEdFhJSHo0WjgwUEVmSnU2ekdZQmRBaE9TVWVpYmd1QjMiLCJtYWMiOiJmZTI4MTlhYzBiZDJjZTc1YzgzNmRiZWVjOGMwOGU4MjEwMTY3NGY0ZTAzNmQzOGU4NWZhOGEwODNhNmU3MDgxIiwidGFnIjoiIn0%3D'
    };
    var request = http.MultipartRequest('PUT', Uri.parse(GlobalsConfig.url_api+'report-update-status/'+widget.id+'?status='+status));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Status Report Berhasil Diperbaharui',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
    else {
      print(response.reasonPhrase);
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Status Report Gagal Diperbaharui',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.type,
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
            Navigator.pop(context); // Navigate back
          },
        ),
        elevation: 4,
      ),
      body: DetailLaporanBody(),
    );
  }

  Widget DetailLaporanBody() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text("Title", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0), // Optional: rounded corners
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0), // Padding inside the container
                child: TextField(
                  decoration: InputDecoration(
                    labelText: detailData["title"],
                    border: InputBorder.none, // Optional: remove border
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Jenis Laporan", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0), // Optional: rounded corners
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0), // Padding inside the container
                child: TextField(
                  decoration: InputDecoration(
                    labelText: detailData["type"],
                    border: InputBorder.none, // Optional: remove border
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Bukti", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://ayolapor-api.evolve-innovation.com/assets/prove/${detailData['prove']}'), // Assuming 'image' is the key for the image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Keterangan", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0), // Optional: rounded corners
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0), // Padding inside the container
                child: TextField(
                  minLines: 5, // Jumlah minimal baris
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: detailData['description'],
                    border: InputBorder.none, // Optional: remove border
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (widget.status == "Submitted to Kemahasiswaan") ...[
            SizedBox(
              width: double.infinity,
              height: 50, // Mengatur tinggi tombol
              child: ElevatedButton(
                onPressed: () {
                  updateStatus("Rejected by Kemahasiswaan");
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                child: Text(
                  'Tolak Laporan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 50, // Mengatur tinggi tombol
              child: ElevatedButton(
                onPressed: () {
                  updateStatus("Processed by Kemahasiswaan");
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
                child: Text(
                  'Tindak Lanjuti',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ],
            SizedBox(height: 8),
            if (widget.status == "Processed by Kemahasiswaan") ...[
            SizedBox(
              width: double.infinity,
              height: 50, // Mengatur tinggi tombol
              child: ElevatedButton(
                onPressed: () {
                  updateStatus("Report Finish");
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
                child: Text(
                  'Selesai',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ]
          ],
        ),
      ),
    );
  }
}
