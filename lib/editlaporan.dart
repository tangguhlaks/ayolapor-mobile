import 'dart:convert';
import 'dart:io';
import 'package:ayolapor/GlobalConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class EditLaporan extends StatefulWidget {
  final String type;
  final String id;

  EditLaporan(this.type, this.id);

  @override
  _EditLaporanState createState() => _EditLaporanState();
}

class _EditLaporanState extends State<EditLaporan> {
  Map<String, dynamic> editData = {};
  TextEditingController titleController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<String> _pilihan = ['Seksual', 'Bullying', 'Kekerasan Fisik'];
  String? _selectedType;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var headers = {
      'Cookie': 'XSRF-TOKEN=your_token_here; laravel_session=your_session_here'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse(GlobalsConfig.url_api + 'report/' + widget.id));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      Map<String, dynamic> decodedBody = json.decode(responseBody);

      setState(() {
        editData = decodedBody['data'];
        titleController.text = editData['title'];
        typeController.text = editData['type'];
        descriptionController.text = editData['description'];
        _selectedType = editData['type'];
        _filePath = editData['prove'];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  void updateData() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'XSRF-TOKEN=your_token_here; laravel_session=your_session_here'
    };
    var request = http.MultipartRequest(
        'PUT', Uri.parse(GlobalsConfig.url_api + 'report/' + widget.id));

    request.headers.addAll(headers);

    request.fields['title'] = titleController.text;
    request.fields['type'] = _selectedType!;
    request.fields['description'] = descriptionController.text;

    if (_filePath != null) {
      try {
        final file = File(_filePath!);
        if (await file.exists()) {
          print("File exists: $_filePath");
          request.files
              .add(await http.MultipartFile.fromPath('prove', _filePath!));
        } else {
          print("File not found: $_filePath");
        }
      } catch (e) {
        print("Error accessing file: $e");
      }
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("Update successful");
      final responseBody = await response.stream.bytesToString();
      print("Response body: $responseBody");
    } else {
      print("Update failed: ${response.reasonPhrase}");
      final responseBody = await response.stream.bytesToString();
      print("Response body: $responseBody");
    }
  }

  void _selectImage() async {
    if (_filePath != null) {
      try {
        final file = File(_filePath!);
        if (await file.exists()) {
          await file.delete();
          print("Deleted old file: $_filePath");
        }
      } catch (e) {
        print("Error deleting old file: $e");
      }
    }

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
                      _filePath = result.files.single.path;
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
      body: EditLaporanBody(),
    );
  }

  Widget EditLaporanBody() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text("Judul", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Container(
              width: double.infinity, // Full width
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Jenis Laporan",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Container(
              width: double.infinity, // Full width
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedType,
                    items: _pilihan.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedType = newValue;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Bukti", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            GestureDetector(
              onTap: _selectImage,
              child: Container(
                width: double.infinity, // Full width
                height: 150,
                decoration: BoxDecoration(
                  image: _filePath != null
                      ? DecorationImage(
                          image: File(_filePath!).existsSync()
                              ? FileImage(File(_filePath!))
                              : NetworkImage(
                                      'https://ayolapor-api.evolve-innovation.com/assets/prove/$_filePath')
                                  as ImageProvider,
                          fit: BoxFit.cover,
                        )
                      : null,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: _filePath == null
                    ? Center(child: Text("Tap to select image"))
                    : null,
              ),
            ),
            SizedBox(height: 10),
            Text("Keterangan", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Container(
              width: double.infinity, // Full width
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  controller: descriptionController,
                  minLines: 5,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: updateData, // Update data input
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Hanya kembali ke halaman sebelumnya
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  'Kembali',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
