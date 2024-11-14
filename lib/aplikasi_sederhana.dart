import 'package:flutter/material.dart';

class AplikasiSederhana extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengelompokan Nilai Siswa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _calculateGrade() {
    setState(() {
      String input = _controller.text;
      // Validasi input
      if (input.isEmpty) {
        _showError('Masukkan nilai siswa!');
        return;
      }

      try {
        double nilai = double.parse(input);
        if (nilai < 0 || nilai > 100) {
          _showError('Nilai harus antara 0 dan 100.');
        } else {
          // Pengelompokan nilai
          if (nilai >= 85) {
            _result = 'Kategori: A';
          } else if (nilai >= 70) {
            _result = 'Kategori: B';
          } else if (nilai >= 55) {
            _result = 'Kategori: C';
          } else {
            _result = 'Kategori: D';
          }
        }
      } catch (e) {
        _showError('Input harus berupa angka.');
      }
    });
  }

  // Fungsi untuk menampilkan pesan error
  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengelompokan Nilai Siswa'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Masukkan Nilai Siswa',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nilai (0-100)',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
                prefixIcon: Icon(Icons.school, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _calculateGrade,
              icon: Icon(Icons.calculate),
              label: Text('Hitung'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
