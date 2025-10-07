import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Data Mahasiswa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const FormMahasiswaScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FormMahasiswaScreen extends StatefulWidget {
  const FormMahasiswaScreen({super.key});

  @override
  State<FormMahasiswaScreen> createState() => _FormMahasiswaScreenState();
}

class _FormMahasiswaScreenState extends State<FormMahasiswaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _npmController = TextEditingController();
  final _emailController = TextEditingController();
  final _noHpController = TextEditingController();
  String? _jenisKelamin;

  final List<String> _listJenisKelamin = ['Laki-laki', 'Perempuan'];

  @override
  void dispose() {
    _namaController.dispose();
    _npmController.dispose();
    _emailController.dispose();
    _noHpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Input Data Mahasiswa'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _npmController,
                  decoration: const InputDecoration(
                    labelText: 'NPM',
                    prefixIcon: Icon(Icons.badge_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'NPM tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    hintText: 'contoh@student.unsika.ac.id',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Masukkan format email yang valid';
                    }
                    if (!value.endsWith('@unsika.ac.id')) {
                      return 'Hanya domain @unsika.ac.id yang diperbolehkan';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _noHpController,
                  decoration: const InputDecoration(
                    labelText: 'Nomor HP',
                    prefixIcon: Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(),
                    hintText: 'Contoh: 081234567890',
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor HP tidak boleh kosong';
                    }
                    if (value.length < 10) {
                      return 'Nomor HP minimal harus 10 digit';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: _jenisKelamin,
                  decoration: const InputDecoration(
                    labelText: 'Jenis Kelamin',
                    prefixIcon: Icon(Icons.wc_outlined),
                    border: OutlineInputBorder(),
                  ),
                  hint: const Text('Pilih Jenis Kelamin'),
                  items: _listJenisKelamin.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _jenisKelamin = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan pilih jenis kelamin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Data Tersimpan'),
                          content: const Text(
                              'Data mahasiswa berhasil divalidasi dan disimpan.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.save_alt_outlined),
                  label: const Text('Simpan Data'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}