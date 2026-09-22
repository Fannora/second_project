import 'package:flutter/material.dart';

import 'dart:math'; // Mengimpor konstanta pi

void main() {
  runApp(
    const MaterialApp(
      home: MainScreen(),
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
    ),
  );
}

// Widget Utama untuk Navigasi Halaman
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    KalkulatorLingkaran(),
    KalkulatorPersegiPanjang(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_outlined),
            activeIcon: Icon(Icons.circle),
            label: 'Lingkaran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.crop_landscape),
            activeIcon: Icon(Icons.rectangle),
            label: 'Persegi Panjang',
          ),
        ],
      ),
    );
  }
}

// Halaman 1: Kalkulator Lingkaran
class KalkulatorLingkaran extends StatefulWidget {
  const KalkulatorLingkaran({Key? key}) : super(key: key);

  @override
  State<KalkulatorLingkaran> createState() => _KalkulatorLingkaranState();
}

class _KalkulatorLingkaranState extends State<KalkulatorLingkaran> {
  // Controller untuk menangkap input jari-jari
  final TextEditingController _jariJariController = TextEditingController();

  // Variabel untuk menyimpan hasil
  double _luas = 0;
  double _keliling = 0;

  // Fungsi untuk memproses perhitungan
  void _hitung() {
    if (_jariJariController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jari-jari tidak boleh kosong!')),
      );
      return;
    }

    setState(() {
      double r = double.tryParse(_jariJariController.text) ?? 0;
      _luas = pi * r * r;
      _keliling = 2 * pi * r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Lingkaran'),
        backgroundColor: const Color.fromARGB(255, 248, 13, 13),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Masukkan Panjang Jari-Jari (r):',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _jariJariController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Misal: 7 atau 10.5',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calculate),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _hitung,
                child: const Text('HITUNG', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    'Luas: ${_luas.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Keliling: ${_keliling.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman 2: Kalkulator Persegi Panjang
class KalkulatorPersegiPanjang extends StatefulWidget {
  const KalkulatorPersegiPanjang({Key? key}) : super(key: key);

  @override
  State<KalkulatorPersegiPanjang> createState() =>
      _KalkulatorPersegiPanjangState();
}

class _KalkulatorPersegiPanjangState extends State<KalkulatorPersegiPanjang> {
  // Controller untuk input panjang dan lebar
  final TextEditingController _panjangController = TextEditingController();
  final TextEditingController _lebarController = TextEditingController();

  // Variabel untuk menyimpan hasil
  double _luas = 0;
  double _keliling = 0;

  // Fungsi untuk memproses perhitungan persegi panjang
  void _hitung() {
    if (_panjangController.text.trim().isEmpty ||
        _lebarController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Panjang dan Lebar tidak boleh kosong!')),
      );
      return;
    }

    setState(() {
      double p = double.tryParse(_panjangController.text) ?? 0;
      double l = double.tryParse(_lebarController.text) ?? 0;
      _luas = p * l;
      _keliling = 2 * (p + l);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Persegi Panjang'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text('Masukkan Panjang (p):', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _panjangController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Misal: 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.straighten),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Masukkan Lebar (l):', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _lebarController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Misal: 5',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.square_foot),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _hitung,
                child: const Text('HITUNG', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    'Luas: ${_luas.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Keliling: ${_keliling.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
