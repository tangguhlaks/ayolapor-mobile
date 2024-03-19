import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('home_bg.png'), // Pastikan Anda memiliki file 'home_bg.png' dalam folder 'assets'
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
