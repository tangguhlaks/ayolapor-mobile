import 'package:flutter/material.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke tampilan sebelumnya
          },
        ),
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
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey, // Replace with actual image
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.red),
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
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
              color: Colors.grey,
            ),
          ),
          Text(
            'Mahasiswa',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
          //USERNAME
          SizedBox(height: 24),
          Text(
            'Username',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey, // White background color
              borderRadius:
                  BorderRadius.circular(10.0), // Optional: rounded corners
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15.0), // Padding inside the container
              child: TextField(
                // controller: _passwordController,
                enabled: false,
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
            decoration: BoxDecoration(
              color: Colors.grey, // White background color
              borderRadius:
                  BorderRadius.circular(10.0), // Optional: rounded corners
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15.0), // Padding inside the container
              child: TextField(
                // controller: _passwordController,
                enabled: false,
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
            decoration: BoxDecoration(
              color: Colors.grey, // White background color
              borderRadius:
                  BorderRadius.circular(10.0), // Optional: rounded corners
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15.0), // Padding inside the container
              child: TextField(
                // controller: _passwordController,
                enabled: false,
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
            decoration: BoxDecoration(
              color: Colors.grey, // White background color
              borderRadius:
                  BorderRadius.circular(10.0), // Optional: rounded corners
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15.0), // Padding inside the container
              child: TextField(
                // controller: _passwordController,
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Class',
                  border: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
