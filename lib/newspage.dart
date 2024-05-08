import 'package:flutter/material.dart';



class NewsPage extends StatelessWidget {
  final String judul, gambar, deskripsi;
  const NewsPage({super.key, required this.judul, required this.gambar, required this.deskripsi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Berita Hari Ini',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NewsForm(judul: judul, gambar: gambar, deskripsi: deskripsi),
      ),
    );
  }
}

class NewsForm extends StatefulWidget {
  final String judul, gambar, deskripsi;
  const NewsForm({super.key, required this.judul, required this.gambar, required this.deskripsi});
  @override
  _NewsFormState createState() => _NewsFormState();
}

class _NewsFormState extends State<NewsForm> {

  @override
  Widget build(BuildContext context) {
  return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Judul utama
            Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                widget.judul,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            // Gambar berita
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: widget.gambar != null
                  ? Image.network(
                      widget.gambar,
                      fit: BoxFit.cover,
                    )
                  : Placeholder(), // Placeholder jika gambar tidak tersedia
            ),
            SizedBox(height: 16.0), // Spasi antara field
            // Deskripsi berita
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                widget.deskripsi ?? 'Content not available',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        );
}
}
