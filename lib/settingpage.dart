import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        automaticallyImplyLeading: false, // Disable back button
        title: Container(
          padding: EdgeInsets.symmetric(
              vertical: 1, horizontal: 18), // Adjust padding
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10), // Adjust border radius
          ),
          child: Text(
            'Preferensi',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildOption('FAQ', Icons.arrow_forward),
            buildOption('Laporkan Bug & Saran', Icons.arrow_forward),
            buildToggleOption('Rekam Cepat'),
            buildToggleOption('Mode Gelap'),
            buildOption('Hubungi Kami', Icons.phone),
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

  Widget buildOption(String text, IconData icon) {
    return Container(
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
    );
  }

  Widget buildToggleOption(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        title: Text(text, style: TextStyle(color: Colors.red)),
        value: true,
        onChanged: (value) {
          // Handle toggle change
        },
        activeColor: Colors.red,
      ),
    );
  }
}
