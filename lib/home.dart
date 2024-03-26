import 'package:ayolapor/reportpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
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

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions(String username) => <Widget>[
        Text(username),
        ReportPage(),
        Text('News Page'),
        Text('Setting Page'),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions(username)[_selectedIndex],
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
