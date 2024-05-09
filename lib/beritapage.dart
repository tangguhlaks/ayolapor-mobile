import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ayolapor/newspage.dart';
import 'package:ayolapor/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BeritaPage(),
    );
  }
}

class BeritaPage extends StatefulWidget {
  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {

  Map<String, dynamic> _futureNews = {};

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  void fetchNews() async {
    final response = await http.get(Uri.parse('https://ayolapor-api.evolve-innovation.com/api/news'));
    debugPrint('Response: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic>? responseData = json.decode(response.body);
      _futureNews =  responseData ?? {}; // Jika responseData null, kembalikan objek kosong
      setState(() {});
    } else {
      throw Exception('Failed to load news');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Berita',
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
            ); // Menggunakan Navigator.pushNamed
          },
        ),
        elevation: 4,
        automaticallyImplyLeading: false,
      ),
      body: _futureNews.isEmpty? Center(child: CupertinoActivityIndicator(),):
       ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsPage(judul: _futureNews['data'][index]['title'], gambar: _futureNews['data'][index]['image'], deskripsi: _futureNews['data'][index]['description'])),
                );
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/berita.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        _futureNews['data'][index]['title'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
