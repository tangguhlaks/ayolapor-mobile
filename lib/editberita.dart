import 'dart:io';
import 'package:ayolapor/beritapagekms.dart';
import 'package:ayolapor/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'GlobalConfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Wrap with MaterialApp
      home: EditBeritaForm(),
    );
  }
}

class EditBeritaForm extends StatefulWidget {
  final int? id;

  const EditBeritaForm({Key? key, this.id}) : super(key: key);

  @override
  _EditBeritaFormState createState() => _EditBeritaFormState();
}

class _EditBeritaFormState extends State<EditBeritaForm> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();
  String? fileName = '';
  String? _filePath;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    // Fetch data from the API and populate the text fields
    fetchData();
  }

  Future<void> fetchData() async {
    var url = Uri.parse(
        'https://ayolapor-api.evolve-innovation.com/api/news/${widget.id}');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          _judulController.text = data['data']['title'];
          _isiController.text = data['data']['description'];
          _filePath =
              'https://ayolapor-api.evolve-innovation.com/assets/news/${data['data']['image']}'; // Set image path from data
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error gracefully, e.g., show a snackbar or error message to the user
    }
  }

  void _submitForm() async {
    String judul = _judulController.text;
    String isi = _isiController.text;
    String imagePath = _imageFile!
        .path; // Assuming _filePath stores the path of the selected image

    // Create a multipart request
    var request = http.MultipartRequest('POST',
        Uri.parse(GlobalsConfig.url_api + 'news-update' + '/${widget.id}'));

    // Add form fields
    request.fields['title'] = judul;
    request.fields['description'] = isi;

    // Add image file
    if (imagePath != null) {
      fileName = path.basename(imagePath);
      var imageFile = await http.MultipartFile.fromPath('image', imagePath);
      request.files.add(imageFile);
    }

    // Send the request
    var streamedResponse = await request.send();

    // Handle the response
    var response = await http.Response.fromStream(streamedResponse);
    var responseBody = json.decode(response.body);

    if (responseBody['status']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('title', judul);
      prefs.setString('description', isi);
      prefs.setString('title', judul);
      prefs.setString('image', fileName!);

      // Reload the data after editing
      fetchData();
    } else {}

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Berita Berhasil diedit',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      _filePath = null;
    });
  }

  void _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
        _filePath = null; // Set _filePath to null when image file is picked
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Berita',
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
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),

        elevation: 4,
        automaticallyImplyLeading: false, // Menghilangkan tombol back
      ),
      body:
      SingleChildScrollView(child:   
      Padding(padding: EdgeInsets.all(12),
        child: 
          Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InkWell(
              onTap: _selectImage,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _imageFile != null
                    ? Image.file(
                        // Use Image.file if _imageFile is not null
                        _imageFile!,
                        fit: BoxFit.cover,
                      )
                    : _filePath != null
                        ? Image.network(
                            // Use Image.network if _imageFile is null and _filePath is not null
                            _filePath!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.add_a_photo,
                            size: 48,
                            color: Colors.grey,
                          ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: _judulController,
                decoration: InputDecoration(
                  labelText: 'Judul',
                  contentPadding: EdgeInsets.all(8.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: _isiController,
                maxLines: null, // Maksimum baris tidak terbatas
                decoration: InputDecoration(
                  labelText: 'Isi Berita',
                  contentPadding: EdgeInsets.all(8.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Simpan Berita', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
          ],
        ),
      
        )
       )
      );
  }

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();
    super.dispose();
  }
}
