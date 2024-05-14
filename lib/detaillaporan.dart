import 'package:flutter/material.dart';

class DetailLaporan extends StatelessWidget {
  String type = "";
  DetailLaporan(String type){
    this.type = type;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          type,
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
        elevation: 4,
      ),
      body: DetailLaporanBody(),
    );
  }
    
 Widget DetailLaporanBody() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text("Judul Laporan",style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius:
                  BorderRadius.circular(10.0), // Optional: rounded corners
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
              horizontal: 15.0), // Padding inside the container
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Saya dilecehkan di gedung TULT',
                  border: InputBorder.none, // Optional: remove border
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text("Jenis Laporan",style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius:
                  BorderRadius.circular(10.0), // Optional: rounded corners
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
              horizontal: 15.0), // Padding inside the container
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Pelecehan',
                  border: InputBorder.none, // Optional: remove border
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text("Bukti",style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Image(image: AssetImage("assets/berita.jpg")),
          SizedBox(height: 10),
          Text("Keterangan",style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius:
                  BorderRadius.circular(10.0), // Optional: rounded corners
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
              horizontal: 15.0), // Padding inside the container
              child: TextField(
                minLines: 5, // Jumlah minimal baris
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Saya dilecehkan di toilet TULT',
                  border: InputBorder.none, // Optional: remove border
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

