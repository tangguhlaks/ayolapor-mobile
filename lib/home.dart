import 'package:ayolapor/beritapage.dart';
import 'package:ayolapor/homepage.dart';
import 'package:ayolapor/reportpage.dart';
import 'package:ayolapor/reportpagedosenwali.dart';
import 'package:ayolapor/reportpagekemahasiswaan.dart';
import 'package:ayolapor/settingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'reportpage.dart'; // Import the HomePage widget from homepage.dart
import 'reportpagedosenwali.dart'; // Import the HomePage widget from homepage.dart
import 'reportpagekemahasiswaan.dart'; // Import the HomePage widget from homepage.dart
import 'beritapagekms.dart'; // Import the HomePage widget from homepage.dart
import 'main.dart'; // Import the HomePage widget from homepage.dart

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that plugins are initialized
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');
  String? role = prefs.getString('role');

  runApp(MaterialApp(
    home: username != null && role != null ? Home() : LoginScreen(),
    debugShowCheckedModeBanner: false, // Remove debug banner
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username = '';
  String role = '';

  @override
  void initState() {
    super.initState();
    _getDataSession();
  }

  _getDataSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
      role = prefs.getString('role') ?? '';
    });
  }

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions(String role) {
    switch (role) {
      case 'Dosen Wali':
        return <Widget>[
          HomePage(userRole: 'Dosen Wali'),
          ReportPageDosenWali(),
          BeritaPage(),
          SettingPage(),
        ];
      case 'Kemahasiswaan':
        return <Widget>[
          HomePage(userRole: 'Kemahasiswaan'),
          ReportPageKemahasiswaan(),
          BeritaPageKms(),
          SettingPage(),
        ];
      default:
        return <Widget>[
          HomePage(userRole: 'Mahasiswa'),
          ReportPage(),
          BeritaPage(),
          SettingPage(),
        ];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions(role)[_selectedIndex],
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder),
              label: 'Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.new_releases),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
