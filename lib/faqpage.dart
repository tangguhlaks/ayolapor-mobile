import 'package:flutter/material.dart';

void main() {
  runApp(FaqPage());
}

class FaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQ',
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
      body: FaqList(), // Menggunakan widget FaqList untuk menampilkan daftar FAQ
    );
  }
}

class FaqList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView( // Menggunakan ListView untuk membuat daftar FAQ scrollable
      padding: EdgeInsets.all(16),
      children: [
        FaqItem(
          question: 'Bagaimana cara melawan tindak pelecehan?',
          answer: 'Anda harus melaporkan yang anda alami',
        ),
        FaqItem(
          question: 'Bagaimana cara mencegah tindak pelecehan?',
          answer: 'Anda perlu waspada dan berhati hati',
        ),
        // Tambahkan item FAQ sesuai kebutuhan
      ],
    );
  }
}

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const FaqItem({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile( // Menggunakan ExpansionTile untuk item FAQ agar bisa di-expand
      title: Text(
        question,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
