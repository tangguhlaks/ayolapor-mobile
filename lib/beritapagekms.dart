import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'tambahberita.dart'; // Import the tambahberita.dart file
import 'newspage.dart'; // Import the news_page.dart file
import 'editberita.dart'; // Import the editberita.dart file
import 'GlobalConfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BeritaPageKms(),
    );
  }
}

class BeritaPageKms extends StatefulWidget {
  @override
  _BeritaPageKmsState createState() => _BeritaPageKmsState();
}

class _BeritaPageKmsState extends State<BeritaPageKms> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to TambahBeritaPage when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahBeritaPage()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
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
                              PopupMenuButton(
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'detail',
                                    child: Text('Detail'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == 'detail') {
                                    // Navigation to NewsPage
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewsPage()), // Replace with your NewsPage name
                                    );
                                  } else if (value == 'edit') {
                                    // Navigation to EditBerita
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditBeritaForm(id : berita['id'])), // Replace with your EditBerita name
                                    );
                                  } else if (value == 'delete') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Delete Berita"),
                                          content: const Text(
                                              "Are you sure you want to delete this berita?"),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Call the deleteBerita function and pass the berita ID
                                                deleteBerita(berita['id']);
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
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

  void deleteBerita(int id) async {
    try {
      var url = Uri.parse('${GlobalsConfig.url_api}news/$id');
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        // Handle success, maybe show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berita deleted successfully'),
          ),
        );
        // Optionally, you can refresh the list after deletion
        fetchData();
      } else {
        // Handle error, maybe show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete berita'),
          ),
        );
      }
    } catch (error) {
      // Handle error, maybe show an error message
      print('Error deleting berita: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }
}
