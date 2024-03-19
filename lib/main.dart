import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('background_image.jpg'), // Replace 'background_image.jpg' with your image file path
            fit: BoxFit.cover,
          ),
        ),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'Mahasiswa';
  List<String> _roles = ['Mahasiswa', 'Dosen Wali', 'Kemahasiswaan'];

  void _login() {
    // Implement your login logic here
    String username = _usernameController.text;
    String password = _passwordController.text;
    print('$_selectedRole username: $username, Password: $password');
    // Example: Validate and send login request to server
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7.0)
            ),
            width: 200,
            child: Image(image: AssetImage("logo.png")),
          ),
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0), // Padding between dropdown and text fields
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background color
                borderRadius: BorderRadius.circular(10.0), // Optional: rounded corners
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0), // Padding inside the container
                child: DropdownButtonFormField(
                  value: _selectedRole,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedRole = newValue.toString();
                    });
                  },
                  items: _roles.map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // White background color
              borderRadius: BorderRadius.circular(10.0), // Optional: rounded corners
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0), // Padding inside the container
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: InputBorder.none, // Optional: remove border
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // White background color
              borderRadius: BorderRadius.circular(10.0), // Optional: rounded corners
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0), // Padding inside the container
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: InputBorder.none, // Optional: remove border
                ),
                obscureText: true,
              ),
            ),
          ),
          SizedBox(height: 20),
         SizedBox(
          width: double.infinity,
          height: 50, // Mengatur tinggi tombol
          child: ElevatedButton(
            onPressed: _login,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
              ),
            child: Text('Login',
                    style: TextStyle(
                      color: Colors.white
                    ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
    debugShowCheckedModeBanner: false, // Remove debug banner
  ));
}
