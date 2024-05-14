import 'package:flutter/material.dart';
import 'package:ayolapor/buatlaporan.dart';
import 'package:ayolapor/home.dart';
import 'package:ayolapor/detaillaporan.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _page = 1; // Nomor halaman

  List<String> _reportData = [
    // Data laporan Anda
    'Lord Tangguh - 20 Mei 2023 - Menunggu Tindak Lanjut Kemahasiswaan',
    'Lord Tangguh - 20 Mei 2023 - Menunggu Tindak Lanjut Dosen Wali',
    'Lord Tangguh - 20 Mei 2023 - Sudah Ditindak Lanjut Dosen Wali',
    'Lord Tangguh - 20 Mei 2023 - Save Draft',
    'Lord Tangguh - 20 Mei 2023 - Selesai',
    'Lord Tangguh - 20 Mei 2023 - Laporan Dibatalkan',
    'Lord Tangguh - 20 Mei 2023 - Menunggu Tindak Lanjut Kemahasiswaan',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulasi penambahan data dengan delay 2 detik
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _page++; // Tambah halaman
        // Tambah data laporan baru ke dalam _reportData
        _reportData.addAll([
            'Lord Tangguh - 20 Mei 2023 - Sudah Ditindak Lanjut Dosen Wali',
            'Lord Tangguh - 20 Mei 2023 - Save Draft',
            'Lord Tangguh - 20 Mei 2023 - Selesai',
            'Lord Tangguh - 20 Mei 2023 - Laporan Dibatalkan',
            'Lord Tangguh - 20 Mei 2023 - Menunggu Tindak Lanjut Kemahasiswaan',
            'Lord Tangguh - 20 Mei 2023 - Laporan Dibatalkan',
            'Lord Tangguh - 20 Mei 2023 - Menunggu Tindak Lanjut Kemahasiswaan',
        ]);
      });
    }
  }
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
    ),
    body: Column(
      children: [
        Padding(padding: const EdgeInsets.all(16.0),
        child:SizedBox(
          width: double.infinity,
          height: 50, // Mengatur tinggi tombol
          child: ElevatedButton(
            onPressed: ()=>{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BuatLaporanPage()),
              )
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red)),
            child: Text(
              'Tambah Laporan',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        ),
        SizedBox(height: 2),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _reportData.length + (_isLoading ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index == _reportData.length) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return buildOption(context, _reportData[index]);
                }
              },
            ),
          ),
        ),
      ],
    ),
  );
}


  Widget buildOption(BuildContext context, String data) {
    // Pisahkan data menjadi komponen yang sesuai
    List<String> reportComponents = data.split(' - ');
    String text = reportComponents[0];
    String date = reportComponents[1];
    String status = reportComponents[2];

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
        title: Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: TextStyle(fontWeight: FontWeight.w100)),
            SizedBox(height: 10),
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
          child: Icon(Icons.more_vert, color: Colors.red, size: 24),
          onTap: () {
            _showOptions(context);
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
            children: [
              ListTile(
                leading: Icon(Icons.search),
                title: Text('Detail'),
                onTap: () {
                  // Handle detail option
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
