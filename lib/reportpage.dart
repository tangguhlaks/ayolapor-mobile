import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<String> items = ['Pelecehan', 'Seksual', 'Bullying'];
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buat Laporan',
          style: TextStyle(
              color: Color.fromARGB(255, 229, 75, 75),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
              color: Color.fromARGB(255, 229, 75, 75), size: 24),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.announcement,
                color: Color.fromARGB(255, 229, 75, 75), size: 24),
            onPressed: () {},
          )
        ],
        elevation: 4,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Jenis Laporan:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  iconEnabledColor: Color.fromARGB(255, 229, 75, 75),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: 3, color: Colors.grey),
                    ),
                  ),
                  value: selectedItem,
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 229, 75, 75))),
                          ))
                      .toList(),
                  onChanged: (item) {
                    setState(() {
                      selectedItem = item;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implement your button action here
                    },
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text('Upload Bukti',
                        style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(148, 31)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 229, 75, 75)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Upload File Kamu',
                  ),
                ),
                SizedBox(
                  height: 112,
                  width: 358,
                ),
                Text(
                  'Keterangan:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 132,
                  width: 358,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Implement your first button action here
                  },
                  child: Text('Save As Draft'),
                  style: ButtonStyle(
                    minimumSize:
                          MaterialStateProperty.all<Size>(Size(541, 41)), 
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Implement your second button action here
                  },
                  child: Text('Simpan & Laporkan'),
                  style: ButtonStyle(
                    minimumSize:
                          MaterialStateProperty.all<Size>(Size(541, 41)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 229, 75, 75), 
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
