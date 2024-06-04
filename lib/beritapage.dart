import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ayolapor/newspage.dart';
import 'package:ayolapor/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'GlobalConfig.dart';


class BeritaPage extends StatefulWidget {
  @override
  _BeritaPageState createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  late Future<Map<String, dynamic>> _responseData;

  @override
  void initState() {
    super.initState();
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
                              SizedBox(
                                  width:
                                      8), // Add some spacing between PopupMenuButton and left edge
                              PopupMenuButton(
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'Detail',
                                    child: Text('Detail'),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == 'Detail') {
                                    // Navigation to EditBerita
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                          NewsPage(judul:berita['title'] , gambar: berita['image'], deskripsi: berita['description'])
                                      ),
                                    ).then((value) {
                                      // Reload data after returning from the edit page
                                      setState(() {
                                        _responseData = fetchData();
                                      });
                                    });
                                  }
                                },
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}