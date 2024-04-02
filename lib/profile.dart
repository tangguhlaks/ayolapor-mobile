import 'package:flutter/material.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
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
      body: UserProfile(),
    );
  }
}

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red, // Latar belakang merah
              borderRadius: BorderRadius.circular(
                  20), // Membuat sudut-sudut menjadi melengkung
            ),
            padding: EdgeInsets.all(16), // Padding kontainer
            child: Row(
              children: [
                ClipOval(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey, // Ganti dengan gambar sebenarnya
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor:
                          Colors.grey, // Ganti dengan gambar sebenarnya
                    ),
                  ),
                ),
                SizedBox(width: 16), // Jarak antara avatar dan teks
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tangguh Laksana',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '1302210025',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Mahasiswa',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          //USERNAME
          Text(
            'Username',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8), // Margin atas
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.red),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                enabled: false,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Admin',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          //FIRST NAME
          SizedBox(height: 24),
          Text(
            'First Name',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8), // Margin atas
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.red),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                enabled: false,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          //LAST NAME
          SizedBox(height: 24),
          Text(
            'Last Name',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8), // Margin atas
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.red),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                enabled: false,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          //CLASS
          SizedBox(height: 24),
          Text(
            'Class',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8), // Margin atas
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.red),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                enabled: false,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Class',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
