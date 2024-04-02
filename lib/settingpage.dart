import 'package:ayolapor/bugreportpage.dart';
import 'package:ayolapor/faqpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingPage(),
    );
  }
}

class SettingPage extends StatelessWidget {
  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Preferensi',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        automaticallyImplyLeading: false, // Menghilangkan tombol back
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildOption('FAQ', Icons.arrow_forward, context),
            buildOption('Laporkan Bug & Saran', Icons.arrow_forward, context),
            buildOption('Hubungi Kami', Icons.phone, context),
            buildOption('Profile', Icons.arrow_forward, context),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _logout(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.red,
              ),
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOption(String text, IconData icon, BuildContext context) {
    return InkWell(
      onTap: () {
        if (text == 'Profile') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        } else if (text == 'Laporkan Bug & Saran') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BugReportPage()),
          );
        } else if (text == 'FAQ') {
          // Tambahkan kondisi ini
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FaqPage()), // Navigasi ke halaman FaqPage
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          title: Text(text, style: TextStyle(color: Colors.red)),
          trailing: Icon(icon, color: Colors.red, size: 20),
        ),
      ),
    );
  }
}
