import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'GlobalConfig.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  FirebaseMessaging.instance.subscribeToTopic('report_submitted');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambah Laporan',
      theme: ThemeData(
        primaryColor: Colors.red, // Menggunakan primary color merah
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BuatLaporanPage(),
    );
  }
}

class BuatLaporanPage extends StatelessWidget {
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
        child: BuatLaporanForm(),
      ),
    );
  }
}

class BuatLaporanForm extends StatefulWidget {
  @override
  _BuatLaporanFormState createState() => _BuatLaporanFormState();
}

class _BuatLaporanFormState extends State<BuatLaporanForm> {
  // Controllers untuk field input
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();
  String? fileName = '';
  String? _filePath;

  // Pilihan untuk dropdown
  List<String> _pilihan = ['Seksual', 'Bullying', 'Kekerasan Fisik'];

  // Method untuk menghandle submit form
Future<void> _submitForm(String status) async {
  String judul = _judulController.text;
  String type = _typeController.text;
  String isi = _isiController.text;
  String? imagePath = _filePath; // Assuming _filePath stores the path of the selected image

  // Create a multipart request
  var request = http.MultipartRequest('POST', Uri.parse(GlobalsConfig.url_api + 'report'));

  // Add form fields
  request.fields['title'] = judul;
  request.fields['type'] = type;
  request.fields['mahasiswa'] = '1';

  // Set status based on the parameter
  if (status == 'draft') {
    request.fields['status'] = "Save as Draft";
  } else if (status == 'submitted') {
    request.fields['status'] = "Submitted to Dosen Wali";
  }

  request.fields['dosen_wali'] = '3';
  request.fields['description'] = isi;

  // Add image file
  if (imagePath != null) {
    String fileName = path.basename(imagePath);
    var imageFile = await http.MultipartFile.fromPath('prove', imagePath);
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
    prefs.setString('image', path.basename(imagePath!));
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Laporan Berhasil Dibuat',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  } else {
    print(responseBody);
  }

  setState(() {
    _filePath = null;
    _judulController.clear();
    _typeController.clear();
    _isiController.clear();
  });
}

  // Method to handle image selection
  void _selectImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );
                  if (result != null) {
                    setState(() {
                      _filePath = result.files.single.path!;
                    });
                  }
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _filePath = pickedFile.path;
                    });
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Input judul
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
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold, // Membuat teks label menjadi tebal
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        // Input jenis laporan
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: DropdownButtonFormField<String>(
            value:
                _typeController.text.isNotEmpty ? _typeController.text : null,
            items: _pilihan.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _typeController.text = value!;
              });
            },
            decoration: InputDecoration(
              labelText: 'Jenis Laporan',
              contentPadding: EdgeInsets.all(8.0),
              border: InputBorder.none,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold, // Membuat teks label menjadi tebal
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        // Upload Image
        InkWell(
          onTap: _selectImage, // Call _selectImage when tapped
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: _filePath != null
                ? Image.file(
                    File(_filePath!),
                    fit: BoxFit.cover,
                  )
                : Icon(
                    Icons.add_a_photo,
                    size: 48,
                    color: Colors.grey,
                  ),
          ),
        ),
        SizedBox(height: 16.0), // Spasi antara field
        // Input isi berita
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              TextField(
                controller: _isiController,
                minLines: 5, // Minimal 5 baris
                maxLines: null, // Maksimum baris tidak terbatas
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0), // Sesuaikan padding
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold, // Teks label menjadi tebal
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior
                      .always, // Membuat label selalu di atas
                  labelText: 'Tuliskan Keterangan',
                ),
                textAlignVertical: TextAlignVertical.top, // Geser teks ke atas
                keyboardType:
                    TextInputType.multiline, // Aktifkan input multiline
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0), // Spasi antara field
        // Tombol untuk submit
        ElevatedButton(
          onPressed: () => _submitForm('draft'),
          child: Text('Save As Draft', style: TextStyle(color: Colors.white)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
        ),
        ElevatedButton(
          onPressed: () => _submitForm('submitted'),
          child: Text('Submitted to Dosen Wali',
              style: TextStyle(color: Colors.white)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Kembali', style: TextStyle(color: Colors.white)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Clean up controller ketika widget di-dispose
    _judulController.dispose();
    _typeController.dispose();
    _isiController.dispose();
    super.dispose();
  }
}
