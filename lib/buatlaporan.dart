import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

void main() {
  runApp(MaterialApp(
    home: BuatLaporan(),
    debugShowCheckedModeBanner: false,
  ));
}

class BuatLaporan extends StatefulWidget {
  const BuatLaporan({Key? key}) : super(key: key);

  @override
  State<BuatLaporan> createState() => _BuatLaporanState();
}

class _BuatLaporanState extends State<BuatLaporan>
    with SingleTickerProviderStateMixin {
  late AnimationController loadingController;
  List<String> items = ['Pelecehan', 'Seksual', 'Bullying'];
  String? selectedItem;

  File? _file;
  PlatformFile? _platformFile;

  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
      });
    }

    loadingController.forward();
  }

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        title: const Text(
          'Buat Laporan',
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
            Navigator.pop(context); // Kembali ke tampilan sebelumnya
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.announcement,
              color: Colors.red,
              size: 24,
            ),
            onPressed: () {},
          )
        ],
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Jenis Laporan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              iconEnabledColor: Colors.red,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(width: 3, color: Colors.red),
                ),
              ),
              value: selectedItem,
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (item) {
                setState(() {
                  selectedItem = item;
                });
              },
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: selectFile,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20.0),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  color: Colors.red.shade400,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.red.shade50.withOpacity(.3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.folder_open, color: Colors.red, size: 40),
                        const SizedBox(height: 15),
                        const Text(
                          'Upload Bukti Kamu',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_platformFile != null)
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selected File',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 3,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(_file!, width: 70),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _platformFile!.name,
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.black),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${(_platformFile!.size / 1024).ceil()} KB',
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  height: 5,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.red,
                                  ),
                                  child: LinearProgressIndicator(
                                    value: loadingController.value,
                                    backgroundColor: Colors.red.shade50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 150),
            Text(
              'Keterangan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tulis Keterangan Kamu',
                contentPadding: EdgeInsets.symmetric(vertical: 20.0),
              ),
              minLines: 5, // Jumlah minimal baris
              maxLines:
                  null, // Atur ke null agar bisa menambahkan lebih dari 5 baris
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Data disimpan sebagai draft'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: Text(
                'Save As Draft',
                style: TextStyle(color: Colors.red),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(541, 41)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Data berhasil disimpan dan dilaporkan'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: Text(
                'Simpan & Laporkan',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(541, 41)),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
