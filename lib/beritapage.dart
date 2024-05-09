<<<<<<< HEAD
import 'package:ayolapor/newspage.dart';
import 'package:flutter/material.dart';
=======
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ayolapor/newspage.dart';
import 'package:ayolapor/home.dart';
>>>>>>> 3460b8b0023483feb55c5eaf11a543caced2ce9e
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'GlobalConfig.dart';

class BeritaPage extends StatefulWidget {
  @override
  _BeritaPageState createState() => _BeritaPageState();
}

<<<<<<< HEAD
class _BeritaPageState extends State<BeritaPage> {
  late Future<Map<String, dynamic>> _responseData;
=======
class BeritaPage extends StatefulWidget {
  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {

  Map<String, dynamic> _futureNews = {};
>>>>>>> 3460b8b0023483feb55c5eaf11a543caced2ce9e

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    _responseData = fetchData();
  }

  Future<Map<String, dynamic>> fetchData() async {
    var url = Uri.parse(GlobalsConfig.url_api + 'news');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

=======
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
>>>>>>> 3460b8b0023483feb55c5eaf11a543caced2ce9e
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Berita',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.red,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
<<<<<<< HEAD
      body: FutureBuilder<Map<String, dynamic>>(
        future: _responseData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> beritaList = snapshot.data?['data'];
            return ListView.builder(
              itemCount: beritaList.length,
              itemBuilder: (context, index) {
                var berita = beritaList[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: GestureDetector(
                    onTap: () =>    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewsPage()), // Replace with your NewsPage name
                                    ),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://ayolapor-api.evolve-innovation.com/assets/news/${berita['image']}'), // Assuming 'image' is the key for the image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    berita[
                                        'title'], // Assuming 'judul' is the key for the title
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
=======
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
>>>>>>> 3460b8b0023483feb55c5eaf11a543caced2ce9e
        },
      ),
    );
  }
}

